PBPK <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {

## Non-eliminating organs
# Generic

dC.Adipose <- (organism["Adipose",]$Q / organism["Adipose",]$V) * (C.Artery - (C.Muscle * drug$BP) / (drug$fu * organism["Adipose",]$Kpu))

dC.Bone <- (organism["Bone",]$Q / organism["Bone",]$V) * (C.Artery - (C.Bone * drug$BP) / (drug$fu * organism["Bone",]$Kpu))

dC.Brain <- (organism["Brain",]$Q / organism["Brain",]$V) * (C.Artery - (C.Brain * drug$BP) / (drug$fu * organism["Brain",]$Kpu))

dC.Heart <- (organism["Heart",]$Q / organism["Heart",]$V) * (C.Artery - (C.Heart * drug$BP) / (drug$fu * organism["Heart",]$Kpu))

dC.Muscle <- (organism["Muscle",]$Q / organism["Muscle",]$V) * (C.Artery - (C.Muscle * drug$BP) / (drug$fu * organism["Muscle",]$Kpu))

dC.Skin <- (organism["Skin",]$Q / organism["Skin",]$V) * (C.Artery - (C.Skin * drug$BP) / (drug$fu * organism["Skin",]$Kpu))

dC.Spleen <- (organism["Spleen",]$Q / organism["Spleen",]$V) * (C.Artery - (C.Spleen * drug$BP) / (drug$fu * organism["Spleen",]$Kpu))

dC.Pancreas <- (organism["Pancreas",]$Q / organism["Pancreas",]$V) * (C.Artery - (C.Pancreas * drug$BP) / (drug$fu * organism["Pancreas",]$Kpu))

dC.Thymus <- (organism["Thymus",]$Q / organism["Thymus",]$V) * (C.Artery - (C.Thymus * drug$BP) / (drug$fu * organism["Thymus",]$Kpu))

# Lungs

dC.Lungs <- (organism["Lungs",]$Q / organism["Lungs",]$V) * (C.Vein - (C.Lungs * drug$BP)/(drug$fu * organism["Lungs",]$Kpu))

# Stomach

dC.Stomach <- (1/organism["Stomach",]$V) * (organism["Stomach",]$Q * (C.Artery - (C.Stomach*drug$BP)/(drug$fu*organism["Stomach",]$Kpu))) ##Gastic absorption needs to be included for the oral model

# Gut

dC.Gut <- (1/organism["Gut",]$V) * (organism["Gut",]$Q * (C.Artery - (C.Gut*drug$BP)/(drug$fu*organism["Gut",]$Kpu))) ##Intestinal absorption needs to be included for the oral model

# Kidney

dC.Kidney <- (1/organism["Kidney",]$V) * (organism["Kidney",]$Q * (C.Artery - (C.Kidney*drug$BP)/(drug$fu*organism["Kidney",]$Kpu))) ##- (C.Kidney * ke.renal)/organsim["Kidney",]$Kpu

# Liver

dC.Liver <- (1/organism["Liver",]$V) * (
            organism["Hepatic artery",]$Q * C.Artery +
            sum((organism["Gut",]$Q * C.Gut * drug$BP) / (drug$fu * organism["Gut",]$Kpu),
                (organism["Pancreas",]$Q * C.Pancreas * drug$BP) / (drug$fu * organism["Pancreas",]$Kpu),
                (organism["Spleen",]$Q * C.Spleen * drug$BP) / (drug$fu * organism["Spleen",]$Kpu),
                (organism["Stomach",]$Q * C.Stomach * drug$BP) / (drug$fu * organism["Stomach",]$Kpu)) -
              (organism["Liver",]$Q * C.Liver * drug$BP) / (drug$fu * organism["Liver",]$Kpu)) ##-
              ##(C.Liver * CL.int) / organism["Liver",]$Kpu)

## Blood compartments
# Artery

dC.Artery <- (1/organism["Artery",]$V) * (organism["Lungs",]$Q * ((C.Lungs * drug$BP) / organism["Lungs",]$Kpu) - C.Artery) ##+ AIR) ##AIR is the arterial infustion rate

# Vein

dC.Vein <- (1 / organism["Vein",]$V) * 
            (sum((organism["Adipose",]$Q * C.Adipose * drug$BP) / (drug$fu * organism["Adipose",]$Kpu),
                (organism["Bone",]$Q * C.Bone * drug$BP) / (drug$fu * organism["Bone",]$Kpu),
                (organism["Brain",]$Q * C.Brain * drug$BP) / (drug$fu * organism["Brain",]$Kpu),
                (organism["Heart",]$Q * C.Heart * drug$BP) / (drug$fu * organism["Heart",]$Kpu),
                (organism["Kidney",]$Q * C.Kidney * drug$BP) / (drug$fu * organism["Kidney",]$Kpu),
                (organism["Liver",]$Q * C.Liver * drug$BP) / (drug$fu * organism["Liver",]$Kpu),
                (organism["Muscle",]$Q * C.Muscle * drug$BP) / (drug$fu * organism["Muscle",]$Kpu),
                (organism["Skin",]$Q * C.Skin * drug$BP) / (drug$fu * organism["Skin",]$Kpu),
                (organism["Thymus",]$Q * C.Thymus * drug$BP) / (drug$fu * organism["THymus",]$Kpu)) -
            organism["Lungs",]$Q * C.Vein) ##+ VIR) ##VIR is the venous infusion rate.

# return rate of change
list(c(dC.Vein, dC.Artery, dC.Liver, dC.Kidney, dC.Gut, dC.Stomach, dC.Lungs, dC.Thymus, dC.Pancreas, dC.Spleen, dC.Skin,
       dC.Muscle, dC.Heart, dC.Brain, dC.Bone, dC.Adipose))

  })
}