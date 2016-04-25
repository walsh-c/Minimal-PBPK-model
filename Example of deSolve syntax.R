PBPK.model <- function (t, state, params) {
  with(as.list(c(state,params)), {
    dLung = (Q.total * (C.vein - C.lung)) / (V.lung * Kp.lung)
    dArtery = ((C.lung / Kp.lung) - C.artery) * (Q.total / V.artery)
    dTissue = (Q.tissue * (C.artery - C.tissue)) / (V.tissue * Kp.tissue)
    dVein = ((Q.tissue * C.tissue) / (V.vein * Kp.tissue)) - ((Q.total * C.vein) / V.vein)
    
    list(c(dLung, dArtery, dTissue, dVein))
  })
}

parameters <- c(
  V.vein    = 3396,
  V.artery  = 1690,
  V.lung    = 1172,
  V.tissue  = 35000,
  Q.total   = 45000,
  Q.tissue  = 45000,
  Kp.lung   = 1,
  Kp.tissue = 1
)

state <- c(
  C.vein    = 5/3396,
  C.artery  = 0,
  C.lung    = 0,
  C.tissue  = 0
)

t <- seq(0,24,0.001)

out <- ode(y = state, times = t, func = PBPK.model, parms = parameters)

head(out)