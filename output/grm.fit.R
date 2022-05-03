

"######  MODEL FIT  ######"

> # combined models
> grm.I.out <- mirt(I, model=1, itemtype="graded", SE=TRUE)
Iteration: 73, Log-Lik: -667575.414, Max-Change: 0.00009

Calculating information matrix...
> grm.I.out

Call:
mirt(data = I, model = 1, itemtype = "graded", SE = TRUE)

Full-information item factor analysis with 1 factor(s).
Converged within 0.0001 tolerance after 73 EM iterations.
mirt version: 1.35.1 
M-step optimizer: BFGS 
EM acceleration: Ramsay 
Number of rectangular quadrature: 61
Latent density type: Gaussian 

Information matrix estimated with method: Oakes
Second-order test: model is a possible local maximum
Condition number of information matrix =  112.6688

Log-likelihood = -667575.4
Estimated parameters: 40 
AIC = 1335231
BIC = 1335592; SABIC = 1335465
G2 (390584) = 180748, p = 1
RMSEA = 0, CFI = NaN, TLI = NaN
> 
> grm.R.out <- mirt(R, model=1, itemtype="graded", SE=TRUE)
Iteration: 55, Log-Lik: -544042.744, Max-Change: 0.00010

Calculating information matrix...
> grm.R.out

Call:
mirt(data = R, model = 1, itemtype = "graded", SE = TRUE)

Full-information item factor analysis with 1 factor(s).
Converged within 0.0001 tolerance after 55 EM iterations.
mirt version: 1.35.1 
M-step optimizer: BFGS 
EM acceleration: Ramsay 
Number of rectangular quadrature: 61
Latent density type: Gaussian 

Information matrix estimated with method: Oakes
Second-order test: model is a possible local maximum
Condition number of information matrix =  149.9095

Log-likelihood = -544042.7
Estimated parameters: 40 
AIC = 1088165
BIC = 1088527; SABIC = 1088400
G2 (390584) = 120660, p = 1
RMSEA = 0, CFI = NaN, TLI = NaN
> 
> # split group models
> grm.I.us <- mirt(I.us, model=1, itemtype="graded", SE=TRUE)
Iteration: 64, Log-Lik: -664542.697, Max-Change: 0.00009

Calculating information matrix...
> grm.I.us

Call:
mirt(data = I.us, model = 1, itemtype = "graded", SE = TRUE)

Full-information item factor analysis with 1 factor(s).
Converged within 0.0001 tolerance after 64 EM iterations.
mirt version: 1.35.1 
M-step optimizer: BFGS 
EM acceleration: Ramsay 
Number of rectangular quadrature: 61
Latent density type: Gaussian 

Information matrix estimated with method: Oakes
Second-order test: model is a possible local maximum
Condition number of information matrix =  112.8588

Log-likelihood = -664542.7
Estimated parameters: 40 
AIC = 1329165
BIC = 1329527; SABIC = 1329399
G2 (390584) = 180179, p = 1
RMSEA = 0, CFI = NaN, TLI = NaN
> 


> grm.R.us <- mirt(R.us, model=1, itemtype="graded", SE=TRUE)
Iteration: 67, Log-Lik: -541272.416, Max-Change: 0.00009

Calculating information matrix...
> grm.R.us

Call:
mirt(data = R.us, model = 1, itemtype = "graded", SE = TRUE)

Full-information item factor analysis with 1 factor(s).
Converged within 0.0001 tolerance after 67 EM iterations.
mirt version: 1.35.1 
M-step optimizer: BFGS 
EM acceleration: Ramsay 
Number of rectangular quadrature: 61
Latent density type: Gaussian 

Information matrix estimated with method: Oakes
Second-order test: model is a possible local maximum
Condition number of information matrix =  150.5323

Log-likelihood = -541272.4
Estimated parameters: 40 
AIC = 1082625
BIC = 1082986; SABIC = 1082859
G2 (390584) = 120178, p = 1
RMSEA = 0, CFI = NaN, TLI = NaN
> 


> grm.I.mx <- mirt(I.mx, model=1, itemtype="graded", SE=TRUE)
Iteration: 64, Log-Lik: -664542.697, Max-Change: 0.00009

Calculating information matrix...
> grm.I.mx

Call:
mirt(data = I.mx, model = 1, itemtype = "graded", SE = TRUE)

Full-information item factor analysis with 1 factor(s).
Converged within 0.0001 tolerance after 33 EM iterations.
mirt version: 1.35.1 
M-step optimizer: BFGS 
EM acceleration: Ramsay 
Number of rectangular quadrature: 61
Latent density type: Gaussian 

Information matrix estimated with method: Oakes
Second-order test: model is a possible local maximum
Condition number of information matrix =  103.5431

