library(deSolve)

path <- "~/PhD Work/Minimal PBPK model/Minimal-PBPK-model/"

drug <- read.csv(paste(path, "Verapimil.csv", sep = ""))
organism <- read.csv(paste(path, "organism.csv", sep = ""), row.names = 1)
parameters <- read.csv(paste(path, "parameters.csv", sep = ""), row.names = 1)
state <- c(C.Vein = 0.00147232, C.Artery = 0, C.Liver = 0, C.Kidney = 0, C.Gut = 0, C.Stomach = 0, C.Lungs = 0,
           C.Thymus = 0, C.Pancreas = 0, C.Spleen = 0, C.Skin = 0, C.Muscle = 0, C.Heart = 0, C.Brain = 0, C.Adipose =0,
           C.Bone = 0)
time <- seq(0, 24, by = 0.001)

source(paste(path, "/differentials for PBPK model.R", sep = ""))

out <- ode(y = state, times = time, func = PBPK, parms = c(drug, organism, parameters))

print(head(out))
