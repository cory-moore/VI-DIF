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


###### SUBSET DATA:  ########
# first, id top five hispanic countries and collapse them into a single category
# countries to include= mexico (MX), puerto rico (PR), cuba (CU), el salvador (SV), dominican republic (DO)
# top five hispanic representation in the US
table(vi$country)

#rename countries to HS (Hispanic)
vi$country <- dplyr::recode(vi$country,
              'MX' = "HS",
              'PR' = "HS",
              'CU' = "HS",
              'SV' = "HS",
              'DO' = "HS")
                    

# remove cases that completed RIASEC and demographic items in <3 sec / items &
# remove that are not US respondents (avoid cultural confounding)
vi <- vi %>% 
  filter(country %in% c("HS","US"),
         testelapse > 125, 
         surveyelapse > 75,
         age < 100) #should I be more stringent?
 


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
           race,
           country))

# remova all missing cases (ie, 0's)
vi[vi==0] <- NA
vi <- vi[complete.cases(vi),]

#subset further to specific interest dimensions 
I <- vi %>%
  select(c(I1,I2,I3,I4,I5,I6,I7,I8))

R <- vi %>%
  select(c(R1,R2,R3,R4,R5,R6,R7,R8))

demo <- vi %>%
  select(c(education,
           gender,
           age,
           race, 
           country))

### Inspect the data a bit ###
summary(vi)
hist.data.frame(vi)
boxplot(I)
boxplot(R)
boxplot(vi$age)
summary(vi$age)
apply(vi, 2, table)
table(vi$country)


### Export all dataframes to csv files for DIF script
write.csv(vi, "data/vi.csv", row.names=F)
write.csv(R, "data/realistic.csv", row.names=F)
write.csv(I, "data/investigative.csv", row.names=F)



################
"############
  ### IRT ####
  ############"
################
"
## Test assumptions (unidimensionality) ##
## Investigative dimension &            ##
## Realistic dimension                  ##
"

#scree plots  <-- need to do this for each group, men and women
fa.parallel(I)
fa.parallel(R)

#oblique rotation
efa.I <- fa(I, nfactors=1, rotate="oblimin") #Investigative dimension
print(efa.I, sort=TRUE)
efa.I$values #EFA eigenvalues - unidimensional (factor two eigenvalue <.1)
efa.I$loadings
fa.diagram(efa.I)

efa.R <- fa(R, nfactors=1, rotate="oblimin")
print(efa.R, sort=TRUE)
efa.R$values #EFA eigenvalues - unidimensional (factor two eigenvalue <.1)
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


"
### RUN GRMs ###
"
grm.I.out <- mirt(I, model=1, itemtype="graded", SE=TRUE)
grm.I.out

grm.R.out <- mirt(R, model=1, itemtype="graded", SE=TRUE)
grm.R.out


"
### Assess model fit ###
"
# Investigative
fit.I <- itemfit(grm.I.out, x2=TRUE)
fit.I

plots.I.1 <- list()
for(i in 1:length(I)){
  plots.I.1[[i]] <-itemfit(grm.I.out, empirical.plot = i)
}
plots.I.1

# Realistic
fit.R <- itemfit(grm.R.out, x2=TRUE)
fit.R

plots.R.1 <- list()
for(i in 1:length(I)){
  plots.R.1[[i]] <-itemfit(grm.R.out, empirical.plot = i)
}
plots.R.1


"
### look at model probability functions and parameters ###
"

## Investigative ## 
plot(grm.I.out) #expected test scores
plot(grm.I.out, type="info") #test info
plot(grm.I.out, type="infoSE") #item info
plot(grm.I.out, type="trace") #item CRCs

plots.I.2 <- list()
for(i in 1:length(I)){
  plots.I.2[[i]]<-itemplot(grm.I.out,i)
}
plots.I.2 #prob functions not bad 

#item parameters  ## remember difficulty (b) = -d/a 
(coef.table.I <- coef(grm.I.out, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.I <- coef(grm.I.out, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.I
### NOTE you get DIFFERENT SEs for IRT parameters than default
### RECALL that b1 = response 1 and 2, b2 = response 2 and 3, b3 = 3 and 4, b4 = 4 and 5


## Realistic ##
plot(grm.R.out) #expected test scores
plot(grm.R.out, type="info") #test info
plot(grm.R.out, type="infoSE") #item info
plot(grm.R.out, type="trace") #item CRCs

plots.R.2 <- list()
for(i in 1:length(I)){
  plots.R.2[[i]]<-itemplot(grm.R.out,i)
}
plots.R.2 ##prob functions not  bad 

#item parameters
(coef.table.R <- coef(grm.R.out, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.R <- coef(grm.R.out, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.R

