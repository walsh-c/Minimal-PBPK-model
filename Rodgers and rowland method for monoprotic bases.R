## Read in source files

drug <- read.csv("~/PhD Work/Minimal PBPK model/Verapimil.csv", row.names=1)
organism <- read.csv("~/PhD Work/Minimal PBPK model/Human Q + V values.csv", row.names=1)
params <- read.csv("~/PhD Work/Minimal PBPK model/parameters for rodgers +rowland.csv", row.names=1)


## Define constants where needed

P <- 10^(drug$LogP)

## Determine a proxy Ka value from the drug B:P ratio

c <- params[1,]
a <- 10^(drug$pKa-c$pH.blood)
b <- 10^(drug$pKa-c$pH.P)
KpuBC <- (c$hematocrit - 1 + drug$BP) / (drug$fu * c$hematocrit)

Ka <- (KpuBC - (((1 + a) / (1 + b)) * c$f.IW.blood) - ((P * c$f.NL.blood + (0.3 * P + 0.7) * c$f.NP.blood)) / (1 + b)) * (( 1 + b) / (c$AC.PL.blood * a))

## Using the determined Ka predict Kpu using the rodgers + rowland method

d <- 10^(drug$pKa-c$pH.IW)

Kpu <- params$f.EW + ((1+d)/(1+b))*params$f.IW + (Ka[1] * params$AC.PL * d)/(1 + b) + ((P * params$f.NL) + ((0.3*P + 0.7) * params$f.NP))/(1+b)

## Add additional NA values for vein, artery, stomach and hepatic artery and add the col to the Q&V data frame.

Kpu <- c(Kpu, rep(NA,4))
organism$Kpu <- Kpu
