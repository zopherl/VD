#1. Встановлення R та RStudio

#2. Перегляд робочої директорії та її зміна
getwd()
setwd("C:/Users/sophi/OneDrive/Documents/LPNU/Візуалізація даних/lab1")
getwd()

#3. Встановлення пакетів
#vcd встановлюємо шляхом вибору зі списку
install.packages()
#перегляд завантажених пакетів
installed.packages()
#paletteer і colourpicker встановлюємо шляхом вказання пакета в коді
install.packages("paletteer")
install.packages("colourpicker")
#перевірка чи присутні в бібліотеці дані пакети
library()

#4. Довідка
help("paletteer") #нема документації
??paletteer 
help("colourpicker") #нема документації
??colourpicker
help.search("colour")
apropos("colour")

#5. Типи та структури даних
#Вектор
vector("integer", 5) #пустий вектор з цілими числами та довжиною 5
v <- c(3, 5, 7) #створення вектора
v <- c("2", 3, 3.5, TRUE) #всі значення зведуться до одного типу - character
#seq(from, to, by, length.out)
1:6 #послідовність чисел
seq(10, 20, by = 1)
a <- c(1, 5, 10)
b <- c(2, 6, 11)
a*b
#Матриці
#matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL)
#byrow = FALSE - по стовпцях, byrow = TRUE - по рядках
#dim(elements) <- c(4, 4)
#спосіб 1
m.way1 <- matrix(c(3,1,12,7,11,8,2,2,5,10,3,5,4,4,6,9), 4, 4, byrow=T)
#спосіб 2
m.way2 <- c(3,1,12,7,11,8,2,2,5,10,3,5,4,4,6,9)
dim(m.way2) <- c(4,4)
#спосіб 3
row.1 <- c(3,1,12,7)
row.2 <- c(11,8,2,2)
rbind(row.1, row.2)
#отримання елементів матриці
m.way1[1]
m.way1[1,]
m.way1[,1]
#Списки
list_data <- list("Red", "Green", c(21,32,11), TRUE, 51.23, 119.1)
print(list_data)
#Фрейми даних
df <- data.frame(x=1:5, y=sin(1:5))
df
#df <- read.csv('combat_losses.csv')
#df

#6. Titanic
install.packages("titanic") #завантаження Titanic
View(Titanic) #перегляд Titanic
help("Titanic")

#7. Математичні операції
(sqrt(2)-1)*sqrt(4+4*sqrt(9-4*sqrt(2))) #математичний вираз 1
(1/(log(18,12)))+(1/(log(18,27))) #математичний вираз 2

#8. iris
#help(package = "datasets")
install.packages("plot")
data("iris")
head(iris)
plot(iris$Sepal.Width, iris$Sepal.Length,
     col="darkslateblue", #колір графіка
     main="iris plot", #надпис згори графіка
     xlab="width", #вісь абсцис
     ylab="length",#вісь ординат
     pch=18) #pch задає символ

#9.
library(ggplot2)
newplot <- ggplot(data = iris, 
                  aes(x = Sepal.Width, y = Sepal.Length)) #відображення на естетику графіка
newplot + geom_point(aes(color=Species, shape=Species)) +
  xlab("width") +  ylab("length") +
  ggtitle("new iris plot")

