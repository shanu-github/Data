



library(ROCR)
ROCRpred <- prediction( predict(log_model, train_data,type="response"), train_data$default)
ROCRperf <- performance(ROCRpred, 'tpr','fpr')
plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7))

acc.perf = performance(ROCRpred, measure = "auc")
plot(acc.perf)



# I think this will work with the code you provided
# fyi, in general, more helpful to provide a very minimal reprex, for easier reading

#create an roc object
roc_obj <- roc(testdata$Churn, testdata$prediction)

#review the roc object
roc_obj
plot(roc_obj)

#get the "best" "threshold"
# there are lots of other options for other metrics as well
coords(roc_obj, "best", "threshold")


library(Deducer)
rocplot(log_model)

#ROC Curve

library(pROC)
g <- roc(default ~ predicted_Prob, data = test_data)
plot(g)   


library(plotROC)
rocplot <- ggplot(train_data, aes(m =  predict(log_model, train_data,type="response"),
                                  d = default))+ geom_roc(n.cuts=20,labels=FALSE)
rocplot + style_roc(theme = theme_grey) 