
#### GRM item parameters 

> (coef.table.R.us <- coef(grm.R.us, simplify = TRUE, IRTpars = TRUE)[[1]])
          a          b1         b2       b3       b4
R1 1.126604 -0.73710625 0.09015836 1.567236 2.793918
R2 2.450793 -0.07422890 0.50938235 1.199149 2.174729
R3 1.825728  0.62113730 1.24469736 1.911463 2.811191
R4 1.922336 -0.22225486 0.48986202 1.158666 2.029195
R5 2.726129  0.38543230 1.03505787 1.683096 2.410602
R6 2.652174 -0.17282781 0.42266234 1.061812 1.913063
R7 2.419310  0.03087381 0.75143936 1.505711 2.334052
R8 2.998250  0.03299906 0.63435115 1.236924 2.033152
> 

> (coef.table.I.us <- coef(grm.I.us, simplify = TRUE, IRTpars = TRUE)[[1]])
          a         b1         b2         b3        b4
I1 1.245140 -2.1507347 -1.2135424 -0.1978789 1.0527313
I2 1.726727 -1.6040079 -0.9296875 -0.1351497 0.9887348
I3 2.610633 -1.0712741 -0.5110345  0.1201409 1.0421587
I4 1.410096 -1.3119591 -0.5363832  0.3197185 1.4231952
I5 3.370779 -0.7680259 -0.2609589  0.3491456 1.1962691
I6 2.179420 -1.0232038 -0.4488324  0.2221575 1.1641402
I7 3.110585 -0.7293800 -0.1837765  0.4538565 1.2864868
I8 1.453786 -0.5624451  0.1117311  0.8683424 1.9804724

> (coef.table.R.mx <- coef(grm.R.mx, simplify = TRUE, IRTpars = TRUE)[[1]])
          a            b1          b2        b3       b4
R1 1.172588 -1.1199828729 -0.06624449 1.2712095 2.478995
R2 1.911925 -0.1386148615  0.61744446 1.5295418 2.668200
R3 1.462929  0.1138456043  1.12019077 1.6301384 2.846364
R4 2.148790 -0.5419656900  0.16271429 0.9006913 1.719689
R5 2.035026  0.0009304772  0.89959233 1.6762074 2.789506
R6 2.306137 -0.2297843097  0.42635748 1.1308990 2.045590
R7 2.464462 -0.1424709751  0.59558094 1.4412560 2.382581
R8 2.218247  0.1267339293  0.94113764 1.5984845 2.678404



#### CONSTRAINED BSELINE MODEL ####
"Investigative"

> model.constrained.I <- multipleGroup(I, 1, group.I, invariance = c(colnames(I), 'free_means', 'free_var'), technical = list(NCYCLES = 2000))
Iteration: 1115, Log-Lik: -667574.293, Max-Change: 0.00010
> coef(model.constrained.I, simplify = T) #different group latent means
$MX
$items
      a1    d1     d2     d3     d4
I1 1.173 2.786  1.617  0.351 -1.207
I2 1.627 2.915  1.750  0.379 -1.561
I3 2.463 3.021  1.557 -0.091 -2.501
I4 1.329 1.970  0.876 -0.332 -1.889
I5 3.178 2.878  1.168 -0.889 -3.747
I6 2.057 2.417  1.163 -0.300 -2.355
I7 2.931 2.534  0.836 -1.148 -3.737
I8 1.371 0.943 -0.036 -1.138 -2.755

$means
F1 
 0 

$cov
   F1
F1  1


$US
$items
      a1    d1     d2     d3     d4
I1 1.173 2.786  1.617  0.351 -1.207
I2 1.627 2.915  1.750  0.379 -1.561
I3 2.463 3.021  1.557 -0.091 -2.501
I4 1.329 1.970  0.876 -0.332 -1.889
I5 3.178 2.878  1.168 -0.889 -3.747
I6 2.057 2.417  1.163 -0.300 -2.355
I7 2.931 2.534  0.836 -1.148 -3.737
I8 1.371 0.943 -0.036 -1.138 -2.755

