source("Parameters for simple PBPK model.R")

# Need to set out the sampling regimen.
regimen <- seq(0,24, by = 0.0001)

#For i in the above sequence calculate the delta values and incrament the previous C. value by delta.C and add
#each to it's respective vector

delta.time <- 0.0001

#Initiate what will be the output vector for each compartment
C.lung.profile <- 0
C.artery.profile <- 0
C.tissue.profile <- 0
C.vein.profile <- 0
C.liver.profile <- 0

#Set dose in mg
dose <- 5

#Adjust initial C.vein to replicate instantanious IV bolus
C.vein <- (dose / V.vein)

# Series of equations that define the change of concentration in model compartments over time.

#delta.C.lung <- ((Q.total * (C.vein - C.lung)) / (V.lung * Kp.lung)) * delta.time
#delta.C.artery <- (((C.lung / Kp.lung) - C.artery) * (Q.total / V.artery)) * delta.time
#delta.C.tissue <- ((Q.tissue * (C.artery - C.tissue)) / (V.tissue * Kp.tissue)) * delta.time
#delta.C.vein <- (((Q.tissue * C.tissue) / (V.vein * Kp.tissue)) - ((Q.total * C.vein) / V.vein)) * delta.time

#For each instance of the regiment calculate the new compartment concentration based on
for (i in regimen[1:length(regimen)-1]) {
  C.lung <- C.lung + (((Q.total * (C.vein - C.lung)) / (V.lung * Kp.lung)) * delta.time)
  C.lung.profile <- c(C.lung.profile, C.lung)
  
  C.artery <- C.artery + ((((C.lung / Kp.lung) - C.artery) * (Q.total / V.artery)) * delta.time)
  C.artery.profile <- c(C.artery.profile, C.artery)
  
  C.liver <- C.liver + (((Q.liver * (C.artery - C.liver)) / (V.liver * Kp.liver)) - ((CL.liver * C.artery) / V.liver))
  C.liver.profile <- c(C.liver.profile, C.liver)
  
  C.tissue <- C.tissue + (((Q.tissue * (C.artery - C.tissue)) / (V.tissue * Kp.tissue)) * delta.time)
  C.tissue.profile <- c(C.tissue.profile, C.tissue)
  
  C.vein <- C.vein + ((((Q.tissue * C.tissue) / (V.vein * Kp.tissue)) + ((Q.liver * C.liver) / (V.vein * Kp.liver)) - ((Q.total * C.vein) / V.vein)) * delta.time)
  C.vein.profile <- c(C.vein.profile, C.vein)
}
  