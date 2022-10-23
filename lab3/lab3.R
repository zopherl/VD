# завдання 1
library(leaflet)
#library(dplyr)
# читання файлу
khmelmus <- read.csv("C:/Users/sophi/OneDrive/Documents/LPNU/Візуалізація даних/lab3/khmelnytskyy_region_museum.csv", header = TRUE, sep = ",")
# показ музеїв області
# використання leaflet
khmelnytskyy <- leaflet(khmelmus) %>%
  addProviderTiles(providers$CartoDB.Voyager) %>% # задаємо карту
  setView(26.99340, 49.42139, zoom = 7) %>% # координати орієнтовного центру області для відображення
  addCircles(~Lng, ~Lat, popup = khmelmus$type, label = khmelmus$name, weight = 15, radius = 25, 
             color = "darkslateblue", stroke = TRUE, fillOpacity = 1) %>%
  addLegend("bottomright", colors=c("darkslateblue"), labels=c("Museums"), 
            title="Khmelnytska Oblast")
khmelnytskyy

#2
library(tmap)
library(sf)
library(rnaturalearth)
library(rnaturalearthhires)
world_map <- ne_countries(scale = 50, returnclass = 'sf')
# країни ЄС
austria <- ne_countries(geounit = 'austria', returnclass = "sf")
belgium <- ne_countries(geounit = 'belgium', returnclass = "sf")
bulgaria <- ne_countries(geounit = 'bulgaria', returnclass = "sf")
croatia <- ne_countries(geounit = 'croatia', returnclass = "sf")
cyprus <- ne_countries(geounit = 'cyprus', returnclass = "sf")
czechia <- ne_countries(geounit = 'Czech Republic', returnclass = "sf")
denmark <- ne_countries(geounit = 'denmark', returnclass = "sf")
estonia <- ne_countries(geounit = 'estonia', returnclass = "sf")
finland <- ne_countries(geounit = 'finland', returnclass = "sf")
france <- ne_countries(geounit = 'france', returnclass = "sf")
germany <- ne_countries(geounit = 'germany', returnclass = "sf")
greece <- ne_countries(geounit = 'greece', returnclass = "sf")
hungary <- ne_countries(geounit = 'hungary', returnclass = "sf")
ireland <- ne_countries(geounit = 'ireland', returnclass = "sf")
italy <- ne_countries(geounit = 'italy', returnclass = "sf")
latvia <- ne_countries(geounit = 'latvia', returnclass = "sf")
lithuania <- ne_countries(geounit = 'lithuania', returnclass = "sf")
luxembourg <- ne_countries(geounit = 'luxembourg', returnclass = "sf")
#malta <- ne_countries(geounit = 'Malta', returnclass = "sf")
netherlands <- ne_countries(geounit = 'netherlands', returnclass = "sf")
poland <- ne_countries(geounit = 'poland', returnclass = "sf")
portugal <- ne_countries(geounit = 'portugal', returnclass = "sf")
romania <- ne_countries(geounit = 'romania', returnclass = "sf")
slovakia <- ne_countries(geounit = 'slovakia', returnclass = "sf")
slovenia <- ne_countries(geounit = 'slovenia', returnclass = "sf")
spain <- ne_countries(geounit = 'spain', returnclass = "sf")
sweden <- ne_countries(geounit = 'sweden', returnclass = "sf")

# тренди запиту 'ukraine' в Google

# період 23.01.2022 - 29.01.2022
 trendsbefore <- c(4, 6, 8, 7, 8, 5, 6, 5, 4,
                3, 3, 5, 6, 9, 8, 7, 5, 6,
                 6, 5, 4, 8, 8, 8, 8, 4)
# період 20.02.2022 - 26.02.2022
 trendsfeb <- c(95, 99, 100, 100, 100, 100, 100, 100, 100,
                85, 80, 100, 100, 88, 94, 100, 100, 99,
                 91, 100, 96, 98, 100, 100, 88, 97)

# період 02.10.2022 - 08.10.2022
  trendsnow <- c(12, 16, 10, 24, 8, 23, 15, 18, 23,
                 10, 13, 12, 13, 9, 17, 17, 18, 10,
                  19, 13, 15, 10, 16, 17, 17, 17)
eu = rbind(austria, belgium, bulgaria, croatia, cyprus,
            czechia, denmark, estonia, finland, france, germany, greece, 
            hungary, ireland, italy, latvia, 
lithuania, luxembourg, 
#malta, 
netherlands, poland, portugal, romania, 
slovakia, slovenia, spain, sweden)

eu$trendsbefore <- trendsbefore
eu$trendsfeb <- trendsfeb
eu$trendsnow <- trendsnow

#tmap
tm.plot1 <- tm_shape(eu) +
  tm_fill("trendsbefore", palette="magma") +
  tm_text("name", size = 0.4) +
  tm_borders()
tm.plot1

tm.plot2 <- tm_shape(eu) +
  tm_fill("trendsfeb", palette="magma") +
  tm_text("name", size = 0.4) +
  tm_borders()
tm.plot2

tm.plot3 <- tm_shape(eu) +
  tm_fill("trendsnow", palette="magma") +
  tm_text("name", size = 0.4) +
  tm_borders()
tm.plot3


# ggplot
library(magrittr)
library(dplyr)
library(ggplot2)
world_map <- ne_countries(scale = 50, returnclass = 'sf')

# % ВВП на військові витрати
gdp <- c(0.9, 1.2, 2.6, 2.39, 3.8,
                1.46, 1.5, 2, 2, 2.6, 1.5, 4.3, 
                1.75, 0.9, 1.8, 1.2, 1.2, 0.9, 
                1.6, 1.71, 2.3, 1.9, 
                1.87, 1.7, 1.2, 1.5)

eu$gdp <- gdp

#ggplot
eumap <- ggplot(eu) + theme_bw() +
  geom_sf(aes(fill = gdp), color = "black") +
  scale_fill_distiller(palette = "PuBu")
eumap

# rayshader
library(rayshader)
eumapray <- ggplot(eu) + theme_bw() +
  geom_sf(aes(fill = gdp), color = "grey") +
  scale_fill_distiller(palette = "PuBu")
plot_gg(eu.map2, multicore = T, scale=250, windowsize = c(700,700))
eumapray