#Random Model W0:
#Select one of the two samples of the online survey: either W0 when welfare becomes negative OR when life becomes not worth living
randomModelW0=function(){
  sample(c("Negative Welfare","Life Not Worth Living"), 
         prob = c(0.5,0.5),
         size = 1)
}

#Random W0: Randomly select a W0
randomW0=function(modelW0_funct){
  #Matrix of the two distributions:
  matW0_funct=matrix(byrow=TRUE,nrow=20,ncol=2,data=c(0.111, 0.044, 0.030, 0.011, 0.050, 0.049, 0.095, 0.055, 0.156, 0.087, 0.055, 0.011, 0.035, 0.011, 0.131, 0.066, 0.015, 0.005, 0.181, 0.257, 0.030, 0.033, 0.060, 0.077, 0.005, 0.011, 0.005, 0.011, 0.010, 0.109, 0.000, 0.038, 0.000, 0.000, 0.000, 0.022, 0.000, 0.005, 0.030, 0.098))
  columnToSelect_funct=ifelse(modelW0_funct=="Negative Welfare",1,2)
  valuesW0_funct=1:20
  sample(valuesW0_funct, 
         prob = matW0_funct[,columnToSelect_funct],
         size = 1)
}

#Random UP: Randomly select a value for psi and return the associated utility potential phi
randomUP=function(){
  psi_funct=runif(1,min=0.9,max=1)
  UPlist=list(
    chicken=(animalsData$chicken$neurons/24526423164)^psi_funct, 
    pork=(animalsData$pork$neurons/24526423164)^psi_funct, 
    dairyHerd=(animalsData$dairyHerd$neurons/24526423164)^psi_funct,
    beefHerd=(animalsData$beefHerd$neurons/24526423164)^psi_funct)
  return(UPlist)
}

#Random SWF: Randomly select one of the three social welfare functions
randomSWF=function(){
  sample(c("Total","Critical-level","Prioritarian"), 
         prob = c(1/3,1/3,1/3),
         size = 1)
}

#Random Human Utility
nonrandomHU=function(){
  womenLifeExpectancy=85.7
  menLifeExpectancy=80.0
  womenUtilityVector=c(1,0.967,0.904,0.898,0.762,0.796,0.852,0.737)
  menUtilityVector=c(1,0.915,0.882,0.825,0.837,0.804,0.71,0.665)
  lifePeriodDurations=c(17,7,rep(10,5))
  women_lifePeriodDurations=c(lifePeriodDurations,womenLifeExpectancy-sum(lifePeriodDurations))
  men_lifePeriodDurations=c(lifePeriodDurations,menLifeExpectancy-sum(lifePeriodDurations))
  womenLTUtility=women_lifePeriodDurations%*%womenUtilityVector
  menLTUtility=men_lifePeriodDurations%*%menUtilityVector
  #Born alive in 2023:
  #Number of males : 327 311	 
  #Number of females : 312 222
  shareWomen=312222/(312222+327311)
  averageLTutility=womenLTUtility*shareWomen+(1-shareWomen)*menLTUtility
}


#Random Pi: Generate random draw for pi
randomPi=function(){
  runif(1,min=1.5,max=2.5)
}

#Random Mu: Generate random draw for mu (share of lifetime expectancy to use as critical level)
randomMu=function(){
  runif(1,min=0.1,max=0.2)
}

#Random m: Generate random draw for m (monetary value of a daily QALY)
randomM=function(){
  matrix_funct=matrix(data=NA,nrow=8,ncol=5)
  colnames(matrix_funct)=c("BaseCase","Scenario1","Scenario2","Scenario3","Scenario4")
  rownames(matrix_funct)=c("Weighted - 2.5%","Minus10 - 2.5%","Plus10 - 2.5%", "Alternate VSL value - 2.5%", "Weighted - 4.5%","Minus10 - 4.5%","Plus10 - 4.5%", "Alternate VSL value - 4.5%")
  matrix_funct[,1]=c(147093,163437,135093,304373,201398,223776,185312,416743)
  matrix_funct[,2]=c(142218,158020,130279,294284,195960,217703,179856,405490)
  matrix_funct[,3]=c(147840,164267,135093,305918,202672,225191,185392,419379)
  matrix_funct[,4]=c(144215,160239,131104,298416,199417,221575,181289,412645)
  matrix_funct[,5]=c(138214,153571,127855,285999,189603,210670,175848,392336)
  weights_funct=runif(nrow(matrix_funct)*ncol(matrix_funct),min=0,max=1)
  weights_funct=weights_funct/sum(weights_funct)
  return(sum(weights_funct*matrix_funct))
}

