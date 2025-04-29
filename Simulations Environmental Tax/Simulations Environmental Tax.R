#Prepare working environment
rm(list = ls())
set.seed(1234)
options(scipen=999)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#####SET PARAMETERS#####

#Setting parameters

#Set Animal Welfare externalities
extAW_standardChicken=13.58
extAW_certifChicken=33.4/2.5
extAW_labRougeChicken=13.19/2.5
extAW_organicChicken=1.96/2.5
extAW_pork=11.07
extAW_dairy=0.06
extAW_beef=-18.86

#Set original quantities consumed in kg per consumer in France
poultryConsumption=23
pigConsumption=32
beefConsumption=21

#Market shares of poultry of the four types
#66% standard, 8% certified, 16% Label Rouge, 2% bio: Total of 92%. 
#Rescaling for production exclusive to export
#We assume that all poultry are chicken.
shareChicken_Standard=0.66/0.92 #About 71.7%
shareChicken_Certified=0.08/0.92 #About 8.7%
shareChicken_LabelRouge=0.16/0.92 #About 17.4%
shareChicken_Organic=0.02/0.92 #About 2.2%

#Market shares of beef of the two types
shareBeef_beefHerd=0.68
shareBeef_dairyHerd=0.32

#Set original prices in euros/kg
priceChicken=5.8
pricePig=5.98
priceBeef=11.85
vectorPrices=c(priceChicken,pricePig,priceBeef)

#Carbon tax
taxChicken=0
taxPig=0
taxBeef=1.70
vectorTaxes=c(taxChicken,taxPig,taxBeef)

#Uncompensated elasticities
uncompensatedElasticities=matrix(nrow=3,ncol=3,data=NA)
vecProducts=c("Chicken","Pig","Beef")
rownames(uncompensatedElasticities)=vecProducts
colnames(uncompensatedElasticities)=vecProducts
uncompensatedElasticities[1,1]=-1.4517
uncompensatedElasticities[1,2]=0.0493
uncompensatedElasticities[1,3]=0.0510
uncompensatedElasticities[2,1]=0.1649
uncompensatedElasticities[2,2]=-1.1238
uncompensatedElasticities[2,3]=0.1991
uncompensatedElasticities[3,1]=0.0558
uncompensatedElasticities[3,2]=0.0630
uncompensatedElasticities[3,3]=-1.3358

#####COMPUTATIONS BEFORE TAXATION#####

#We compute share of poultry consumption per type of chicken
standardConsumptionPoultry=shareChicken_Standard*poultryConsumption
certifiedConsumptionPoultry=shareChicken_Certified*poultryConsumption
labelRougeConsumptionPoultry=shareChicken_LabelRouge*poultryConsumption
organicConsumptionPoultry=shareChicken_Organic*poultryConsumption

#We compute share of beef consumption per type of beef
beefHerdConsumptionBeef=shareBeef_beefHerd*beefConsumption
dairyHerdConsumptionBeef=shareBeef_dairyHerd*beefConsumption

#Vector of pre-tax consumption
vectorPreTaxConsumption=c(standardConsumptionPoultry,certifiedConsumptionPoultry,labelRougeConsumptionPoultry,organicConsumptionPoultry,
                          pigConsumption, dairyHerdConsumptionBeef,beefHerdConsumptionBeef)
vectorPreTaxConsumption

#Externalities before tax
externality_poultry_carbon=poultryConsumption*0.42
externality_pork_carbon=pigConsumption*0.42
externality_dairyHerd_carbon=dairyHerdConsumptionBeef*0.58
externality_beefHerd_carbon=beefHerdConsumptionBeef*2.05

externality_poultry_nutrientpollution=poultryConsumption*0.21
externality_pork_nutrientpollution=pigConsumption*0.30
externality_dairyHerd_nutrientpollution=dairyHerdConsumptionBeef*0.60
externality_beefHerd_nutrientpollution=beefHerdConsumptionBeef*2.84

externality_poultry_particulatematter=poultryConsumption*0.47
externality_pork_particulatematter=pigConsumption*0.51
externality_dairyHerd_particulatematter=dairyHerdConsumptionBeef*0.75
externality_beefHerd_particulatematter=beefHerdConsumptionBeef*3.78

externality_standardPoultry_animalwelfare=standardConsumptionPoultry*extAW_standardChicken
externality_certifiedPoultry_animalwelfare=certifiedConsumptionPoultry*extAW_certifChicken
externality_labelRougePoultry_animalwelfare=labelRougeConsumptionPoultry*extAW_labRougeChicken
externality_organicPoultry_animalwelfare=organicConsumptionPoultry*extAW_organicChicken
externality_pork_animalwelfare=pigConsumption*extAW_pork
externality_dairyHerd_animalwelfare=dairyHerdConsumptionBeef*extAW_dairy
externality_beefHerd_animalwelfare=beefHerdConsumptionBeef*extAW_beef

totalCarbonExt=externality_poultry_carbon+externality_pork_carbon+externality_dairyHerd_carbon+externality_beefHerd_carbon
totalNutrientPollExt=externality_poultry_nutrientpollution+externality_pork_nutrientpollution+externality_dairyHerd_nutrientpollution+externality_beefHerd_nutrientpollution
totalParticulateMatterExt=externality_poultry_particulatematter+externality_pork_particulatematter+externality_dairyHerd_particulatematter+externality_beefHerd_particulatematter
totalAnimalWelfareExt_Chicken=externality_standardPoultry_animalwelfare+externality_certifiedPoultry_animalwelfare+externality_labelRougePoultry_animalwelfare+externality_organicPoultry_animalwelfare

