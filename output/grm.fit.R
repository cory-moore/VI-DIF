

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
> coef(grm.I.us)
$I1
           a1    d1    d2    d3     d4
par     1.245 2.678 1.511 0.246 -1.311
CI_2.5  1.224 2.646 1.487 0.226 -1.334
CI_97.5 1.266 2.710 1.535 0.267 -1.288

$I2
           a1    d1    d2    d3     d4
par     1.727 2.770 1.605 0.233 -1.707
CI_2.5  1.698 2.734 1.577 0.210 -1.736
CI_97.5 1.755 2.806 1.633 0.257 -1.679

$I3
           a1    d1    d2     d3     d4
par     2.611 2.797 1.334 -0.314 -2.721
CI_2.5  2.569 2.754 1.301 -0.344 -2.763
CI_97.5 2.652 2.840 1.367 -0.284 -2.678

$I4
           a1    d1    d2     d3     d4
par     1.410 1.850 0.756 -0.451 -2.007
CI_2.5  1.387 1.823 0.734 -0.472 -2.034
CI_97.5 1.433 1.877 0.778 -0.429 -1.979

$I5
           a1    d1    d2     d3     d4
par     3.371 2.589 0.880 -1.177 -4.032
CI_2.5  3.312 2.540 0.842 -1.216 -4.097
CI_97.5 3.429 2.638 0.917 -1.137 -3.967

$I6
           a1    d1    d2     d3     d4
par     2.179 2.230 0.978 -0.484 -2.537
CI_2.5  2.145 2.195 0.950 -0.511 -2.574
CI_97.5 2.214 2.265 1.007 -0.457 -2.500

$I7
           a1    d1    d2     d3     d4
par     3.111 2.269 0.572 -1.412 -4.002
CI_2.5  3.059 2.225 0.537 -1.450 -4.062
CI_97.5 3.162 2.312 0.606 -1.374 -3.941

$I8
           a1    d1     d2     d3     d4
par     1.454 0.818 -0.162 -1.262 -2.879
CI_2.5  1.430 0.795 -0.184 -1.286 -2.914
CI_97.5 1.477 0.840 -0.141 -1.238 -2.845

$GroupPars
        MEAN_1 COV_11
par          0      1
CI_2.5      NA     NA
CI_97.5     NA     NA

> M2(grm.I.us, type="C2")
            M2 df p     RMSEA   RMSEA_5  RMSEA_95      SRMSR       TLI       CFI
stats 67228.28 20 0 0.2335565 0.2320744 0.2350383 0.09921723 0.7805648 0.8432606
> 
> coef(grm.R.us)
$R1
           a1    d1     d2     d3     d4
par     1.127 0.830 -0.102 -1.766 -3.148
CI_2.5  1.106 0.810 -0.121 -1.790 -3.184
CI_97.5 1.147 0.851 -0.082 -1.741 -3.111

$R2
           a1    d1     d2     d3     d4
par     2.451 0.182 -1.248 -2.939 -5.330
CI_2.5  2.412 0.153 -1.281 -2.981 -5.399
CI_97.5 2.489 0.211 -1.216 -2.896 -5.261

$R3
           a1     d1     d2     d3     d4
par     1.826 -1.134 -2.272 -3.490 -5.132
CI_2.5  1.793 -1.162 -2.307 -3.534 -5.201
CI_97.5 1.859 -1.106 -2.238 -3.445 -5.064

$R4
           a1    d1     d2     d3     d4
par     1.922 0.427 -0.942 -2.227 -3.901
CI_2.5  1.893 0.402 -0.968 -2.260 -3.947
CI_97.5 1.952 0.453 -0.915 -2.195 -3.854

$R5
           a1     d1     d2     d3     d4
par     2.726 -1.051 -2.822 -4.588 -6.572
CI_2.5  2.679 -1.086 -2.868 -4.653 -6.666
CI_97.5 2.773 -1.015 -2.775 -4.524 -6.477

$R6
           a1    d1     d2     d3     d4
par     2.652 0.458 -1.121 -2.816 -5.074
CI_2.5  2.612 0.427 -1.154 -2.859 -5.138
CI_97.5 2.693 0.489 -1.088 -2.774 -5.009

$R7
           a1     d1     d2     d3     d4
par     2.419 -0.075 -1.818 -3.643 -5.647
CI_2.5  2.381 -0.104 -1.853 -3.692 -5.721
CI_97.5 2.458 -0.045 -1.783 -3.594 -5.573

$R8
           a1     d1     d2     d3     d4
par     2.998 -0.099 -1.902 -3.709 -6.096
CI_2.5  2.949 -0.133 -1.943 -3.764 -6.180
CI_97.5 3.048 -0.065 -1.861 -3.653 -6.012

$GroupPars
        MEAN_1 COV_11
par          0      1
CI_2.5      NA     NA
CI_97.5     NA     NA

> M2(grm.R.us, type="C2")
            M2 df p     RMSEA   RMSEA_5  RMSEA_95      SRMSR       TLI       CFI
