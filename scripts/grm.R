#libraries 
library(dplyr)
library(careless)
library(psych)
library(lessR)
library(mirt)
library(Hmisc)
library(factoextra)
library(sjmisc)

#import data
vi <- read.delim("data/data.csv", header=TRUE)


###### SCREEN DATA:  ########
# remove cases that completed RIASEC and demographic items in <2.5 sec / items &
# remove that are not US respondents (avoid cultural confounding)
vi <- vi %>% 
  filter(testelapse > 125,
         surveyelapse > 75,
         country == "US",
         age < 100) 

# delete longstring responders
longstring <- longstring(vi[,1:48], avg=TRUE)
boxplot(longstring)
longstring
ls <- longstring$longstr
vi$ls <- ls #bind longstring values to df 
names(vi)

vi <- vi %>% #deletes cases with longstring >= 16
  filter(ls < 16)

rm(longstring)

#subset dataframe - only variables I need
vi <- vi %>%
  select(c(R1,R2,R3,R4,R5,R6,R7,R8,
           I1,I2,I3,I4,I5,I6,I7,I8,
           education,
           gender,
           age,
           race))


#subset further to specific interest dimensions 
I <- vi %>%
  select(c(I1,I2,I3,I4,I5,I6,I7,I8))

R <- vi %>%
  select(c(R1,R2,R3,R4,R5,R6,R7,R8))

demo <- vi %>%
  select(c(education,
           gender,
           age,
           race))


### Inspect the data a bit ###
summary(vi)
hist.data.frame(vi)
boxplot(I)
boxplot(R)
boxplot(vi$age)
summary(vi$age)
apply(vi, 2, table)



################
 "############
  ### IRT ####
  ############"
################

## Test assumptions (unidimensionality ##

#scree plots
fa.parallel(I)
fa.parallel(R)

#oblique rotation
efa.I <- fa(I, nfactors=1, rotate="oblimin")
print(efa.I, sort=TRUE)
efa.I$values #EFA eigenvalues
efa.I$loadings
fa.diagram(efa.I)

efa.R <- fa(R, nfactors=1, rotate="oblimin")
print(efa.R, sort=TRUE)
efa.R$values #EFA eigenvalues
efa.R$loadings
fa.diagram(efa.R)

#double-check 2-factor solutions
efa.I2 <- fa(I, nfactors=2, rotate="oblimin")
print(efa.I2, sort=TRUE)
efa.I2$values  #EFA eigenvalues.  REPORT THESE
efa.I2$loadings
fa.diagram(efa.I2)

efa.R2 <- fa(R, nfactors=2, rotate="oblimin")
print(efa.R2, sort=TRUE)
efa.R2$values  #EFA eigenvalues.  REPORT THESE
efa.R2$loadings
fa.diagram(efa.R2)

rm(efa.I,efa.I2,efa.R,efa.R2)


### RUN GRM ###
