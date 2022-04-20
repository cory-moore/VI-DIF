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
constrained.parameters.R

## Investigative dimension
model.constrained.I <- multipleGroup(I, 1, group.I, 
                                     invariance = c(colnames(I), 
                                                    'free_means', 'free_var'))
coef(model.constrained.I, simplify = T) #different group latent means
constrained.parameters.I <- coef(model.constrained.I, simplify = T)[[1]][[1]]
constrained.parameters.I