extVecBeforeTax=c(totalCarbonExt,
                  totalNutrientPollExt,
                  totalParticulateMatterExt,
                  totalAnimalWelfareExt_Chicken,
                  externality_pork_animalwelfare,
                  externality_dairyHerd_animalwelfare,
                  externality_beefHerd_animalwelfare)
extVecBeforeTax

#####COMPUTATIONS AFTER TAXATION#####

#Change in consumption
vectorChangeConsumption=rep(NA,3)
for(k in 1:3){
  vectorChangeConsumption[k]=sum(uncompensatedElasticities[,k]*(vectorTaxes/vectorPrices))
}
round(vectorChangeConsumption*100,1)

#New consumption quantities:
vectorPostTaxConsumption=c(standardConsumptionPoultry*(1+vectorChangeConsumption[1]),
                           certifiedConsumptionPoultry*(1+vectorChangeConsumption[1]),
                           labelRougeConsumptionPoultry*(1+vectorChangeConsumption[1]),
                           organicConsumptionPoultry*(1+vectorChangeConsumption[1]),
                           pigConsumption*(1+vectorChangeConsumption[2]),
                           dairyHerdConsumptionBeef*(1+vectorChangeConsumption[3]),
                           beefHerdConsumptionBeef*(1+vectorChangeConsumption[3]))
round(vectorPostTaxConsumption,2)

#Externalities after tax
externalityAT_poultry_carbon=sum(vectorPostTaxConsumption[1:4])*0.42
externalityAT_pork_carbon=vectorPostTaxConsumption[5]*0.42
externalityAT_dairyHerd_carbon=vectorPostTaxConsumption[6]*0.58
externalityAT_beefHerd_carbon=vectorPostTaxConsumption[7]*2.05

externalityAT_poultry_nutrientpollution=sum(vectorPostTaxConsumption[1:4])*0.21
externalityAT_pork_nutrientpollution=vectorPostTaxConsumption[5]*0.30
externalityAT_dairyHerd_nutrientpollution=vectorPostTaxConsumption[6]*0.60
externalityAT_beefHerd_nutrientpollution=vectorPostTaxConsumption[7]*2.84

externalityAT_poultry_particulatematter=sum(vectorPostTaxConsumption[1:4])*0.47
externalityAT_pork_particulatematter=vectorPostTaxConsumption[5]*0.51
externalityAT_dairyHerd_particulatematter=vectorPostTaxConsumption[6]*0.75
externalityAT_beefHerd_particulatematter=vectorPostTaxConsumption[7]*3.78

externalityAT_standardPoultry_animalwelfare=vectorPostTaxConsumption[1]*extAW_standardChicken
externalityAT_certifiedPoultry_animalwelfare=vectorPostTaxConsumption[2]*extAW_certifChicken
externalityAT_labelRougePoultry_animalwelfare=vectorPostTaxConsumption[3]*extAW_labRougeChicken
externalityAT_organicPoultry_animalwelfare=vectorPostTaxConsumption[4]*extAW_organicChicken
externalityAT_pork_animalwelfare=vectorPostTaxConsumption[5]*extAW_pork
externalityAT_dairyHerd_animalwelfare=vectorPostTaxConsumption[6]*extAW_dairy
externalityAT_beefHerd_animalwelfare=vectorPostTaxConsumption[7]*extAW_beef


totalCarbonExt_AT=externalityAT_poultry_carbon+externalityAT_pork_carbon+externalityAT_dairyHerd_carbon+externalityAT_beefHerd_carbon
totalNutrientPollExt_AT=externalityAT_poultry_nutrientpollution+externalityAT_pork_nutrientpollution+externalityAT_dairyHerd_nutrientpollution+externalityAT_beefHerd_nutrientpollution
totalParticulateMatterExt_AT=externalityAT_poultry_particulatematter+externalityAT_pork_particulatematter+externalityAT_dairyHerd_particulatematter+externalityAT_beefHerd_particulatematter
totalAnimalWelfareExt_Chicken_AT=externalityAT_standardPoultry_animalwelfare+externalityAT_certifiedPoultry_animalwelfare+externalityAT_labelRougePoultry_animalwelfare+externalityAT_organicPoultry_animalwelfare

extVecAfterTax=c(totalCarbonExt_AT,
                 totalNutrientPollExt_AT,
                 totalParticulateMatterExt_AT,
                 totalAnimalWelfareExt_Chicken_AT,
                 externalityAT_pork_animalwelfare,
                 externalityAT_dairyHerd_animalwelfare,
                 externalityAT_beefHerd_animalwelfare)
extVecAfterTax

#Results: Change in externalities
changeInExt=extVecAfterTax-extVecBeforeTax

#Change in GHG externalities:
round(changeInExt[1],2)

#Change in Nutrient Pollution externalities:
round(changeInExt[2],2)

#Change in Particulate Matter externalities:
round(changeInExt[3],2)

#Change in Chicken Welfare externalities:
round(changeInExt[4],2)

#Change in Pig Welfare externalities:
round(changeInExt[5],2)

#Change in Cow Welfare externalities:
round(changeInExt[6]+changeInExt[7],2)