Log-likelihood = -2988.649
Estimated parameters: 40 
AIC = 6057.298
BIC = 6203.397; SABIC = 6076.555
G2 (390584) = 2801.83, p = 1
RMSEA = 0, CFI = NaN, TLI = NaN
> 


> grm.R.mx <- mirt(R.mx, model=1, itemtype="graded", SE=TRUE)
Iteration: 54, Log-Lik: -2700.535, Max-Change: 0.00008

Calculating information matrix...
> grm.R.mx

Call:
mirt(data = R.mx, model = 1, itemtype = "graded", SE = TRUE)

Full-information item factor analysis with 1 factor(s).
Converged within 0.0001 tolerance after 54 EM iterations.
mirt version: 1.35.1 
M-step optimizer: BFGS 
EM acceleration: Ramsay 
Number of rectangular quadrature: 61
Latent density type: Gaussian 

Information matrix estimated with method: Oakes
Second-order test: model is a possible local maximum
Condition number of information matrix =  87.74148

Log-likelihood = -2700.535
Estimated parameters: 40 
AIC = 5481.07
BIC = 5627.17; SABIC = 5500.327
G2 (390584) = 2451.72, p = 1
RMSEA = 0, CFI = NaN, TLI = NaN
> 
> 
> "
+ ### Assess model fit ###
+ "

> ### SPLIT BY GROUP (US(reference) and MX(focal)) 
> #model fit


> M2(grm.I.us, type="C2")
            M2 df p     RMSEA   RMSEA_5  RMSEA_95      SRMSR       TLI       CFI
stats 67228.28 20 0 0.2335565 0.2320744 0.2350383 0.09921723 0.7805648 0.8432606
> 

> M2(grm.R.us, type="C2")
            M2 df p     RMSEA   RMSEA_5  RMSEA_95      SRMSR       TLI       CFI
stats 25715.47 20 0 0.1444138 0.1429333 0.1458976 0.06721027 0.9133646 0.9381176
> 


> M2(grm.I.mx, type="C2")
            M2 df p     RMSEA  RMSEA_5  RMSEA_95      SRMSR       TLI       CFI
stats 209.8853 20 0 0.1828401 0.160619 0.2052746 0.07464948 0.8847164 0.9176546
> 


> M2(grm.R.mx, type="C2")
            M2 df                 p     RMSEA    RMSEA_5  RMSEA_95      SRMSR
stats 84.77808 20 0.000000000597842 0.1067923 0.08379186 0.1305127 0.06445648
            TLI       CFI
stats 0.9421712 0.9586937
> 

## item fit

> (grm.I.us.item.fit <- itemfit(grm.I.us))
  item     S_X2 df.S_X2 RMSEA.S_X2 p.S_X2
1   I1  887.765      95      0.012      0
2   I2  590.274      95      0.009      0
3   I3  922.149      91      0.012      0
4   I4  812.928      95      0.011      0
5   I5 1457.534      87      0.016      0
6   I6  989.528      95      0.012      0
7   I7 1399.729      89      0.015      0
8   I8 1173.712      95      0.014      0
> (grm.R.us.item.fit <- itemfit(grm.R.us))
  item    S_X2 df.S_X2 RMSEA.S_X2 p.S_X2
1   R1 911.182      95      0.012      0
2   R2 360.818      89      0.007      0
3   R3 967.062      95      0.012      0
4   R4 656.690      92      0.010      0
5   R5 767.965      91      0.011      0
6   R6 597.243      88      0.010      0
7   R7 590.045      91      0.009      0
8   R8 774.987      88      0.011      0
> (grm.I.mx.item.fit <- itemfit(grm.I.mx))
  item   S_X2 df.S_X2 RMSEA.S_X2 p.S_X2
1   I1 64.334      53      0.027  0.137
2   I2 45.016      53      0.000  0.774
3   I3 34.698      33      0.013  0.387
4   I4 63.408      57      0.020  0.261
5   I5 30.131      35      0.000  0.702
6   I6 56.515      38      0.041  0.027
7   I7 44.229      40      0.019  0.298
8   I8 64.295      53      0.027  0.138
> (grm.R.mx.item.fit <- itemfit(grm.R.mx))
  item   S_X2 df.S_X2 RMSEA.S_X2 p.S_X2
1   R1 45.883      48      0.000  0.560
2   R2 50.895      35      0.040  0.040
3   R3 39.108      41      0.000  0.555
4   R4 32.779      38      0.000  0.709
5   R5 46.556      35      0.034  0.092
6   R6 49.785      35      0.039  0.050
7   R7 36.593      31      0.025  0.225
8   R8 36.750      33      0.020  0.299
