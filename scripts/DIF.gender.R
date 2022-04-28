#libraries 
library(dplyr)
library(careless)
library(psych)
library(lessR)
library(mirt)
library(Hmisc)
library(factoextra)
library(sjmisc)

"
########  create get.dif.items function #########
"

get.dif.items <- function(f.data,p.val=.05,parms){
  r.warnings = ""
  keep.vars <- c("X2", "df", "p")  # just keep these variables
  f.data <- f.data[keep.vars]
  f.data$p = round(f.data$p,3)
  if(missing(f.data)) return('Missing model output out.list')
  f.data$sig <- ifelse(f.data$p < p.val,'dif','no_dif')
  if(!missing(parms)){
    if(nrow(f.data) == nrow(parms)){
      f.data <- cbind(f.data,parms)      
    }else{
      r.warnings = "There number of item parameters doesn't match the number of items "
      r.warnings = paste(r.warnings,"given to get.dif.items. Item parameters omitted.")
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


"
###### import data and group by gender #####
"
vi <- read.csv("data/vi.csv", header=TRUE)
R <- read.csv("data/realistic.csv", header=TRUE) #lacks gender col
I <- read.csv("data/investigative.csv", header=TRUE) #lacks gender col

##appends 'gender' to each interest df
R.g <- cbind(R, vi[c("gender")])  
I.g <- cbind(I, vi[c("gender")])

table(R.g$gender)
table(I.g$gender)

# creates vectors of gender variable values for later analyses 
group.R <- as.character(R.g$gender)
group.I <- as.character(I.g$gender)


################
 "############
  ### IRT ####
  ############"
################
"
##### constrained baseline models ####
"
## Realistic dimension
model.constrained.R <- multipleGroup(R, 1, group.R, 
                                     invariance = c(colnames(R), 
                                                    'free_means', 'free_var'))
coef(model.constrained.R, simplify = T) #different group latent means
constrained.parameters.R <- coef(model.constrained.R, simplify = T)[[1]][[1]]
constrained.parameters.R #write this out to excel and put it in the manuscript

## Investigative dimension
model.constrained.I <- multipleGroup(I, 1, group.I, 
                                     invariance = c(colnames(I), 
                                                    'free_means', 'free_var'))
coef(model.constrained.I, simplify = T) #different group latent means
constrained.parameters.I <- coef(model.constrained.I, simplify = T)[[1]][[1]]
constrained.parameters.I #write this out to excel and put it in the manuscript


"
##### first round of DIF analyses - All Others As Anchors #####
"
## realistic ##
(dif.drop.R <- DIF(model.constrained.R, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5)) #gives us chi-square - compares constrained baseline model to model where items in ? have been freed up across groups

# Adam's function that tables the output --> all items have DIF
get.dif.items(f.data=dif.drop.R, p.val=.05, parms=constrained.parameters.R)

## investigative ##
(dif.drop.I <- DIF(model.constrained.I, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5)) #same as above

# Adam's function that tables the output --> all items have DIF
get.dif.items(f.data=dif.drop.I, p.val=.05, parms=constrained.parameters.I)


"
#### Run an anchor-item model ####
"
## Realistic
itemnames.R <- colnames(R)
anc.items.names.R <- itemnames.R[c(1)] 
test.items.R <- c(2:8)
model_anchor.R <- multipleGroup(R, model = 1, group = group.R,
                              invariance = c(anc.items.names.R, 'free_means', 'free_var'))
(anchor.parms.R <-coef(model_anchor.R,simplify = TRUE)[[1]][[1]])


"
#### Final round of DIF ####
"
## Realistic
(dif.anchor.R <- DIF(model_anchor.R, c('a1','d1','d2','d3'), items2test = test.items.R, plotdif = TRUE))
## use the optional function to table the output
get.dif.items(f.data=dif.anchor.R, p.val=.05, parms = anchor.parms.R)


"
#### compute effect sizes ####
"
## Realistic
empirical_ES(model_anchor.R, DIF=FALSE)  # test level stats
empirical_ES(model_anchor.R)             # item level stats
expected.test.plot.R <- empirical_ES(model_anchor.R, DIF=FALSE, plot=TRUE)  # expected test score plots
expected.item.plots.R <- empirical_ES(model_anchor.R, plot=TRUE)             # expected item score plots
itemplot(model_anchor.R, 5) # further investigate item with DF



"
#### lattice graph plots ####
"
## Realistic
expected.test.plot.R$main <- "ETS for Reference and Focal Groups"
expected.test.plot.R$legend$top$args$key$text[[1]] <- c('Focal', 'Reference')
expected.test.plot.R
mirtCluster(remove=TRUE)




