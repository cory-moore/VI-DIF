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
R <- read.csv("data/realistic.csv", header=TRUE) 
I <- read.csv("data/investigative.csv", header=TRUE) 

##appends 'country' to each interest df
R.cult <- cbind(R, vi[c("country")])  
I.cult <- cbind(I, vi[c("country")])

table(R.cult$country)
table(I.cult$country)

# creates vectors of gender variable values for later analyses 
group.R <- as.character(R.cult$country)
group.I <- as.character(I.cult$country)


################
"############
  ### IRT ####
  ############"
################
mirtCluster(4) #speeds up processing

"
##### constrained baseline models ####
"
## Realistic dimension
model.constrained.R <- multipleGroup(R, 1, group.R,invariance = c(colnames(R),'free_means', 'free_var'), technical = list(NCYCLES = 2000))

coef(model.constrained.R, simplify = T) #different group latent means
constrained.parameters.R <- coef(model.constrained.R, simplify = T)[[1]][[1]]
constrained.parameters.R #write this out to excel and put it in the manuscript

## Investigative dimension
model.constrained.I <- multipleGroup(I, 1, group.I, invariance = c(colnames(I), 'free_means', 'free_var'), technical = list(NCYCLES = 2000))

coef(model.constrained.I, simplify = T) #different group latent means
constrained.parameters.I <- coef(model.constrained.I, simplify = T)[[1]][[1]]
constrained.parameters.I #write this out to excel and put it in the manuscript


"
##### first round of DIF analyses - All Others As Anchors #####
"
## realistic ##
(dif.drop.R <- DIF(model.constrained.R, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5, technical = list(NCYCLES = 2000))) #gives us chi-square - compares constrained baseline model to model where items in ? have been freed up across groups

# Adam's function that tables the output --> all items have DIF
get.dif.items(f.data=dif.drop.R, p.val=.05, parms=constrained.parameters.R)

## investigative ##
(dif.drop.I <- DIF(model.constrained.I, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5, technical = list(NCYCLES = 2000))) #same as above

# Adam's function that tables the output --> all items have DIF
get.dif.items(f.data=dif.drop.I, p.val=.05, parms=constrained.parameters.I)


"
#### Run an anchor-item model ####
"
## Realistic
itemnames.R <- colnames(R)
anc.items.names.R <- itemnames.R[c(6,7)] 
test.items.R <- c(3,4,5,8)
model_anchor.R <- multipleGroup(R, model = 1, group = group.R,
                                invariance = c(anc.items.names.R, 'free_means', 'free_var'),
                                technical = list(NCYCLES = 2000))
(anchor.parms.R <-coef(model_anchor.R,simplify = TRUE)[[1]][[1]])


## Investigative
itemnames.I <- colnames(I)
anc.items.names.I <- itemnames.I[c(3,5,7)] 
test.items.I <- c(1,8)
model_anchor.I <- multipleGroup(I, model = 1, group = group.I,
                                invariance = c(anc.items.names.I, 'free_means', 'free_var'), 
                                technical = list(NCYCLES = 2000))
(anchor.parms.I <-coef(model_anchor.I,simplify = TRUE)[[1]][[1]])


"
#### Final round of DIF ####
"
## Realistic
(dif.anchor.R <- DIF(model_anchor.R, c('a1','d1','d2','d3'), items2test = test.items.R, plotdif = TRUE,technical = list(NCYCLES = 2000)))
## use the optional function to table the output
get.dif.items(f.data=dif.anchor.R, p.val=.05, parms = anchor.parms.R)

## Investigative
(dif.anchor.I <- DIF(model_anchor.I, c('a1','d1','d2','d3'), items2test = test.items.I, plotdif = TRUE, technical = list(NCYCLES = 2000)))
## use the optional function to table the output
get.dif.items(f.data=dif.anchor.I, p.val=.05, parms = anchor.parms.I)


"
#### compute effect sizes ####
"
## Realistic
empirical_ES(model_anchor.R, DIF=FALSE)  # test level stats
empirical_ES(model_anchor.R)             # item level stats
expected.test.plot.R <- empirical_ES(model_anchor.R, DIF=FALSE, plot=TRUE)  # expected test score plots
expected.test.plot.R
expected.item.plots.R <- empirical_ES(model_anchor.R, plot=TRUE)             # expected item score plots
expected.item.plots.R
itemplot(model_anchor.R, 8) # further investigate item with DF

## Investigative
empirical_ES(model_anchor.I, DIF=FALSE)  # test level stats
empirical_ES(model_anchor.I)             # item level stats
expected.test.plot.I <- empirical_ES(model_anchor.I, DIF=FALSE, plot=TRUE)  # expected test score plots
expected.test.plot.I
expected.item.plots.I <- empirical_ES(model_anchor.I, plot=TRUE)             # expected item score plots
expected.item.plots.I
itemplot(model_anchor.I, 8) # further investigate item with DF



"
#### lattice graph plots ####
"
## Investigative
expected.test.plot.I$main <- "ETS for Reference and Focal Groups"
expected.test.plot.I$legend$top$args$key$text[[8]] <- c('Focal', 'Reference')
expected.test.plot.I


mirtCluster(remove=TRUE) #turns off extra processors




