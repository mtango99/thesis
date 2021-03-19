require(randomForest)

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

#transform particular variables (Table 9 in Peters et al. 2020), for example: 
o	lab1<- lab1 %>%mutate(log_herb = log(herb))

#put top variables into GLM
glm_model <- glm(Hoary.Bat ~ Linear.density.roads_5.km + Min.dist.land.cover.15_25.km + Point.density_2o5.km, data = hoary_for_rf) 
summary(glm_model)

glm_model %>% coef() %>% exp() #odds ratio
glmmodel %>%  confint() %>% exp() #confidence interval

