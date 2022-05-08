#libraries 
library(dplyr)
library(careless)
library(psych)
library(lessR)
library(mirt)
library(Hmisc)
library(factoextra)
library(sjmisc)
install.packages("stats")
library(stats)

#import data
vi <- read.delim("data/data.csv", header=TRUE)


###### SUBSET DATA:  ########
table(vi$country)
length(unique(vi$country))
describe(vi$age)

# remove cases that completed RIASEC and demographic items in <3 sec / items &
# remove that are not US respondents (avoid cultural confounding)
vi <- vi %>% 
  filter(country %in% c("MX","US"),
         testelapse > 110, 
         surveyelapse > 65,
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
           engnat,
           age,
           race,
           country))

#recode categorical variables
vi$education <- dplyr::recode(vi$education,
                              '1' = "Less than high school",
                              '2' = "High school",
                              '3' = "University degree",
                              '4' = "Graduate degree")


vi$gender <- dplyr::recode(vi$gender,
                           '1' = "Male",
                           '2' = "Female",
                           '3' = "Other")

vi$engnat <- dplyr::recode(vi$engnat,
                           '1' = "Yes",
                           '2' = "No")

vi$race <- dplyr::recode(vi$race,
                         '1' = "Asian",
                         '2' = "Arab",
                         '3' = "Black",
                         '4' = "Indigenous Australian / Native American / White",
                         '5' = "Other")

# remova all missing cases (ie, 0's)
vi[vi==0] <- NA
vi <- vi[complete.cases(vi),]

#further clean US sample to remove cases where eng was not first language (assuming they are not native US)
vi <- vi %>% filter(!(country=="US" & engnat=="No"))

#subset further to specific interest dimensions 
I <- vi %>%
  select(c(I1,I2,I3,I4,I5,I6,I7,I8))

R <- vi %>%
  select(c(R1,R2,R3,R4,R5,R6,R7,R8))

demo <- vi %>%
  select(c(education,
           gender,
           engnat,
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
write.csv(demo, "data/demo.csv", row.names=F)



################
"############
  ### IRT ####
  ############"
################
"
## internal reliability                 ##
## Test assumptions (unidimensionality) ##
## Investigative dimension &            ##
## Realistic dimension                  ##
"

# internal reliability
I.alpha <- psych::alpha(I)
I.alpha

R.alpha <- psych::alpha(R)
R.alpha

#scree plots  
fa.parallel(I)
fa.parallel(R)

I2 <- prcomp(I, scale=TRUE)
screeplot(I2, type = "lines") #eigenvalues 
R2 <- prcomp(R, scale=TRUE)
screeplot(R2, type = "lines") 

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
# first create data subsets of US and MX 
vi.us <- filter(vi, country=='US')
I.us <- vi.us %>%
  select(c(I1,I2,I3,I4,I5,I6,I7,I8))
R.us <- vi.us %>%
  select(c(R1,R2,R3,R4,R5,R6,R7,R8))

vi.mx <- filter(vi, country=="MX")
I.mx <- vi.mx %>%
  select(c(I1,I2,I3,I4,I5,I6,I7,I8))
R.mx <- vi.mx %>%
  select(c(R1,R2,R3,R4,R5,R6,R7,R8))


# combined models
grm.I.out <- mirt(I, model=1, itemtype="graded", SE=TRUE)
grm.I.out

grm.R.out <- mirt(R, model=1, itemtype="graded", SE=TRUE)
grm.R.out

# split group models
grm.I.us <- mirt(I.us, model=1, itemtype="graded", SE=TRUE)
grm.I.us

grm.R.us <- mirt(R.us, model=1, itemtype="graded", SE=TRUE)
grm.R.us

grm.I.mx <- mirt(I.mx, model=1, itemtype="graded", SE=TRUE)
grm.I.mx

grm.R.mx <- mirt(R.mx, model=1, itemtype="graded", SE=TRUE)
grm.R.mx


"
### Assess model fit ###
"
mirtCluster(4)
### SPLIT BY GROUP (US(reference) and MX(focal)) 
#model fit
coef(grm.I.us)
M2(grm.I.us, type="C2")

coef(grm.R.us)
M2(grm.R.us, type="C2")

coef(grm.I.mx)
M2(grm.I.mx, type="C2")

coef(grm.R.mx)
M2(grm.R.mx, type="C2")

(grm.I.us.item.fit <- itemfit(grm.I.us))
(grm.R.us.item.fit <- itemfit(grm.R.us))
(grm.I.mx.item.fit <- itemfit(grm.I.mx))
(grm.R.mx.item.fit <- itemfit(grm.R.mx))


"
### look at model probability functions and parameters ###
"
#### All of the below analyses are done with groups combined ####

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

#item parameters (combined groups for R and I)
(coef.table.R <- coef(grm.R.out, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.R <- coef(grm.R.out, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.R

(coef.table.I <- coef(grm.I.out, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.I <- coef(grm.I.out, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.I


#items paramets by group by interest
(coef.table.R.us <- coef(grm.R.us, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.R.us <- coef(grm.R.us, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.R.us

(coef.table.I.us <- coef(grm.I.us, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.I.us <- coef(grm.I.us, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.I.us

(coef.table.R.mx <- coef(grm.R.mx, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.R.mx <- coef(grm.R.umx, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.R.us

(coef.table.I.mx <- coef(grm.I.mx, simplify = TRUE, IRTpars = TRUE)[[1]])
par.SE.I.mx <- coef(grm.I.mx, IRTpars=TRUE, printSE=TRUE) #print SE from non-IRT format
par.SE.I.mx

#write to excel
write.xlsx(as.data.frame(coef.table.R.us), file="output/output.xlsx",sheetName="grm.par.R.us",col.names=TRUE,row.names=TRUE,append=TRUE)
write.xlsx(as.data.frame(coef.table.I.us), file="output/output.xlsx",sheetName="grm.par.I.us",col.names=TRUE,row.names=TRUE,append=TRUE)
write.xlsx(as.data.frame(coef.table.R.mx), file="output/output.xlsx",sheetName="grm.par.R.mx",col.names=TRUE,row.names=TRUE,append=TRUE)
write.xlsx(as.data.frame(coef.table.I.mx), file="output/output.xlsx",sheetName="grm.par.I.mx",col.names=TRUE,row.names=TRUE,append=TRUE)

mirtCluster(remove=TRUE) #turns off extra processors