stats 25715.47 20 0 0.1444138 0.1429333 0.1458976 0.06721027 0.9133646 0.9381176
> 
> coef(grm.I.mx)
$I1
           a1    d1    d2     d3     d4
par     1.191 3.468 1.654  0.117 -1.544
CI_2.5  0.899 2.872 1.296 -0.177 -1.891
CI_97.5 1.483 4.063 2.013  0.411 -1.197

$I2
           a1    d1    d2     d3     d4
par     1.652 2.746 1.440  0.095 -1.605
CI_2.5  1.287 2.247 1.054 -0.242 -1.996
CI_97.5 2.017 3.246 1.826  0.433 -1.215

$I3
           a1    d1    d2     d3     d4
par     3.214 3.649 1.887  0.189 -3.076
CI_2.5  2.526 2.861 1.284 -0.328 -3.782
CI_97.5 3.903 4.436 2.490  0.705 -2.369

$I4
           a1    d1    d2     d3     d4
par     1.475 2.094 0.850 -0.563 -2.261
CI_2.5  1.140 1.675 0.514 -0.887 -2.688
CI_97.5 1.809 2.514 1.186 -0.239 -1.835

$I5
           a1    d1    d2     d3     d4
par     3.461 3.592 1.555 -0.527 -3.891
CI_2.5  2.687 2.762 0.942 -1.082 -4.747
CI_97.5 4.236 4.422 2.168  0.027 -3.034

$I6
           a1    d1    d2     d3     d4
par     2.937 3.135 1.225 -0.588 -3.176
CI_2.5  2.331 2.464 0.712 -1.076 -3.860
CI_97.5 3.543 3.807 1.738 -0.100 -2.491

$I7
           a1    d1    d2     d3     d4
par     3.010 2.760 0.925 -1.174 -3.665
CI_2.5  2.375 2.110 0.412 -1.697 -4.408
CI_97.5 3.644 3.409 1.439 -0.651 -2.922

$I8
           a1    d1    d2     d3     d4
par     1.667 1.439 0.538 -0.903 -2.617
CI_2.5  1.305 1.059 0.194 -1.259 -3.100
CI_97.5 2.030 1.820 0.881 -0.546 -2.133

$GroupPars
        MEAN_1 COV_11
par          0      1
CI_2.5      NA     NA
CI_97.5     NA     NA

> M2(grm.I.mx, type="C2")
            M2 df p     RMSEA  RMSEA_5  RMSEA_95      SRMSR       TLI       CFI
stats 209.8853 20 0 0.1828401 0.160619 0.2052746 0.07464948 0.8847164 0.9176546
> 
> coef(grm.R.mx)
$R1
           a1    d1     d2     d3     d4
par     1.173 1.313  0.078 -1.491 -2.907
CI_2.5  0.865 0.978 -0.214 -1.834 -3.404
CI_97.5 1.480 1.649  0.369 -1.148 -2.410

$R2
           a1     d1     d2     d3     d4
par     1.912  0.265 -1.181 -2.924 -5.101
CI_2.5  1.450 -0.105 -1.587 -3.488 -6.077
CI_97.5 2.373  0.635 -0.774 -2.360 -4.125

$R3
           a1     d1     d2     d3     d4
par     1.463 -0.167 -1.639 -2.385 -4.164
CI_2.5  1.079 -0.493 -2.032 -2.843 -4.916
CI_97.5 1.847  0.160 -1.246 -1.926 -3.412

$R4
           a1    d1     d2     d3     d4
par     2.149 1.165 -0.350 -1.935 -3.695
CI_2.5  1.669 0.739 -0.748 -2.413 -4.361
CI_97.5 2.629 1.590  0.049 -1.458 -3.029

$R5
           a1     d1     d2     d3     d4
par     2.035 -0.002 -1.831 -3.411 -5.677
CI_2.5  1.546 -0.388 -2.304 -4.053 -6.804
CI_97.5 2.524  0.384 -1.358 -2.769 -4.549

$R6
           a1    d1     d2     d3     d4
par     2.306 0.530 -0.983 -2.608 -4.717
CI_2.5  1.771 0.111 -1.426 -3.178 -5.591
CI_97.5 2.842 0.949 -0.541 -2.038 -3.844

$R7
           a1     d1     d2     d3     d4
par     2.464  0.351 -1.468 -3.552 -5.872
CI_2.5  1.876 -0.084 -1.964 -4.265 -7.050
CI_97.5 3.052  0.786 -0.972 -2.839 -4.694

$R8
           a1     d1     d2     d3     d4
par     2.218 -0.281 -2.088 -3.546 -5.941
CI_2.5  1.673 -0.695 -2.610 -4.236 -7.159
CI_97.5 2.763  0.132 -1.565 -2.856 -4.724

$GroupPars
        MEAN_1 COV_11
par          0      1
CI_2.5      NA     NA
CI_97.5     NA     NA

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
