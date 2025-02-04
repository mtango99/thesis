#Sample code for random forests and GLM analysis
#Thanks to Prof. Dave Allen for code
#Maddie Tango


install.packages("randomForest")
install.packages("tidyverse")
install.packages("car")
install.packages("SpatialML")
install.packages("MuMIn")

require(randomForest)
require(tidyverse)
require(car)
require(SpatialML)
require(MuMIn)

bat_data <- read.csv(file.choose())

# select just the predictor variables (columns 2-54) and response variable for the Hoary Bat
hoary_for_rf <- bat_data[,c(2:54,55)]
colnames(hoary_for_rf)

# run the RF!
hoary_rf <- randomForest(Hoary.Bat ~ ., data = hoary_for_rf)

# pred versus observed -- haha, not very good
plot(hoary_for_rf$Hoary.Bat, hoary_rf$predicted, xlim = c(0,20), ylim=c(0,20), xlab = 'Observed', ylab = 'Predicted')
abline(0,1)

# most important predictor variables
varImpPlot(hoary_rf)

# partial dependence plot for one of the predictors
partialPlot(hoary_rf, pred.data = hoary_for_rf, x.var = 'Linear.density.flowlines_2o5.km')

#transform particular variables using log (???? ??? (min(????) ??? 1))(Table 9 in Peters et al. 2020), for example: 
##ex for Mean Patch Area - Wetlands @ 25 km spatial scale
bat_data_transformed<- bat_data %>% mutate(neighbor_transformed = log(Nearest.neighbor.turbine-min(Nearest.neighbor.turbine)-1))


#put top variables into GLM
glm_model <- glm(Hoary.Bat ~ Linear.density.roads_5.km + Min.dist.land.cover.15_25.km + Point.density_2o5.km, data = hoary_for_rf) 
summary(glm_model)

#calculate odds ratio and confidence interval

glm_model %>% coef() %>% exp() #odds ratio
glm_model %>%  confint() %>% exp() #confidence interval

#try multiple other glm models and compare using AICc to decide which is best

glm_model1 <- glm(Hoary.Bat ~ Linear.density.roads_5.km + Point.density_local + X..area.14_25.km, data = hoary_for_rf)
glm_model2 <- glm(Hoary.Bat ~ Linear.density.roads_5.km + Point.density_local, data = hoary_for_rf)

AICc(glm_model)
AICc(glm_model1)
AICc(glm_model2)

