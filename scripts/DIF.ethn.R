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
R.ethn <- cbind(R, vi[c("country")])  
I.ethn <- cbind(I, vi[c("country")])

# look at distributions of samples
table(R.ethn$country)
table(I.ethn$country)


# creates vectors of gender variable values for later analyses 
group.R <- as.character(R.ethn$country)
group.I <- as.character(I.ethn$country)


################
"############
  ### IRT ####
  ############"
################
mirtCluster(4) #speeds up processing

"
##### constrained baseline models ####
"
## Investigative dimension
model.constrained.I <- multipleGroup(I, 1, group.I, invariance = c(colnames(I), 'free_means', 'free_var'), technical = list(NCYCLES = 2000))

coef(model.constrained.I, simplify = T) #different group latent means
constrained.parameters.I <- coef(model.constrained.I, simplify = T)[[1]][[1]]
constrained.parameters.I #write this out to excel and put it in the manuscript

# to excel output
write.xlsx(as.data.frame(constrained.parameters.I), file="output/DIF.xlsx",sheetName="constrained.base.I",col.names=TRUE,row.names=TRUE,append=TRUE)


## Realistic dimension
model.constrained.R <- multipleGroup(R, 1, group.R,invariance = c(colnames(R),'free_means', 'free_var'), technical = list(NCYCLES = 2000))

coef(model.constrained.R, simplify = T) #different group latent means
constrained.parameters.R <- coef(model.constrained.R, simplify = T)[[1]][[1]]
constrained.parameters.R #write this out to excel and put it in the manuscript

# to excel output
write.xlsx(as.data.frame(constrained.parameters.R), file="output/DIF.xlsx",sheetName="constrained.base.R",col.names=TRUE,row.names=TRUE,append=TRUE)


"
##### first round of DIF analyses - All Others As Anchors #####
"
## investigative ##
(dif.drop.I <- DIF(model.constrained.I, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5, technical = list(NCYCLES = 2000)))  #gives us chi-square - compares constrained baseline model to model where items in ? have been freed up across groups

# Adam's function that tables the output --> all items have DIF
get.dif.items(f.data=dif.drop.I, p.val=.05, parms=constrained.parameters.I)

## realistic ##
(dif.drop.R <- DIF(model.constrained.R, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5, technical = list(NCYCLES = 2000)))

# Adam's function that tables the output --> all items have DIF
get.dif.items(f.data=dif.drop.R, p.val=.05, parms=constrained.parameters.R)


"
#### Run an anchor-item model ####
"
## Investigative
itemnames.I <- colnames(I)
anc.items.names.I <- itemnames.I[c(3,7)] 
test.items.I <- c(1,5,6,8)
model_anchor.I <- multipleGroup(I, model = 1, group = group.I,
                                invariance = c(anc.items.names.I, 'free_means', 'free_var'), 
                                technical = list(NCYCLES = 2000))
(anchor.parms.I <-coef(model_anchor.I,simplify = TRUE)[[1]][[1]])

# to excel output
write.xlsx(as.data.frame(anchor.parms.I), file="output/DIF.xlsx",sheetName="anchor.model.parms.I",col.names=TRUE,row.names=TRUE,append=TRUE)

## Realistic
itemnames.R <- colnames(R)
anc.items.names.R <- itemnames.R[c(2,6)] 
test.items.R <- c(3,4,5,8)
model_anchor.R <- multipleGroup(R, model = 1, group = group.R,
                                invariance = c(anc.items.names.R, 'free_means', 'free_var'),
                                technical = list(NCYCLES = 2000))
(anchor.parms.R <-coef(model_anchor.R,simplify = TRUE)[[1]][[1]])

# to excel output
write.xlsx(as.data.frame(anchor.parms.R), file="output/DIF.xlsx",sheetName="anchor.model.parms.R",col.names=TRUE,row.names=TRUE,append=TRUE)

"
#### Final round of DIF (A5?) ####
"
## Investigative
(dif.anchor.I <- DIF(model_anchor.I, c('a1','d1','d2','d3'), items2test = test.items.I, plotdif = TRUE, technical = list(NCYCLES = 2000)))
dif.anchor.I
## use the optional function to table the output
get.dif.items(f.data=dif.anchor.I, p.val=.05, parms = anchor.parms.I)

## Realistic
(dif.anchor.R <- DIF(model_anchor.R, c('a1','d1','d2','d3'), items2test = test.items.R, plotdif = TRUE,technical = list(NCYCLES = 2000)))
dif.an
## use the optional function to table the output
get.dif.items(f.data=dif.anchor.R, p.val=.05, parms = anchor.parms.R)


"
#### compute effect sizes ####
"
## Investigative
ES.test.lvl.I <- empirical_ES(model_anchor.I, DIF=FALSE)  # test level stats
ES.item.lvl.I <- empirical_ES(model_anchor.I)             # item level stats
expected.test.plot.I <- empirical_ES(model_anchor.I, DIF=FALSE, plot=TRUE)  # expected test score plots
expected.test.plot.I
expected.item.plots.I <- empirical_ES(model_anchor.I, plot=TRUE)   # expected item score plots
expected.item.plots.I
itemplot(model_anchor.I, 8) # further investigate item with DF

# to excel output
write.xlsx(as.data.frame(ES.test.lvl.I), file="output/DIF.xlsx",sheetName="ES.test.lvl.I",col.names=TRUE,row.names=TRUE,append=TRUE)
write.xlsx(as.data.frame(ES.item.lvl.I), file="output/DIF.xlsx",sheetName="ES.item.lvl.I",col.names=TRUE,row.names=TRUE,append=TRUE)


## Realistic
ES.test.lvl.R <-empirical_ES(model_anchor.R, DIF=FALSE)  # test level stats
ES.item.lvl.R <-empirical_ES(model_anchor.R)             # item level stats
expected.test.plot.R <- empirical_ES(model_anchor.R, DIF=FALSE, plot=TRUE)  # expected test score plots
expected.test.plot.R
expected.item.plots.R <- empirical_ES(model_anchor.R, plot=TRUE)             # expected item score plots
expected.item.plots.R
itemplot(model_anchor.R, 8) # further investigate item with DF

# to excel output
write.xlsx(as.data.frame(ES.test.lvl.R), file="output/DIF.xlsx",sheetName="ES.test.lvl.R",col.names=TRUE,row.names=TRUE,append=TRUE)
write.xlsx(as.data.frame(ES.item.lvl.R), file="output/DIF.xlsx",sheetName="ES.item.lvl.R",col.names=TRUE,row.names=TRUE,append=TRUE)


"
#### lattice graph plots ####
"
## Investigative
expected.test.plot.I$main <- "ETS for Reference and Focal Groups"
expected.test.plot.I$legend$top$args$key$text[[8]] <- c('Focal', 'Reference')
expected.test.plot.I

## Investigative
expected.test.plot.R$main <- "ETS for Reference and Focal Groups"
expected.test.plots.R$legend$top$args$key$text[[8]] <- c('Focal', 'Reference')
expected.test.plot.R


mirtCluster(remove=TRUE) #turns off extra processors