$means
    F1 
-0.089 

$cov
      F1
F1 1.126


> constrained.parameters.I <- coef(model.constrained.I, simplify = T)[[1]][[1]]
> constrained.parameters.I #write this out to excel and put it in the manuscript
         a1        d1          d2          d3        d4
I1 1.173140 2.7857827  1.61671864  0.35089303 -1.206655
I2 1.627119 2.9153405  1.75032608  0.37859148 -1.560929
I3 2.462825 3.0205924  1.55699431 -0.09089608 -2.501330
I4 1.329170 1.9700638  0.87584513 -0.33221471 -1.888777
I5 3.177695 2.8780800  1.16754216 -0.88914445 -3.747209
I6 2.056596 2.4173281  1.16321341 -0.30024573 -2.354916
I7 2.931230 2.5336939  0.83603344 -1.14782088 -3.737233
I8 1.371038 0.9430409 -0.03647125 -1.13779815 -2.754688


"Realistic"
> model.constrained.R <- multipleGroup(R, 1, group.R,invariance = c(colnames(R),'free_means', 'free_var'), technical = list(NCYCLES = 2000))
Iteration: 1086, Log-Lik: -544037.589, Max-Change: 0.00010
> coef(model.constrained.R, simplify = T) #different group latent means
$MX
$items
      a1     d1     d2     d3     d4
R1 0.927  0.962  0.028 -1.635 -3.018
R2 2.012  0.463 -0.967 -2.657 -5.046
R3 1.499 -0.920 -2.059 -3.273 -4.916
R4 1.581  0.651 -0.719 -2.006 -3.679
R5 2.237 -0.733 -2.503 -4.268 -6.252
R6 2.178  0.762 -0.817 -2.511 -4.767
R7 1.989  0.204 -1.539 -3.365 -5.370
R8 2.459  0.243 -1.559 -3.362 -5.747

$means
F1 
 0 

$cov
   F1
F1  1


$US
$items
      a1     d1     d2     d3     d4
R1 0.927  0.962  0.028 -1.635 -3.018
R2 2.012  0.463 -0.967 -2.657 -5.046
R3 1.499 -0.920 -2.059 -3.273 -4.916
R4 1.581  0.651 -0.719 -2.006 -3.679
R5 2.237 -0.733 -2.503 -4.268 -6.252
R6 2.178  0.762 -0.817 -2.511 -4.767
R7 1.989  0.204 -1.539 -3.365 -5.370
R8 2.459  0.243 -1.559 -3.362 -5.747

$means
    F1 
-0.139 

$cov
      F1
F1 1.481


> constrained.parameters.R <- coef(model.constrained.R, simplify = T)[[1]][[1]]
> constrained.parameters.R #write this out to excel and put it in the manuscript
          a1         d1          d2        d3        d4
R1 0.9265649  0.9615053  0.02827987 -1.635430 -3.017521
R2 2.0118130  0.4625136 -0.96740273 -2.657444 -5.046182
R3 1.4985377 -0.9196371 -2.05948903 -3.272993 -4.915938
R4 1.5811591  0.6505027 -0.71874697 -2.005539 -3.679117
R5 2.2373164 -0.7328524 -2.50347819 -4.268261 -6.252261
R6 2.1783590  0.7620495 -0.81654052 -2.510910 -4.767179
R7 1.9890963  0.2043293 -1.53909091 -3.364959 -5.369887
R8 2.4594466  0.2426487 -1.55889301 -3.362199 -5.747117



######## FIRST ROUND OF DIF - AOAA ######

"Investigative"
> (dif.drop.I <- DIF(model.constrained.I, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5, technical = list(NCYCLES = 2000))) #same as above
   converged    AIC  SABIC     HQ    BIC     X2 df     p
