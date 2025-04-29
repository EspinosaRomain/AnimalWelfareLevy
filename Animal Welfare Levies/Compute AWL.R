#Prepare working environment
rm(list = ls())
set.seed(1234)
options(scipen=999)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#Import files
source("DataOnAnimals.R")
source("FunctionsAWL.R")

##### Main results #####

#For W0=10 (the minimum is then delta=-1)
compute_allTaxesPerKg(W0_funct=10,
                 delta_funct=-1,
                 phi_list_funct=list(chicken=animalsData$chicken$neurons/24526423164,
                                     pork=animalsData$pork$neurons/24526423164,
                                     dairyHerd=animalsData$dairyHerd$neurons/24526423164,
                                     beefHerd=animalsData$beefHerd$neurons/24526423164),
                 m_funct=402,
                 SWF_funct="Total")

#For W0=7 (the minimum is then delta=(7-20)/7)
compute_allTaxesPerKg(W0_funct=7,
                      delta_funct=(7-20)/7,
                      phi_list_funct=list(chicken=animalsData$chicken$neurons/24526423164,
                                          pork=animalsData$pork$neurons/24526423164,
                                          dairyHerd=animalsData$dairyHerd$neurons/24526423164,
                                          beefHerd=animalsData$beefHerd$neurons/24526423164),
                      m_funct=402,
                      SWF_funct="Total")


#Taxation for chicken across production systems
chickenLevyTable=matrix(data=NA,ncol=2,nrow=4)
chickenList=c("chicken","certifiedChicken","labelRougeChicken","organicChicken")
chickenLevyTable[,1]=sapply(1:4, function(i){ 
  compute_taxPerKg(W0_funct=7,
                   delta_funct=(7-20)/7,
                   phi_list_funct=list(chicken=animalsData$chicken$neurons/24526423164,
                                       certifiedChicken=animalsData$chicken$neurons/24526423164,
                                       labelRougeChicken=animalsData$chicken$neurons/24526423164,
                                       organicChicken=animalsData$chicken$neurons/24526423164),
                   m_funct=402,
                   SWF_funct="Total",
                   animal_funct=chickenList[i])*animalsData$chicken$weight
})
chickenLevyTable[,2]=sapply(1:4, function(i){ 
  compute_taxPerKg(W0_funct=10,
                 delta_funct=-1,
                 phi_list_funct=list(chicken=animalsData$chicken$neurons/24526423164,
                                     certifiedChicken=animalsData$chicken$neurons/24526423164,
                                     labelRougeChicken=animalsData$chicken$neurons/24526423164,
                                     organicChicken=animalsData$chicken$neurons/24526423164),
                 m_funct=402,
                 SWF_funct="Total",
                 animal_funct=chickenList[i])*animalsData$chicken$weight
})
chickenLevyTable=round(chickenLevyTable,2)
rownames(chickenLevyTable)=chickenList
colnames(chickenLevyTable)=c("W0=7","W0=10")
chickenLevyTable

### MAIN Sensitivity analysis ###

#Baseline Results for W0=10
resBasline=launchSimulation(1)
resBasline

# 1. We make deviations on q only (Panel B)
set.seed(123)
S=20000
resQ_only=launchSimulation(S, sensit_q=TRUE)
t1=sumTable(resQ_only,resBasline)
t1

# 2. We make deviations on phi only (Panel C)
set.seed(123)
S=20000
resPhi_only=launchSimulation(S, sensit_phi=TRUE)
t2=sumTable(resPhi_only,resBasline)
t2

# 3. We make deviations on m only (Panel D)
set.seed(123)
S=20000
resM_only=launchSimulation(S, sensit_m=TRUE)
t3=sumTable(resM_only,resBasline)
t3

# 4. We make deviations on all three dimensions (Panel A)
set.seed(123)
S=20000
resAll=launchSimulation(S, sensit_q=TRUE, sensit_phi=TRUE, sensit_m=TRUE)
t4=sumTable(resAll,resBasline)
t4


### Sensitivity analysis with respect to social welfare functions (Appendix OA6) ###

#Baseline Results for W0=10
resBasline=launchSimulation(1)
resBasline

# 1. We make deviations implementing critical-level utilitarianism (Panel A)
set.seed(123)
S=20000
resCL=launchSimulation(S, SWF_funct="Critical-level")
t_cl=sumTable(resCL,resBasline)
t_cl

# 2. We make deviations implementing prioritarianism (Panel B)
set.seed(123)
S=20000
resPrioritarianism=launchSimulation(S, SWF_funct="Prioritarian")
t_prior=sumTable(resPrioritarianism,resBasline)
t_prior
