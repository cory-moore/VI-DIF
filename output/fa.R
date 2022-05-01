

> " OBLIQUE ROTATION  "

"########      Investigative      ##########"
> efa.I <- fa(I, nfactors=1, rotate="oblimin") #Investigative dimension
> print(efa.I, sort=TRUE)

Factor Analysis using method =  minres
Call: fa(r = I, nfactors = 1, rotate = "oblimin")
Standardized loadings (pattern matrix) based upon correlation matrix
   V  MR1   h2   u2 com
I5 5 0.82 0.68 0.32   1
I7 7 0.80 0.64 0.36   1
I3 3 0.80 0.64 0.36   1
I6 6 0.75 0.56 0.44   1
I2 2 0.67 0.44 0.56   1
I8 8 0.59 0.35 0.65   1
I4 4 0.57 0.33 0.67   1
I1 1 0.54 0.29 0.71   1

                MR1
SS loadings    3.94
Proportion Var 0.49

Mean item complexity =  1
Test of the hypothesis that 1 factor is sufficient.

The degrees of freedom for the null model are  28  and the objective function was  4.3 with Chi Square of  266194.6
The degrees of freedom for the model are 20  and the objective function was  0.85 

The root mean square of the residuals (RMSR) is  0.1 
The df corrected root mean square of the residuals is  0.12 

The harmonic number of observations is  61890 with the empirical chi square  33038.67  with prob <  0 
The total number of observations was  61890  with Likelihood Chi Square =  52844.26  with prob <  0 

Tucker Lewis Index of factoring reliability =  0.722
RMSEA index =  0.207  and the 90 % confidence intervals are  0.205 0.208
BIC =  52623.6
Fit based upon off diagonal values = 0.96
Measures of factor score adequacy             
                                                   MR1
Correlation of (regression) scores with factors   0.95
Multiple R square of scores with factors          0.90
Minimum correlation of possible factor scores     0.81

> efa.I$values #EFA eigenvalues - unidimensional (factor two eigenvalue <.1)
[1]  3.938118060  0.626432698  0.076458875  0.008239151 -0.118225229 -0.145142114 -0.213692211 -0.234071240

> efa.I$loadings

Loadings:
   MR1  
I1 0.541
I2 0.667
I3 0.797
I4 0.573
I5 0.824
I6 0.751
I7 0.803
I8 0.590

                 MR1
SS loadings    3.938
Proportion Var 0.492

"############      Realistic       ############"

> efa.R <- fa(R, nfactors=1, rotate="oblimin")
> print(efa.R, sort=TRUE)
Factor Analysis using method =  minres
Call: fa(r = R, nfactors = 1, rotate = "oblimin")
Standardized loadings (pattern matrix) based upon correlation matrix
   V  MR1   h2   u2 com
R8 8 0.78 0.61 0.39   1
R6 6 0.76 0.58 0.42   1
R5 5 0.75 0.56 0.44   1
R7 7 0.75 0.56 0.44   1
R2 2 0.73 0.54 0.46   1
R4 4 0.68 0.46 0.54   1
R3 3 0.60 0.36 0.64   1
R1 1 0.50 0.25 0.75   1

                MR1
SS loadings    3.91
Proportion Var 0.49

Mean item complexity =  1
Test of the hypothesis that 1 factor is sufficient.

The degrees of freedom for the null model are  28  and the objective function was  3.74 with Chi Square of  231638.3
The degrees of freedom for the model are 20  and the objective function was  0.42 

The root mean square of the residuals (RMSR) is  0.06 
The df corrected root mean square of the residuals is  0.07 

The harmonic number of observations is  61890 with the empirical chi square  13782.24  with prob <  0 
The total number of observations was  61890  with Likelihood Chi Square =  26175.35  with prob <  0 

Tucker Lewis Index of factoring reliability =  0.842
RMSEA index =  0.145  and the 90 % confidence intervals are  0.144 0.147
BIC =  25954.68
Fit based upon off diagonal values = 0.98
Measures of factor score adequacy             
                                                   MR1
Correlation of (regression) scores with factors   0.95
Multiple R square of scores with factors          0.89
Minimum correlation of possible factor scores     0.79
> efa.R$values #EFA eigenvalues - unidimensional (factor two eigenvalue <.1)
[1]  3.90702866  0.38425498  0.10921044 -0.01473937 -0.06663823 -0.10592743 -0.13957426 -0.16658621
> efa.R$loadings

Loadings:
   MR1  
R1 0.496
R2 0.732
R3 0.597
R4 0.680
R5 0.749
R6 0.763
R7 0.747
R8 0.779

                 MR1
SS loadings    3.907
Proportion Var 0.488



" ####  CHECK 2-FACTOR STRUCTURE  ####"

 #double-check 2-factor solutions
> efa.I2 <- fa(I, nfactors=2, rotate="oblimin")
> print(efa.I2, sort=TRUE)
Factor Analysis using method =  minres
Call: fa(r = I, nfactors = 2, rotate = "oblimin")
Standardized loadings (pattern matrix) based upon correlation matrix
   item   MR1   MR2   h2   u2 com