#Compute beta
#I create a function of relative weight to determine beta with ratio of marginal utilities for humans to calibrate the prioritarianism function
compute_beta=function(X1_funct,X2_funct,pi_funct){
  #X1: young year
  #X2: old year
  #R: ratio
  #I want the marginal benefit of 1 extra year at X1 to be R times larger 
  #than the benefit of a marginal benefit of 1 year at age X2
  return(log(pi_funct)/(X2_funct-X1_funct))
}

#Random delta: Generate random delta, the minimum of the welfare function
randomDelta=function(){
  runif(1,min=-3,max=-1)
}

#Joint distribution: Generate a joint draw for delta and W0 that are consistent with the constraints imposed in the sensitivity analysis
joint_W0_delta=function(modelW0_funct){
  bool_funct=TRUE
  while(bool_funct){
    W0_funct=randomW0(modelW0_funct)
    delta_funct=randomDelta()
    if(is.na(q_deriv_funct(W0_funct = W0_funct,delta_funct=delta_funct, vp_funct=20))==FALSE){
      if(q_deriv_funct(W0_funct = W0_funct,delta_funct=delta_funct, vp_funct=20)<=0){
        bool_funct=FALSE
      }
    }
  }
  return(list(W0=W0_funct, delta=delta_funct))
}

#Return q(t): the instantaneous utility at time t
compute_q=function(W0_funct,delta_funct,vp_funct){
  #W0_funct: welfare threshold
  #delta_funct: minimum of the welfare function
  #vp_funct: number of violation points
  a_funct=(delta_funct+20/W0_funct-1)/(400-20*W0_funct)
  b_funct=-1/W0_funct-a_funct*W0_funct
  c_funt=1
  return(a_funct*vp_funct^2+b_funct*vp_funct+c_funt)
}

#Return q'(t): the derivative to the utility at time t
q_deriv_funct=function(W0_funct,delta_funct,vp_funct){
  #W0_funct: welfare threshold
  #delta_funct: minimum of the welfare function
  #vp_funct: number of violation points
  a_funct=(delta_funct+20/W0_funct-1)/(400-20*W0_funct)
  b_funct=-1/W0_funct-a_funct*W0_funct
  c_funt=1
  return(2*a_funct*vp_funct+b_funct)
}

#Return integral of q(t): compute the lifetime welfare of an animal
compute_integral_q=function(W0_funct,delta_funct,t_vec_funct,vp_vec_funct){
  #W0_funct: welfare threshold
  #delta_funct: minimum of the welfare function
  #t_vec_funct: vector of days in each welfare state
  #vp_vec_funct: vector of violation points in each welfare state
  t_vec_funct%*%(compute_q(W0_funct,delta_funct,vp_vec_funct))
}

#Compute v: compute the utility-potential-weighted lifetime welfare of an animal  
compute_v=function(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct){
  #W0_funct: welfare threshold
  #delta_funct: minimum of the welfare function
  #t_vec_funct: vector of days in each welfare state
  #vp_vec_funct: vector of violation points in each welfare state
  #phi_funct: utility potential of the animal
  return(phi_funct*compute_integral_q(W0_funct,delta_funct,t_vec_funct,vp_vec_funct))
}

#Define function for prioritarianism
prioritarian_trans=function(x_funct,beta_funct){
  #x_funct: welfare level
  #beta_funct: calibration parameter
  return(1-exp(-beta_funct*x_funct))
}

