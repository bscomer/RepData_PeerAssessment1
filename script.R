unzip("./repdata-data-activity.zip")
activity<-read.csv("./activity.csv")
library(plyr)
step_sum<-ddply(activity,~date, summarize, sum=sum(steps, na.rm=FALSE))
step_sum_by_interval<-ddply(activity,~interval, summarize, mean=mean(steps,na.rm=TRUE))
hist(step_sum$sum, breaks=20, col="red", main= "Distribution of Total Number of Steps",
     xlab="Total Number of Steps in a Day",
     ylab="Frequency in Days")
mean_steps<-mean(step_sum[,2], na.rm=FALSE)
step_sum[,2]

mean_median_activity<-ddply(activity, ~date, summarize, mean=mean(steps), median=median(steps))

mean_steps<-mean(step_sum[,2], na.rm=TRUE)
median_steps<-median(step_sum[,2], na.rm=TRUE)
plot(step_sum_by_interval$interval, step_sum_by_interval$mean, type="l",
     xlab="5 minute interval", ylab="Mean Number of Steps")
max(step_sum_by_interval$mean)
max_interval<-which.max(step_sum_by_interval$mean)
print(step_sum_by_interval$interval[max_interval])

sum(length(which(is.na(activity$steps))))
NAreplace_activity<-activity
for (i in 1:nrow(NAreplace_activity)) {
  if (is.na(NAreplace_activity$steps[i])) {
    NAreplace_activity$steps[i] <- step_sum_by_interval[which(NAreplace_activity$interval[i] == step_sum_by_interval$interval), ]$mean
  }
}
hist(step_sum$sum, breaks=20, col="red", main= "Distribution of Total Number of Steps",
     xlab="Total Number of Steps in a Day",
     ylab="Frequency in Days")
NAreplace_activity
mean_median_NAreplace<-ddply(NAreplace_activity, ~date, summarize, mean=mean(steps), median=median(steps))