I6    6  0.85  0.00 0.72 0.28 1.0
I2    2  0.81 -0.06 0.61 0.39 1.0
I3    3  0.78  0.10 0.73 0.27 1.0
I8    8  0.48  0.16 0.36 0.64 1.2
I4    4 -0.15  0.82 0.53 0.47 1.1
I5    5  0.17  0.75 0.75 0.25 1.1
I7    7  0.16  0.73 0.71 0.29 1.1
I1    1 -0.05  0.66 0.39 0.61 1.0

                       MR1  MR2
SS loadings           2.44 2.36
Proportion Var        0.30 0.30
Cumulative Var        0.30 0.60
Proportion Explained  0.51 0.49
Cumulative Proportion 0.51 1.00

 With factor correlations of 
     MR1  MR2
MR1 1.00 0.64
MR2 0.64 1.00

Mean item complexity =  1.1
Test of the hypothesis that 2 factors are sufficient.

The degrees of freedom for the null model are  28  and the objective function was  4.3 with Chi Square of  266194.6
The degrees of freedom for the model are 13  and the objective function was  0.18 

The root mean square of the residuals (RMSR) is  0.03 
The df corrected root mean square of the residuals is  0.05 

The harmonic number of observations is  61890 with the empirical chi square  3785.77  with prob <  0 
The total number of observations was  61890  with Likelihood Chi Square =  11201.72  with prob <  0 

Tucker Lewis Index of factoring reliability =  0.909
RMSEA index =  0.118  and the 90 % confidence intervals are  0.116 0.12
BIC =  11058.29
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                   MR1  MR2
Correlation of (regression) scores with factors   0.94 0.93
Multiple R square of scores with factors          0.89 0.87
Minimum correlation of possible factor scores     0.78 0.75
> efa.I2$values  #EFA eigenvalues.  REPORT THESE
[1]  4.04339236  0.75877935  0.16475864  0.10941093 -0.02726506 -0.05762789 -0.08847754 -0.10079916
> efa.I2$loadings

Loadings:
   MR1    MR2   
I1         0.657
I2  0.815       
I3  0.784  0.104
I4 -0.154  0.815
I5  0.166  0.752
I6  0.850       
I7  0.159  0.734
I8  0.485  0.159

                 MR1   MR2
SS loadings    2.315 2.241
Proportion Var 0.289 0.280
Cumulative Var 0.289 0.569
> fa.diagram(efa.I2)
> efa.R2 <- fa(R, nfactors=2, rotate="oblimin")
> print(efa.R2, sort=TRUE)
Factor Analysis using method =  minres
Call: fa(r = R, nfactors = 2, rotate = "oblimin")
Standardized loadings (pattern matrix) based upon correlation matrix
   item   MR2   MR1   h2   u2 com
R7    7  0.83 -0.03 0.66 0.34 1.0
R4    4  0.72  0.01 0.52 0.48 1.0
R5    5  0.67  0.13 0.59 0.41 1.1
R1    1  0.61 -0.09 0.31 0.69 1.0
R3    3  0.40  0.23 0.35 0.65 1.6
R8    8 -0.02  0.90 0.78 0.22 1.0
R2    2 -0.02  0.84 0.68 0.32 1.0
R6    6  0.25  0.57 0.60 0.40 1.4

                       MR2  MR1
SS loadings           2.41 2.07
Proportion Var        0.30 0.26
Cumulative Var        0.30 0.56
Proportion Explained  0.54 0.46
Cumulative Proportion 0.54 1.00

 With factor correlations of 
     MR2  MR1
MR2 1.00 0.73
MR1 0.73 1.00

Mean item complexity =  1.1
Test of the hypothesis that 2 factors are sufficient.

The degrees of freedom for the null model are  28  and the objective function was  3.74 with Chi Square of  231638.3
The degrees of freedom for the model are 13  and the objective function was  0.07 

The root mean square of the residuals (RMSR) is  0.02 
The df corrected root mean square of the residuals is  0.04 

The harmonic number of observations is  61890 with the empirical chi square  2155.65  with prob <  0 
The total number of observations was  61890  with Likelihood Chi Square =  4564.96  with prob <  0 

Tucker Lewis Index of factoring reliability =  0.958
RMSEA index =  0.075  and the 90 % confidence intervals are  0.073 0.077
BIC =  4421.52
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                   MR2  MR1
Correlation of (regression) scores with factors   0.93 0.94
Multiple R square of scores with factors          0.86 0.89
Minimum correlation of possible factor scores     0.72 0.77
> efa.R2$values  #EFA eigenvalues.  REPORT THESE
[1]  3.98530533  0.49374092  0.13259443  0.04451068  0.01029834 -0.02442805 -0.05614371 -0.10683158
> efa.R2$loadings

Loadings:
   MR2    MR1   
R1  0.613       
R2         0.838
R3  0.397  0.235
R4  0.718       
R5  0.667  0.128
R6  0.253  0.567
R7  0.830       
R8         0.897

                 MR2   MR1
SS loadings    2.246 1.908
Proportion Var 0.281 0.238
Cumulative Var 0.281 0.519
> fa.diagram(efa.R2)
> 