#Define the derivative for the prioritarian concave transformation
deriv_prioritarian_trans=function(x_funct,beta_funct){
  #x_funct: welfare level
  #beta_funct: calibration parameter
  return(beta_funct*exp(-beta_funct*x_funct))
}

#Compute contribution to social welfare
compute_SWcontribution=function(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct,m_funct,SWF_funct, cl_funct=NULL, beta_funct=NULL, human_utility_funct=NULL){
  #W0_funct: welfare threshold
  #delta_funct: minimum of the welfare function
  #t_vec_funct: vector of days in each welfare state
  #vp_vec_funct: vector of violation points in each welfare state
  #phi_funct: utility potential of the animal
  #m_funct: monetary value of one daily QALY for humans
  #SWF_funct: selected social welfare function
  #cl_funct: critical level (for CLU only)
  #beta_funct: calibration parameter for the prioritarian function (for Prioritarianism only)
  #human_utility_funct: average utility of a human  (for Prioritarianism only)
  if(is.null(cl_funct) & SWF_funct=="Critical-level") stop("You need to define a critical level.")
  if(is.null(cl_funct) & SWF_funct=="CL-Prioritarian") stop("You need to define a critical level.")
  if(SWF_funct=="Total") res_funct=m_funct*compute_v(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct)
  #Note: We assume instantaneous critical-level: I define a critical-level for each day of the animal's life
  if(SWF_funct=="Critical-level") res_funct=m_funct*(compute_v(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct)-cl_funct*365.25)
  if(SWF_funct=="Prioritarian") res_funct=(m_funct*365.25)*prioritarian_trans(compute_v(W0_funct,delta_funct,t_vec_funct/365.25,vp_vec_funct, phi_funct),beta_funct)/deriv_prioritarian_trans(human_utility_funct,beta_funct)
  if(SWF_funct=="CL-Prioritarian") res_funct=(m_funct*365.25)*(prioritarian_trans(compute_v(W0_funct,delta_funct,t_vec_funct/365.25,vp_vec_funct, phi_funct),beta_funct)-prioritarian_trans(cl_funct,beta_funct))/deriv_prioritarian_trans(human_utility_funct,beta_funct)
  return(res_funct)
}

#Compute tax per kg
compute_taxPerKg=function(W0_funct,delta_funct,phi_list_funct,m_funct,SWF_funct, mu_funct=NULL, beta_funct=NULL, human_utility_funct=NULL, animal_funct){
  #W0_funct: welfare threshold
  #delta_funct: minimum of the welfare function
  #t_vec_funct: vector of days in each welfare state
  #vp_vec_funct: vector of violation points in each welfare state
  #phi_funct: utility potential of the animal
  #m_funct: monetary value of one daily QALY for humans
  #SWF_funct: selected social welfare function
  #mu_funct: share of total life expectancy (for CLU only)
  #beta_funct: calibration parameter for the prioritarian function (for Prioritarianism only)
  #human_utility_funct: average utility of a human  (for Prioritarianism only)
  #animal_funct: characteristics on the animal's species
  if(is.null(mu_funct) & SWF_funct=="Critical-level") stop("You need to define mu_funct for Critical-level SWF.")
  if(is.null(mu_funct) & SWF_funct=="CL-Prioritarian") stop("You need to define a critical level for CL-prioritarianism.")
  if(is.null(beta_funct) & SWF_funct=="Prioritarian") stop("You need to define beta_funct for prioritanianism.")
  if(is.null(beta_funct) & SWF_funct=="CL-Prioritarian") stop("You need to define beta_funct for CL-prioritanianism.")
  if(is.null(human_utility_funct) & SWF_funct=="Prioritarian") stop("You need to define human utility for prioritanianism.")
  if(is.null(human_utility_funct) & SWF_funct=="CL-Prioritarian") stop("You need to define human utility for CL-prioritanianism.")
  weight_funct=animalsData[[animal_funct]]$weight
  t_vec_funct=animalsData[[animal_funct]]$time
  vp_vec_funct=animalsData[[animal_funct]]$violationPoints
  phi_funct=phi_list_funct[[animal_funct]]
  cl_funct=NULL
  if(SWF_funct=="Critical-level" | SWF_funct=="CL-Prioritarian") cl_funct=animalsData[[animal_funct]]$lifeExpectancy*phi_funct*mu_funct
  if(SWF_funct=="Critical-level"){
    res_funct=compute_SWcontribution(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct,m_funct,SWF_funct,cl_funct)/weight_funct
  }else if(SWF_funct=="Total"){
    res_funct=compute_SWcontribution(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct,m_funct,SWF_funct)/weight_funct
  }else if(SWF_funct=="Prioritarian"){
    res_funct=compute_SWcontribution(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct,m_funct,SWF_funct,beta_funct=beta_funct,human_utility_funct=human_utility_funct)/weight_funct
  }else if(SWF_funct=="CL-Prioritarian"){
    res_funct=compute_SWcontribution(W0_funct,delta_funct,t_vec_funct,vp_vec_funct, phi_funct,m_funct,SWF_funct,cl_funct,beta_funct=beta_funct,human_utility_funct=human_utility_funct)/weight_funct
  }
  return(-res_funct) #Minus to get the tax
}