I1      TRUE -8.300 20.976  5.709 36.866 18.300  5 0.003
I2      TRUE  2.701 31.976 16.710 47.867  7.299  5 0.199
I3      TRUE  0.099 29.374 14.108 45.264  9.901  5 0.078
I4      TRUE  2.749 32.025 16.758 47.915  7.251  5 0.203
I5      TRUE -2.592 26.683 11.417 42.574 12.592  5 0.028
I6      TRUE -8.442 20.834  5.567 36.724 18.442  5 0.002
I7      TRUE  8.434 37.710 22.443 53.600  1.566  5 0.905
I8      TRUE -6.964 22.312  7.045 38.202 16.964  5 0.005

> # Adam's function that tables the output --> all items have DIF
> get.dif.items(f.data=dif.drop.I, p.val=.05, parms=constrained.parameters.I)
$dif_items
         X2 df     p sig       a1        d1          d2         d3        d4
I1 18.29964  5 0.003 dif 1.173140 2.7857827  1.61671864  0.3508930 -1.206655
I5 12.59202  5 0.028 dif 3.177695 2.8780800  1.16754216 -0.8891444 -3.747209
I6 18.44170  5 0.002 dif 2.056596 2.4173281  1.16321341 -0.3002457 -2.354916
I8 16.96394  5 0.005 dif 1.371038 0.9430409 -0.03647125 -1.1377982 -2.754688

$no_dif
         X2 df     p    sig       a1       d1        d2          d3        d4
I7 1.565723  5 0.905 no_dif 2.931230 2.533694 0.8360334 -1.14782088 -3.737233
I3 9.901484  5 0.078 no_dif 2.462825 3.020592 1.5569943 -0.09089608 -2.501330
I2 7.299061  5 0.199 no_dif 1.627119 2.915341 1.7503261  0.37859148 -1.560929
I4 7.250716  5 0.203 no_dif 1.329170 1.970064 0.8758451 -0.33221471 -1.888777

"Realistic"
> (dif.drop.R <- DIF(model.constrained.R, c('a1','d1','d2','d3','d4'), scheme="drop", seq_stat = 0.5, technical = list(NCYCLES = 2000)))
   converged     AIC  SABIC      HQ    BIC     X2 df     p
R1      TRUE   1.670 30.946  15.679 46.836  8.330  5 0.139
R2      TRUE  -0.046 29.230  13.963 45.120 10.046  5 0.074
R3      TRUE -27.556  1.719 -13.547 17.609 37.556  5 0.000
R4      TRUE  -6.040 23.236   7.969 39.126 16.040  5 0.007
R5      TRUE -13.105 16.170   0.904 32.060 23.105  5 0.000
R6      TRUE   4.475 33.750  18.484 49.641  5.525  5 0.355
R7      TRUE   6.182 35.457  20.191 51.347  3.818  5 0.576
R8      TRUE -29.117  0.159 -15.108 16.049 39.117  5 0.000

> # Adam's function that tables the output --> all items have DIF
> get.dif.items(f.data=dif.drop.R, p.val=.05, parms=constrained.parameters.R)
$dif_items
         X2 df     p sig       a1         d1        d2        d3        d4
R3 37.55632  5 0.000 dif 1.498538 -0.9196371 -2.059489 -3.272993 -4.915938
R4 16.03989  5 0.007 dif 1.581159  0.6505027 -0.718747 -2.005539 -3.679117
R5 23.10548  5 0.000 dif 2.237316 -0.7328524 -2.503478 -4.268261 -6.252261
R8 39.11682  5 0.000 dif 2.459447  0.2426487 -1.558893 -3.362199 -5.747117

$no_dif
          X2 df     p    sig        a1        d1          d2        d3        d4
R6  5.524984  5 0.355 no_dif 2.1783590 0.7620495 -0.81654052 -2.510910 -4.767179
R2 10.045698  5 0.074 no_dif 2.0118130 0.4625136 -0.96740273 -2.657444 -5.046182
R7  3.818494  5 0.576 no_dif 1.9890963 0.2043293 -1.53909091 -3.364959 -5.369887
R1  8.329864  5 0.139 no_dif 0.9265649 0.9615053  0.02827987 -1.635430 -3.017521



