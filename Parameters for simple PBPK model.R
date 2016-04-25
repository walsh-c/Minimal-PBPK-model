# This script should load all the parameters required for the running of a simple PBPK model
# with only a lung and single lumped tissue compartment.

# Constants
# V. represents a volume in mL
# Q. represents a flow rate in mL/h
# Kp. are tissue partition coeficients
V.vein    <- 3396
V.artery  <- 1690
V.lung    <- 1172
V.tissue  <- 35000
V.liver   <- 1690
Q.total   <- 45000 + 99000
Q.tissue  <- 45000
Q.liver   <- 99000
Kp.lung   <- 1
Kp.tissue <- 1
Kp.liver  <- 1
CL.liver  <- 0.01
  
# Initial assignments
# C. is the concentration in its respective compartment
# when t = 0 all C. should = 0
C.vein    <- 0
C.artery  <- 0
C.lung    <- 0
C.tissue  <- 0
C.liver   <- 0