#Compute all taxes per kg
compute_allTaxesPerKg=function(W0_funct,delta_funct,phi_list_funct,m_funct,SWF_funct, mu_funct=NULL, beta_funct=NULL, human_utility_funct=NULL, animal_funct){
  #W0_funct: welfare threshold
  #delta_funct: minimum of the welfare function
  #t_vec_funct: vector of days in each welfare state
  #vp_vec_funct: vector of violation points in each welfare state
  #phi_funct: utility potential of the animal
  #m_funct: monetary value of one daily QALY for humans
  #SWF_funct: selected social welfare function
  #mu_funct: share of total life expectancy (for CLU only)
  #beta_funct: calibration parameter for the prioritarian function (for Prioritarianism only)
  #human_utility_funct: average utility of a human  (for Prioritarianism only)
  #animal_funct: characteristics on the animal's species
  sapply(c("chicken","pork","dairyHerd","beefHerd"), function(i){
    compute_taxPerKg(W0_funct,delta_funct,phi_list_funct,m_funct,SWF_funct, mu_funct=mu_funct, beta_funct=beta_funct, human_utility_funct=human_utility_funct, i)
  })
}

#Simulation function
#According to the sensitivity analysis chosen, replace some values with random draws
randomDraw=function(sensit_q=FALSE,sensit_phi=FALSE,sensit_m=FALSE,SWF_funct="Total"){
  #sensit_q: BOOLEAN indicating whether we do sensitivity of welfare function q
  #sensit_phi: BOOLEAN indicating whether we do sensitivity of utility potential phi
  #sensit_m: BOOLEAN indicating whether we do sensitivity of monetary value of one day of QALY
  #SWF_funct: indicating which social welfare function to consider
  if(sensit_q==TRUE){
    modelW0_funct=randomModelW0()
    jointDraw_funct=joint_W0_delta(modelW0_funct)
    W0_funct=jointDraw_funct$W0
    delta_funct=jointDraw_funct$delta
  }else{
    W0_funct=10
    delta_funct=-1
    modelW0_funct="Baseline"
  }
  if(sensit_phi==TRUE){
    UP_funct=randomUP()  
  }else{
    UP_funct=list(chicken=animalsData$chicken$neurons/24526423164,
                  pork=animalsData$pork$neurons/24526423164,
                  dairyHerd=animalsData$dairyHerd$neurons/24526423164,
                  beefHerd=animalsData$beefHerd$neurons/24526423164)
  }
  if(sensit_m==TRUE){
    m_funct=randomM()/365.25
  }else{
    m_funct=402
  }
  if(SWF_funct=="Prioritarian"){
    HU_funct=nonrandomHU()
    Pi_funct=randomPi()
    beta_funct=compute_beta(X1_funct=10, X2_funct=40,pi_funct=Pi_funct)
    mu_funct=NULL
  }
  if(SWF_funct=="Critical-level"){
    HU_funct=NULL
    Pi_funct=NULL
    beta_funct=NULL
    mu_funct=randomMu()
  }
  if(SWF_funct=="Total"){
    HU_funct=NULL
    Pi_funct=NULL
    beta_funct=NULL
    mu_funct=NULL
  }
  if(SWF_funct=="CL-Prioritarian"){
    HU_funct=nonrandomHU()
    Pi_funct=randomPi()
    beta_funct=compute_beta(X1_funct=10, X2_funct=40,pi_funct=Pi_funct)
    mu_funct=randomMu()
  }
  
  #Computation of the levy
  res_funct=compute_allTaxesPerKg(W0_funct=W0_funct,
                     delta_funct=delta_funct,
                     phi_list_funct=UP_funct,
                     m_funct=m_funct,
                     SWF_funct=SWF_funct,
                     animal_funct=i, 
                     mu_funct=mu_funct,
                     beta_funct=beta_funct, 
                     human_utility_funct=HU_funct)
  return(list(SWF=SWF_funct,modelW0=modelW0_funct,W0=W0_funct,delta=delta_funct,UP=UP_funct,HU=HU_funct, Pi=Pi_funct, beta=beta_funct, Mu=mu_funct, tax=res_funct))
}