##### RESULTS FROM RUNNING AN ANCHOR MODEL #####

"Investigative"
> test.items.I <- c(1,5,6,8)
> anc.items.names.I <- itemnames.I[c(3,7)] 
> test.items.I <- c(1,5,6,8)
> model_anchor.I <- multipleGroup(I, model = 1, group = group.I,
+                                 invariance = c(anc.items.names.I, 'free_means', 'free_var'), 
+                                 technical = list(NCYCLES = 2000))
Iteration: 1445, Log-Lik: -667537.058, Max-Change: 0.00010
> (anchor.parms.I <-coef(model_anchor.I,simplify = TRUE)[[1]][[1]])
         a1       d1        d2          d3        d4
I1 1.170680 3.462840 1.6432814  0.09656168 -1.574103
I2 1.543673 2.668909 1.3837511  0.06518732 -1.606256
I3 2.420521 3.031318 1.5676673 -0.08027964 -2.490780
I4 1.477570 2.102471 0.8376833 -0.60025892 -2.322524
I5 3.528477 3.677821 1.5492793 -0.62373468 -4.116629
I6 2.773525 3.022985 1.1513921 -0.62709424 -3.169667
I7 2.880511 2.546165 0.8486218 -1.13513589 -3.724370
I8 1.604243 1.402370 0.5020252 -0.93185122 -2.636127
> 

"Realistic"
> itemnames.R <- colnames(R)
> anc.items.names.R <- itemnames.R[c(2,6)] 
> test.items.R <- c(3,4,5,8)
> model_anchor.R <- multipleGroup(R, model = 1, group = group.R,
+                                 invariance = c(anc.items.names.R, 'free_means', 'free_var'),
+                                 technical = list(NCYCLES = 2000))
Iteration: 1287, Log-Lik: -543974.976, Max-Change: 0.00010

> (anchor.parms.R <-coef(model_anchor.R,simplify = TRUE)[[1]][[1]])
         a1          d1          d2        d3        d4
R1 1.147543  1.30036148  0.06445278 -1.505539 -2.923472
R2 1.939553  0.26463484 -1.16566374 -2.856251 -5.245930
R3 1.424542 -0.18114827 -1.65417090 -2.400434 -4.179661
R4 2.085022  1.13976560 -0.36936059 -1.953385 -3.711717
R5 1.986419 -0.02090212 -1.85426221 -3.438201 -5.707990
R6 2.099496  0.54773036 -1.03098285 -2.725504 -4.982226
R7 2.407027  0.32968460 -1.49359337 -3.585095 -5.913207
R8 2.159003 -0.30071925 -2.10924825 -3.568809 -5.965770



###### FINAL ROUND OF DIF (A5?) ######

"Investigative"
E, technical = list(NCYCLES = 2000)))
No DIF items were detected for plotting.
   converged    AIC  SABIC     HQ    BIC     X2 df     p
I1      TRUE -6.141 17.279  5.066 29.991 14.141  4 0.007
I5      TRUE  1.772 25.192 12.979 37.904  6.228  4 0.183
I6      TRUE -4.638 18.783  6.569 31.495 12.638  4 0.013
I8      TRUE -6.179 17.241  5.028 29.953 14.179  4 0.007
> ## use the optional function to table the output
> get.dif.items(f.data=dif.anchor.I, p.val=.05, parms = anchor.parms.I)
$dif_items
       X2 df     p sig
I1 14.141  4 0.007 dif
I6 12.638  4 0.013 dif
I8 14.179  4 0.007 dif

$no_dif
      X2 df     p    sig
I5 6.228  4 0.183 no_dif

$warnings
[1] "There number of item parameters doesn't match the number of items  given to get.dif.items. Item parameters omitted."

> 

"Realistic"
> (dif.anchor.R <- DIF(model_anchor.R, c('a1','d1','d2','d3'), items2test = test.items.R, plotdif = TRUE,technical = list(NCYCLES = 2000)))
   converged     AIC   SABIC      HQ    BIC     X2 df     p
