#Preparing workspace
rm(list = ls())
set.seed(1234)
options(scipen=999)

#Set Working Directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#FUNCTION TO LOAD ELEMENTS#
loadRData <- function(fileName){
  #loads an RData file, and returns it
  load(fileName)
  get(ls()[ls() != "fileName"])
}

#Starting time
starting_time <- proc.time()

#Load survey data
mydata=loadRData("SurveyData_Anonym.RData")

#### Clean data ####

#Drop failed attention checks
mydata$AC1=ifelse(mydata$understandFF==5,1,0)
mydata$AC2=ifelse(mydata$understandRed==4,1,0)
mydata$AC3=ifelse(mydata$DimensionsCheck.Hung.=="Yes" & mydata$DimensionsCheck.Disc.=="Yes" & mydata$DimensionsCheck.Fear.=="Yes" &
                    mydata$DimensionsCheck.Pain.=="Yes" & mydata$DimensionsCheck.Behav.=="Yes",1,0)
mydata$AllChecks=ifelse(mydata$AC1==1 & mydata$AC2==1 & mydata$AC3==1,1,0)
table(mydata$AC1)
table(mydata$AC2)
table(mydata$AC3)
table(mydata$AllChecks)
mydata=mydata[mydata$AllChecks==1 & !is.na(mydata$AllChecks),]

#Generate Treatment dummy
mydata$framing=ifelse(mydata$groupTreatment==1,"Life Not Worth Living","Negative Welfare")
table(mydata$framing)

#Show Demographics
round(mean(as.numeric(mydata$Age),na.rm=TRUE),1)
round(mean(ifelse(mydata$Sex=="Female",1,0),na.rm=TRUE),3)*100
round(mean(ifelse(mydata$Employment.status=="Full-Time" | mydata$Employment.status=="Part-Time",1,0),na.rm=TRUE),3)*100

#Look at clarity of examples
table(mydata$readExample1)
table(mydata$readExample2)

#### MAIN ANALYSIS ####

#Look at the distribution of W0
matOccurences=matrix(data=NA,ncol=3,nrow=21)
matOccurences[,1]=1:21
matOccurences[1,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 1 violation point and above",na.rm=TRUE)
matOccurences[2,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 2 violation points and above",na.rm=TRUE)
matOccurences[3,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 3 violation points and above",na.rm=TRUE)
matOccurences[4,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 4 violation points and above",na.rm=TRUE)
matOccurences[5,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 5 violation points and above",na.rm=TRUE)
matOccurences[6,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 6 violation points and above",na.rm=TRUE)
matOccurences[7,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 7 violation points and above",na.rm=TRUE)
matOccurences[8,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 8 violation points and above",na.rm=TRUE)
matOccurences[9,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 9 violation points and above",na.rm=TRUE)
matOccurences[10,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 10 violation points and above",na.rm=TRUE)
matOccurences[11,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 11 violation points and above",na.rm=TRUE)
matOccurences[12,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 12 violation points and above",na.rm=TRUE)
matOccurences[13,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 13 violation points and above",na.rm=TRUE)
matOccurences[14,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 14 violation points and above",na.rm=TRUE)
matOccurences[15,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 15 violation points and above",na.rm=TRUE)
matOccurences[16,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 16 violation points and above",na.rm=TRUE)
matOccurences[17,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 17 violation points and above",na.rm=TRUE)
matOccurences[18,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 18 violation points and above",na.rm=TRUE)
matOccurences[19,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 19 violation points and above",na.rm=TRUE)
matOccurences[20,2]=sum(mydata$thresholdNW=="Welfare becomes negative at 20 violation points and above",na.rm=TRUE)
matOccurences[21,2]=sum(mydata$thresholdNW=="It is never negative",na.rm=TRUE)

matOccurences[1,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 1 violation point and above",na.rm=TRUE)
matOccurences[2,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 2 violation points and above",na.rm=TRUE)
matOccurences[3,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 3 violation points and above",na.rm=TRUE)
matOccurences[4,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 4 violation points and above",na.rm=TRUE)
matOccurences[5,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 5 violation points and above",na.rm=TRUE)
matOccurences[6,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 6 violation points and above",na.rm=TRUE)
matOccurences[7,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 7 violation points and above",na.rm=TRUE)
matOccurences[8,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 8 violation points and above",na.rm=TRUE)
matOccurences[9,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 9 violation points and above",na.rm=TRUE)
matOccurences[10,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 10 violation points and above",na.rm=TRUE)
matOccurences[11,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 11 violation points and above",na.rm=TRUE)
matOccurences[12,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 12 violation points and above",na.rm=TRUE)
matOccurences[13,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 13 violation points and above",na.rm=TRUE)
matOccurences[14,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 14 violation points and above",na.rm=TRUE)
matOccurences[15,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 15 violation points and above",na.rm=TRUE)
matOccurences[16,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 16 violation points and above",na.rm=TRUE)
matOccurences[17,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 17 violation points and above",na.rm=TRUE)
matOccurences[18,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 18 violation points and above",na.rm=TRUE)
matOccurences[19,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 19 violation points and above",na.rm=TRUE)
matOccurences[20,3]=sum(mydata$thresholdLWL=="Life becomes not worth living at 20 violation points and above",na.rm=TRUE)
matOccurences[21,3]=sum(mydata$thresholdLWL=="Life is never not worth living",na.rm=TRUE)
matOccurences

#Obtaining frequencies
matFrequencies=matOccurences
matFrequencies[,2]=matOccurences[,2]/sum(matOccurences[,2])
matFrequencies[,3]=matOccurences[,3]/sum(matOccurences[,3])
matFrequencies=round(matFrequencies,3)
matFrequencies

#Median
returnMedian=function(vec_freq){
  median_funct=NA
  i_funct=1
  while(i_funct<22 & is.na(median_funct)){
    if(i_funct==1) tmp_funct=vec_freq[1]
    if(i_funct>1) tmp_funct=tmp_funct+vec_freq[i_funct]
    if(tmp_funct>0.5) median_funct=i_funct
    i_funct=i_funct+1
  }
  print(paste0("The median is: ",median_funct))
}

#Median for treatment: welfare becomes negative
returnMedian(matFrequencies[,2])

#Median for treatment: life becomes not worth living
returnMedian(matFrequencies[,3])

#Ending time
ending_time <- proc.time()

#Running time
(ending_time-starting_time)["elapsed"]