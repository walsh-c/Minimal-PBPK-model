PBPK.model <- function (t, state, params) {
  with(as.list(c(state, params)), {
    dVein = sum(all the other tissues) - ((Q.total * C.vein) / V.vein)
    dArtery = ((C.lung / Kp.lung) - C.artery) * (Q.total / V.artery)
    dLiver = ((C.artery * (Q.liver - Q.intestine - Q.pancreas)) / V.liver) + (Q.intestine * C.intestine) / (V.liver * Kp.liver) + (Q.pancreas * C.pancreas) / (V.liver * Kp.pancreas) - (Q.liver * C.liver) / (V.liver * Kp.liver) - (C.artery * (Q.liver * fu * CLint.liver)) / (V.liver *(Q.liver + fu*CLint.liver))
    dLung = (Q.total * (C.vein - C.lung)) / (V.lung * Kp.lung)
    dPancreas = (Q.pancreas * (C.artery - C.pancreas)) / (V.pancreas * Kp.pancreas)
    dS.intestine = (Q.intestine  * (C.artery - C.intestine)) / (V.intsetine * Kp.intestine) - (CL.intestine * C.artery) / V.intestine
    dOther = (Q.other * (C.artery - C.other)) / (V.other * Kp.other)
    dKidney = (Q.kidney  * (C.artery - C.kidney) / (V.kidney * Kp.kidney) - (CL.kidney * C.artery) / V.kidney)
    
    list(c(dVein, dArtery, dLiver, dLung, dPancreas, dS.intestine, dOther, dKidney))
  })
}
 
Parameters <- c(
  Q.total = sum(Q.liver, Q.lung, Q.pancreas, Q.intestine, Q.other, Q.kidney, na.rm = TRUE),
  Q.liver = 99000,
  Q.lung = 313980,
  Q.pancreas = 7980,
  Q.intestine = 66000,
  Q.other =,
  Q.kidney = 66000,
  V.vein = 3396,
  V.artery = 1698,
  V.liver = 1690,
  V.lung = 1172,
  V.pancreas = 77,
  V.intestine = 1650,
  V.other =,
  V.kidney = 280,
  Kp.liver = 1,
  Kp.lung = 1,
  Kp.pancreas = 1,
  Kp.intestine = 1,
  Kp.other = 1,
  Kp.kidney = 1,
  CL.kidney = 1,
  CL.intestine = 1,
  CLint.liver = 1,
  fu = 0.1)

state <- c(
  C.vein = 5/3396,
  C.artery = 0,
  C.liver = 0,
  C.lung = 0,
  C.pancreas = 0,
  C.intestine = 0,
  C.other = 0,
  C.kidney = 0
)

time = seq(0,24,0.001)

out <- ode(y = state, times = time, func = PBPK.model, params = Parameters)

head(out)