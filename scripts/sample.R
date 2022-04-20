rm(list=ls())   # clear out old junk then read in data

#first load some needed libraries
library("psych")
library("lessR")
library('mirt')


################################################################################################
#                                 Functions - updated 3/21/19
################################################################################################

get.dif.items <- function(f.data,p.val=.05,parms){
  r.warnings = ""
  keep.vars <- c("X2", "df", "p")
  f.data <- f.data[keep.vars]
  f.data$p = round(f.data$p,3)
  if(missing(f.data)) return('Missing model output out.list')
  f.data$sig <- ifelse(f.data$p < p.val,'dif','no_dif')
  if(!missing(parms)){
    if(nrow(f.data) == nrow(parms)){
      f.data <- cbind(f.data,parms)      
    }else{
      r.warnings = "There number of item parameters doesn't match the number of items given to get.dif.items. Item parameters omitted."
    }
  }
  dif.items <- subset(f.data, sig == 'dif')
  no.dif.items <- subset(f.data, sig == 'no_dif')
  if(!missing(parms) && nrow(f.data) == nrow(parms)){
    if(nrow(no.dif.items)>1){
      no.dif.items <- no.dif.items[order(-no.dif.items$a1),]      
    }
  }
  
  r.list <- list(dif_items = dif.items, no_dif = no.dif.items, warnings = r.warnings)
  return(r.list)
}


########## Make the data with a lack of invariance ######
make.data <- function(N){
  set.seed(12345)
  a <- matrix(abs(rnorm(15,1,.3)), ncol=1)
  d <- matrix(rnorm(15,0,.7),ncol=1)
  d1 <- d2 <- cbind(d, d-1, d-2)  # b parameters for both groups
  d2[13:15, ] <- d1[13:15, ] + 1  # here is the DIF
  itemtype <- rep('graded', nrow(a))
  dataset1 <- simdata(a, d1, N, itemtype)
  dataset2 <- simdata(a, d2, N, itemtype)
  dat <- rbind(dataset1, dataset2)
  return(dat)
}
N <- 1000
dat <- make.data(N)
group <- c(rep('Ref', N), rep('Foc', N))
focal.data <- dat[1:1000,]
ref.data <- dat[1001:2000,]




########### check dimensionality ########
fa.parallel(focal.data)
fa.parallel(ref.data)


########## check model fit ##############
mirtCluster(4)  # speed up processing
foc.model <- mirt(focal.data, model = 1, itemtype = "graded", SE=TRUE) 
coef(foc.model)
M2(foc.model)
ref.model <- mirt(ref.data, model = 1, itemtype = "graded", SE=TRUE) 
coef(ref.model)
M2(ref.model)
(foc.fit <- itemfit(foc.model))
(ref.fit <- itemfit(ref.model))

### optional plotting
plots.foc <- list()
plots.ref <- list()
for(i in 1:ncol(dat)){
  plots.foc[[i]]<-itemfit(foc.model,empirical.plot = i)
  plots.ref[[i]]<-itemfit(ref.model,empirical.plot = i)
}
plots.foc
plots.ref



apply(ref.data, 2, table)
apply(focal.data, 2, table)

### free baseline model
model.free <- multipleGroup(dat, 1, group)
coef(model.free, simplify = TRUE)    # for the manuscript


################## Constrained Baseline Model ############################
model.constrained <- multipleGroup(dat, 1, group,
                                   invariance = c(colnames(dat), 'free_means', 'free_var'))
coef(model.constrained,simplify = TRUE) # notice the different group latent means.
(constrained.parameters <- coef(model.constrained,simplify = TRUE)[[1]][[1]])


#################### First round of DIF analysesb - All Others As Anchors #################
(dif.drop <- DIF(model.constrained, c('a1','d1','d2','d3'), scheme = 'drop', seq_stat = .05))

## use the optional function to table the output
get.dif.items(f.data=dif.drop,p.val=.05,parms=constrained.parameters)


##### Run an anchor-item model #####
itemnames <- colnames(dat)
anc.items.names <- itemnames[c(2,4,6,7,9)]
test.items <- c(1,3,5,8,10:15)
model_anchor <- multipleGroup(dat, model = 1, group = group,
                              invariance = c(anc.items.names, 'free_means', 'free_var'))
(anchor.parms <-coef(model_anchor,simplify = TRUE)[[1]][[1]])


#################### Final round of DIF analyses #################
(dif.anchor <- DIF(model_anchor, c('a1','d1','d2','d3'), items2test = test.items, plotdif = TRUE))
## use the optional function to table the output
get.dif.items(f.data=dif.anchor,p.val=.05,parms = anchor.parms)



################## Compute the effect sizes #####################
empirical_ES(model_anchor, DIF=FALSE)  # test level stats
empirical_ES(model_anchor)             # item level stats
expected.test.plot <- empirical_ES(model_anchor, DIF=FALSE, plot=TRUE)  # expected test score plots
expected.item.plots <- empirical_ES(model_anchor, plot=TRUE)             # expected item score plots
itemplot(model_anchor, 13) # further investigate item with DF

#plots are lattice graphs which can be manipulated after the face
expected.test.plot$main <- "ETS for Reference and Focal Groups"
expected.test.plot$legend$top$args$key$text[[1]] <- c('Focal', 'Reference')
expected.test.plot
mirtCluster(remove=TRUE)

