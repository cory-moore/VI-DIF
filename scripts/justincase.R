# create data subsets of US and MX 
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

I.us.ethn <- cbind(I.us, vi.us[c("country")])
R.us.ethn <- cbind(R.us, vi.us[c("country")])
I.mx.ethn <- cbind(I.mx, vi.mx[c("country")])
R.mx.ethn <- cbind(R.mx, vi.mx[c("country")])

table(I.us.ethn$country)
table(R.us.ethn$country)
table(I.mx.ethn$country)
table(R.mx.ethn$country)

group.I.us <- as.character(I.us.ethn$country)
group.R.us <- as.character(R.us.ethn$country)
group.I.mx <- as.character(I.mx.ethn$country)
group.R.mx <- as.character(R.mx.ethn$country)

#### SPLIT BY US and MX

## Investigative dimension (US)
model.constrained.I.us <- multipleGroup(I.us, 1, group.I.us, invariance = c(colnames(I.us), 'free_means', 'free_var'), technical = list(NCYCLES = 2000))

coef(model.constrained.I.us, simplify = T) #different group latent means
constrained.parameters.I.us <- coef(model.constrained.I.us, simplify = T)[[1]][[1]]
constrained.parameters.I.us #write this out to excel and put it in the manuscript

# to excel output
write.xlsx(as.data.frame(constrained.parameters.I.us), file="output/DIF.xlsx",sheetName="constrained.base.I.us",col.names=TRUE,row.names=FALSE,append=TRUE)

## Investigative dimension (MX)
model.constrained.I.mx <- multipleGroup(I.mx, 1, group.I.mx, invariance = c(colnames(I.mx), 'free_means', 'free_var'), technical = list(NCYCLES = 2000))

coef(model.constrained.I, simplify = T) #different group latent means
constrained.parameters.I <- coef(model.constrained.I, simplify = T)[[1]][[1]]
constrained.parameters.I #write this out to excel and put it in the manuscript

# to excel output
write.xlsx(as.data.frame(constrained.parameters.I), file="output/DIF.xlsx",sheetName="constrained.base.I",col.names=TRUE,row.names=FALSE,append=TRUE)