#Function to launch simulations with given sensitivity options
library(dplyr)
launchSimulation=function(S_funct,sensit_q=FALSE,sensit_phi=FALSE,sensit_m=FALSE,SWF_funct="Total"){
  #sensit_q: BOOLEAN indicating whether we do sensitivity of welfare function q
  #sensit_phi: BOOLEAN indicating whether we do sensitivity of utility potential phi
  #sensit_m: BOOLEAN indicating whether we do sensitivity of monetary value of one day of QALY
  #SWF_funct: indicating which social welfare function to consider
  tmp_data=as.data.frame(t(sapply(1:S_funct, function(i) unlist(randomDraw(sensit_q,sensit_phi,sensit_m,SWF_funct)))))
  suppressWarnings({
    tmp_data2=tmp_data %>% mutate_if(is.character,as.numeric)
  })
  tmp_data2[,1]=tmp_data[,1]
  tmp_data2[,2]=tmp_data[,2]
  tmp_data2$SWL_CL=ifelse(tmp_data2$SWF=="Critical-level",1,0)
  tmp_data2$SWL_PU=ifelse(tmp_data2$SWF=="Prioritarian",1,0)
  tmp_data2$SWL_CLPU=ifelse(tmp_data2$SWF=="CL-Prioritarian",1,0)
  return(tmp_data2)  
}

#Summary Table: Returns the results
sumTable=function(res_funct,baseline_funct){
  listTax_funct=c("tax.chicken","tax.pork","tax.dairyHerd","tax.beefHerd")
  resMat_funct=matrix(data=NA,nrow=4,ncol=8)
  for(i in 1:4){
    resMat_funct[i,1:4]=round(c(quantile(res_funct[[listTax_funct[i]]],c(0.1,0.5,0.9)),baseline_funct[[listTax_funct[i]]]),2)
    resMat_funct[i,5]=round(mean(ifelse(res_funct[[listTax_funct[i]]]>baseline_funct[[listTax_funct[i]]],1,0)),3)
    resMat_funct[i,6]=round(mean(ifelse(res_funct[[listTax_funct[i]]]<baseline_funct[[listTax_funct[i]]],1,0)),3)
    resMat_funct[i,7]=round(mean(ifelse(res_funct[[listTax_funct[i]]]>0,1,0)),3)
    resMat_funct[i,8]=round(mean(ifelse(res_funct[[listTax_funct[i]]]<0,1,0)),3)
  }
  colnames(resMat_funct)=c("1st Decile","Median","9th Decile","Baseline","Share Above Baseline","Share Below baseline","Share Tax","Share Subsidy")
  rownames(resMat_funct)=c("Chicken","Pork","Dairy Herd","Beef Herd")
  return(resMat_funct)
}