R3      TRUE -37.919 -14.499 -26.712 -1.787 45.919  4 0.000
R4      TRUE -15.307   8.113  -4.100 20.825 23.307  4 0.000
R5      TRUE -22.347   1.073 -11.140 13.785 30.347  4 0.000
R8      TRUE   1.113  24.534  12.320 37.246  6.887  4 0.142
> ## use the optional function to table the output
> get.dif.items(f.data=dif.anchor.R, p.val=.05, parms = anchor.parms.R)
$dif_items
       X2 df p sig
R3 45.919  4 0 dif
R4 23.307  4 0 dif
R5 30.347  4 0 dif

$no_dif
      X2 df     p    sig
R8 6.887  4 0.142 no_dif

$warnings
[1] "There number of item parameters doesn't match the number of items  given to get.dif.items. Item parameters omitted."



##### EFFECT SIZES #####

"Investigative"
> empirical_ES(model_anchor.I, DIF=FALSE)  # test level stats
          Effect Size       Value
1                STDS  0.08153061
2                UTDS  0.72893218
3              UETSDS  0.19652335
4               ETSSD  0.01068545
5         Starks.DTFR  0.08417111
6               UDTFR  0.73492615
7              UETSDN  0.19656530
8 theta.of.max.test.D -1.37119752
9           Test.Dmax  0.41441987

> empirical_ES(model_anchor.I)             # item level stats
         SIDS  UIDS   SIDN  UIDN   ESSD theta.of.max.D  max.D mean.ES.foc mean.ES.ref
item.1  0.060 0.079  0.062 0.079  0.091         -2.491 -0.126       2.476       2.416
item.2  0.129 0.129  0.131 0.131  0.150         -0.553  0.168       2.401       2.272
item.3  0.000 0.000  0.000 0.000  0.000          1.015  0.000       2.135       2.135
item.4  0.097 0.097  0.098 0.098  0.117         -1.316  0.133       2.035       1.938
item.5 -0.089 0.089 -0.091 0.091 -0.077          0.106 -0.137       1.867       1.956
item.6  0.093 0.123  0.095 0.125  0.086         -1.193  0.247       2.040       1.947
item.7  0.000 0.000  0.000 0.000  0.000          1.015  0.000       1.778       1.778
item.8 -0.208 0.210 -0.210 0.211 -0.241          1.181 -0.324       1.497       1.706

"Realistic"
> empirical_ES(model_anchor.R, DIF=FALSE)  # test level stats
          Effect Size      Value
1                STDS -0.9878369
2                UTDS  1.2431597
3              UETSDS  0.9997037
4               ETSSD -0.1457648
5         Starks.DTFR -1.0029753
6               UDTFR  1.2408127
7              UETSDN  1.0093755
8 theta.of.max.test.D  1.8091088
9           Test.Dmax -2.0598134

> empirical_ES(model_anchor.R)             # item level stats
         SIDS  UIDS   SIDN  UIDN   ESSD theta.of.max.D  max.D mean.ES.foc mean.ES.ref
item.1 -0.152 0.170 -0.152 0.162 -0.220          2.737 -0.451       1.391       1.543
item.2  0.000 0.000  0.000 0.000  0.000         -0.071  0.000       1.049       1.049
item.3 -0.300 0.300 -0.305 0.305 -0.433          1.700 -0.535       0.597       0.897
item.4 -0.260 0.277 -0.263 0.273 -0.265          1.765 -0.610       1.167       1.428
item.5 -0.240 0.240 -0.255 0.255 -0.304          0.846 -0.395       0.644       0.885
item.6  0.000 0.000  0.000 0.000  0.000         -0.071  0.000       1.145       1.145
item.7 -0.138 0.151 -0.131 0.141 -0.156          2.309 -0.401       0.884       1.022
item.8  0.103 0.104  0.104 0.104  0.115          1.204  0.213       0.944       0.841