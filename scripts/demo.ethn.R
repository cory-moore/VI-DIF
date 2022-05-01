#libraries 
library(dplyr)
library(xlsx)

#import data
demo <- read.csv("data/demo.csv", header=T)


##### change variable classes
demo <- demo %>%
  mutate(education=as.factor(education),
         gender=as.factor(gender),
         engnat=as.factor(engnat),
         race=as.factor(race),
         country=as.factor(country))

## subset data by US and MX
demo.us <- filter(demo, country=='US')
demo.mx <- filter(demo, country=="MX")


"##### demographics with groups combined  #####"
# Gender
gender <- demo %>%
  group_by(gender) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
gender

# to excel output
write.xlsx(as.data.frame(gender), file="output/output.xlsx",sheetName="gender",col.names=TRUE,row.names=FALSE,append=TRUE)

# Education
education <- demo %>%
  group_by(education) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
education

# to excel output
write.xlsx(as.data.frame(education), file="output/output.xlsx",sheetName="education",col.names=TRUE,row.names=FALSE,append=TRUE)


# Country
country <- demo %>%
  group_by(country) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
country

# to excel output
write.xlsx(as.data.frame(country), file="output/output.xlsx",sheetName="country",col.names=TRUE,row.names=FALSE,append=TRUE)


# Race
race <- demo %>%
  group_by(race) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
race

# to excel output
write.xlsx(as.data.frame(race), file="output/output.xlsx",sheetName="race",col.names=TRUE,row.names=FALSE,append=TRUE)


# English
english <- demo %>%
  group_by(engnat) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
english

# to excel output
write.xlsx(as.data.frame(english), file="output/output.xlsx",sheetName="english",col.names=TRUE,row.names=FALSE,append=TRUE)


# AGE
#mean, min/max, and SD for age'
age <- psych::describe(demo$age) 
age

# to excel output
write.xlsx(as.data.frame(age), file="output/output.xlsx",sheetName="age",col.names=TRUE,row.names=FALSE,append=TRUE)



"#### demographics for the US  ####"
# Gender
gender.us <- demo.us %>%
  group_by(gender) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
gender.us

# to excel output
write.xlsx(as.data.frame(gender), file="output/output.xlsx",sheetName="gender.us",col.names=TRUE,row.names=FALSE,append=TRUE)

# Education
education.us <- demo.us %>%
  group_by(education) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
education.us

# to excel output
write.xlsx(as.data.frame(education), file="output/output.xlsx",sheetName="education.us",col.names=TRUE,row.names=FALSE,append=TRUE)

# Race
race.us <- demo.us %>%
  group_by(race) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
race.us

# to excel output
write.xlsx(as.data.frame(race), file="output/output.xlsx",sheetName="race.us",col.names=TRUE,row.names=FALSE,append=TRUE)


# AGE
#mean, min/max, and SD for age'
age.us <- psych::describe(demo.us$age) 
age.us

# to excel output
write.xlsx(as.data.frame(age), file="output/output.xlsx",sheetName="age.us",col.names=TRUE,row.names=FALSE,append=TRUE)


"#### demographics for MX  ####"
# Gender
gender.mx <- demo.mx %>%
  group_by(gender) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
gender.mx

# to excel output
write.xlsx(as.data.frame(gender), file="output/output.xlsx",sheetName="gender.mx",col.names=TRUE,row.names=FALSE,append=TRUE)

# Education
education.mx <- demo.mx %>%
  group_by(education) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
education.mx

# to excel output
write.xlsx(as.data.frame(education), file="output/output.xlsx",sheetName="education.mx",col.names=TRUE,row.names=FALSE,append=TRUE)

# Race
race.mx <- demo.mx %>%
  group_by(race) %>%
  summarise(n = n()) %>%
  mutate(freq = round(n / sum(n),3)) %>%
  arrange(desc(freq))
race.mx

# to excel output
write.xlsx(as.data.frame(race), file="output/output.xlsx",sheetName="race.mx",col.names=TRUE,row.names=FALSE,append=TRUE)


# AGE
#mean, min/max, and SD for age'
age.mx <- psych::describe(demo.mx$age) 
age.mx

# to excel output
write.xlsx(as.data.frame(age), file="output/output.xlsx",sheetName="age.mx",col.names=TRUE,row.names=FALSE,append=TRUE)
