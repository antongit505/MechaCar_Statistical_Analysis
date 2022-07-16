#Import libraries needed
library(dplyr)
library(ggplot2)
library(tidyr)
library(psych)


### Deliverable 1: Linear Regression to Predict MPG ###
#Import csv file
mechaCar_df <- read.csv("resources/MechaCar_mpg.csv")
head(mechaCar_df)

#Perform multiple linear regression
lm(mpg~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mechaCar_df)
summary(lm(mpg~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mechaCar_df))


### Deliverable 2: Create Visualizations for the Trip Analysis ###
#Import CSV file
suspension_df<-read.csv("resources/Suspension_Coil.csv",stringsAsFactors = F,header=T)
head(suspension_df)

total_summary<- suspension_df %>% summarize(Mean_PSI=mean(PSI),
                                            Meadian_PSI=median(PSI),
                                            Variance_PSI=var(PSI),
                                            Standard_Deviation_PSI=sd(PSI),
                                            .groups='keep')
#Create a summary grouping by Lot

lot_summary<- suspension_df %>% group_by(Manufacturing_Lot) %>% summarize(Mean_PSI=mean(PSI),
                                                                          Meadian_PSI=median(PSI),
                                                                          Variance_PSI=var(PSI),
                                                                          Standard_Deviation_PSI=sd(PSI),
                                                                          .groups='keep')
#Create a box-plot comparing the Manufacturing lots
plt <- ggplot(suspension_df,aes(x=Manufacturing_Lot,y=PSI))
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1))


### Deliverable 3: T-Tests on Suspension Coils ###

#T-test for the data set to see if PSI is different from the population mean of 1,500 PSI
t.test(suspension_df$PSI,mu=1500)

#T-test for each manufacturing lot
Lot1<- subset(suspension_df,Manufacturing_Lot=="Lot1")
Lot2<- subset(suspension_df,Manufacturing_Lot=="Lot2")
Lot3<- subset(suspension_df,Manufacturing_Lot=="Lot3")

#T-test for Manufacturing Lot1
t.test(Lot1$PSI,mu=1500)
#T-test for Manufacturing Lot2
t.test(Lot2$PSI,mu=1500)
#T-test for Manufacturing Lot3
t.test(Lot3$PSI,mu=1500)
