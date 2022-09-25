#rm(list=ls())

library(ggplot2)
library(vioplot)

# читання csv файла
imdb <- read.csv("C:/Users/sophi/OneDrive/Documents/LPNU/Візуалізація даних/lab2/imdb.csv", header = TRUE)

# відображення даних в консолі, для валідації даних
head(imdb)

# описова статистика поокремо
min(imdb$Rate) # мінімальне значення
quantile(imdb$Rate, 0.25) # перший (нижній) квартиль
mean(imdb$Rate) # середнє значення
median(imdb$Rate) #медіана
quantile(imdb$Rate, 0.75) # третій (верхній) квартиль
max(imdb$Rate) # максимальне значення
# описова статистика підсумовуюча
summary(imdb$Rate) # підсумок
summary(imdb)

# графік залежності рейтингу (Rate) від тривалості (Duration)
plot(imdb$Duration, imdb$Rate,
     col="darkslateblue", #колір графіка
     main="Rate affected by Duration (simple plot)", #надпис згори графіка
     xlab="Duration", #вісь абсцис
     ylab="Rate",#вісь ординат
     pch=18)
# відрізок [0;200] для тривалості
plot(imdb$Duration, imdb$Rate,xlim=c(0,200),
     col="darkslateblue", #колір графіка
     main="Rate affected by Duration (simple plot [0;200])", #надпис згори графіка
     xlab="Duration", #вісь абсцис
     ylab="Rate",#вісь ординат
     pch=18)

# точковий графік 
scatterplot <- ggplot(data=imdb) + geom_point(aes(x=Duration, y=Rate, 
                                   size=Date,color = Type), alpha=0.7)
scatterplot + ggtitle("Rate affected by Duration (scatter plot)")

scatterplot <- ggplot(data=imdb) + geom_point(aes(x=Date, y=Rate, 
                                                  size=Duration,color = Type), 
                                              alpha=0.7)
scatterplot + ggtitle("Rate affected by Date (scatter plot)")
                                        
# лінійна діаграма
lineplot <- ggplot(data=imdb, aes(x=Date, y =Rate)) + 
  geom_line(color="darkslateblue", lwd=0.8) +
  geom_point(color="darkslateblue")
lineplot + ggtitle("Rate affected by Date (line plot)")

# діаграма з областями 
plot(density(imdb$Rate), main = "Density X Rate") # графік щільності
ggplot(data=imdb, aes(x=Rate))+
  geom_density(fill="#bdb8df")+
  ggtitle("Rate Density")

### boxplot
# базова функція boxplot
boxplot(imdb$Rate, main="Rate Boxplot Basic", xlab="Rate",
        col="darkslateblue", border="white", horizontal=TRUE, notch=TRUE)
# за допомогою ggplot
ggplot(data=imdb, aes(y=Rate)) + geom_boxplot() +
  ggtitle('Boxplot змінної Rate')

### скрипкова діаграма
# за допомогою пакету vioplot
vioplot(imdb$Rate, main="Violin Plot Rate", col="darkslateblue")
# за допомогою ggplot
ggplot(data=imdb, aes(x=Duration, y=Rate)) +
  geom_violin(fill="darkslateblue") +
  geom_boxplot(width=0.5, alpha=0.4) +
  labs(x = "", y = "") + ggtitle("Violin Plot Rate X Duration")

### гістограма
# базова функція
hist(imdb$Rate, freq=FALSE, main="Histogram Rate X Density Basic")
# ggplot2
ggplot(data=imdb, aes(x = Rate)) + geom_histogram(fill="#bdb8df",
                                                  color="darkslateblue",
                                                  alpha=0.7,
                                                  binwidth=0.3) +
  ggtitle("Histogram Rate X Density ggplot2")

# діаграма щільності + нормальний розподіл
ggplot(data=imdb, aes(x=Rate)) +
  geom_density(lwd = 1.2, fill='#bdb8df', alpha=0.7) +
  stat_function(fun = dnorm, args=list(mean=mean(imdb$Rate),
                                       sd = sd(imdb$Rate)), 
                linetype="dashed", lwd = 1, colour="red") +
  ggtitle("Normal Distribution + Density X Rate")

# діаграма щільності + гістограма
ggplot(data=imdb, aes(x=Rate)) +
  geom_density(lwd = 1.2, fill='#bdb8df', alpha=0.7) +
  geom_histogram(
    fill="#bdb8df",
    color="darkslateblue",
    alpha=0.7,
    binwidth=0.3) +
  ggtitle("Density + Histogram")