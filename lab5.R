library(ggplot2)
library(dplyr)
library(vcd)
library(hrbrthemes)
library(plotly)
library(forecast)
library(ggTimeSeries)
library(patchwork)
library(scholar)
library(ggraph)
library(circlize)
library(networkD3)
library(viridis)
library(BBmisc)
library(igraph)


coursera <- read.csv("C:/Users/sophi/OneDrive/Documents/LPNU/VD/lab5/multiTimeline (1).csv", header = TRUE, sep = ",")
head(coursera)
df <- coursera

# LINE PLOT
df$Week <- as.Date(df$Week)
lineplot <- df %>%
  ggplot(aes(x=Week, y=coursera...Ukraine.)) +
  geom_area(fill="darkslateblue", alpha=0.5) +
  geom_line(color="darkslateblue") +
  ylab("Categories") 
  theme_ipsum()
# interactive
lineplot <- ggplotly(lineplot)
lineplot

# TREND
df$Week <- as.Date(df$Week)
lineplot <- df %>%
  ggplot(aes(x=Week, y=coursera...Ukraine.)) +
  geom_area(fill="darkslateblue", alpha=0.5) +
  geom_line(color="darkslateblue") +
  ylab("Categories") 
theme_ipsum()
lineplot + stat_smooth(method = "loess", formula = y ~ x, size = 1)

# LAG PLOT
lagplot <- df %>% select(coursera...Ukraine.) %>% mutate(lag1 = lag(coursera...Ukraine., 1)) %>%
  ggplot(aes(y = coursera...Ukraine., x = lag1)) +
  geom_point(shape=19, color="darkslateblue") +
  theme_bw() +
  ggtitle('Lag 1')
lagplot

# AUTOCORRELATION
autocor <- acf(df$coursera...Ukraine., lag.max = 10, plot=F, na.action = na.pass)
autocor.plot <- data.frame(lag = autocor$lag, coef = autocor$acf) %>%
  ggplot(aes(x = lag, y = coef)) +
  geom_segment(aes(xend=lag, yend=0))+
  geom_point(size=5, color="darkslateblue") +
  geom_hline(aes(yintercept=0)) +
  theme_bw() +
  ggtitle('Autocorrelation by Lag')
autocor.plot

# ???????????????? ??????????????????????????
pac <- acf(df$coursera...Ukraine., lag.max = 10, plot=F, na.action = na.pass, type = "partial")
pac.plot <- data.frame(lag = pac$lag, coef = pac$acf) %>%
  ggplot(aes(x = lag, y = coef)) +
  geom_segment(aes(xend=lag, yend=0))+
  geom_point(size=5, color="darkblue") +
  geom_hline(aes(yintercept=0)) +
  theme_bw() +
  ggtitle('(part)Autocorrelation by Lag')
pac.plot

# FORECASTING
df_ts <- ts(df[, 2], start = c(2017, 1), end = c(2022, 10), frequency = 12)

df_ts %>%
  auto.arima() %>%
  forecast(h=24) %>%
  autoplot()


# ????????????????
# ?????????????????????????????????????????????
migration <- read.csv("C:/Users/sophi/OneDrive/Documents/LPNU/VD/lab5/bordercrossing.csv", header = TRUE, sep = ",")
head(migration)
# CHORD
origin <- data.frame(migration$ï..Origin, migration$To, migration$Number.to)
to <- origin[origin$migration.ï..Origin %in% c("Ukraine", "Ukraine", "Ukraine", "Ukraine","Ukraine","Ukraine"), ]
to <- origin[origin$migration.To%in% c("Poland", "Russia", "Moldova", "Romania", "Slovakia", "Hungary"), ]
chordDiagram(to, transparency = 0.5)

# SANKEY
fromnew <- origin[origin$migration.ï..Origin %in% c("Ukraine", "Ukraine", "Ukraine", "Ukraine","Ukraine","Ukraine"), ]
fromnew <- origin[origin$migration.To%in% c("Poland", "Russia", "Moldova", "Romania", "Slovakia", "Hungary"), ]
nodes <- data.frame(name=c(as.character(fromnew$migration.Origin), as.character(fromnew$migration.To)) %>% unique())
fromnew$IDfrom=match(fromnew$migration.ï..Origin, nodes$name)-1 
fromnew$IDto=match(fromnew$migration.ï..Origin, nodes$name)-1
hchart(data_to_sankey(fromnew), "sankey", name = "Migration")

# HEATMAP
normalize(fromnew)
p <- ggplot(fromnew, aes(migration.ï..Origin, migration.To, fill= migration.Number.to)) + 
  geom_tile() +
  scale_fill_viridis(discrete=FALSE) +
  theme_ipsum()

ggplotly(p, tooltip="text")


# scholar
coauthor_network <- get_coauthors('yWHUZwQAAAAJ')
#coauthor_network <- get_coauthors('zPLXbWsAAAAJ')

# dend
ggraph(coauthor_network, layout = 'dendrogram', circular = FALSE) + 
  geom_edge_diagonal() +
  geom_node_point(color="darkslateblue", size=1) +
  geom_node_text(aes(label=name), nudge_x = -0.1) +
  theme_void() +
  coord_flip() +
  scale_y_reverse()

# arc
coauthor_network <- get_coauthors('yWHUZwQAAAAJ')
ggraph(coauthor_network, layout="linear") + 
  geom_edge_arc(edge_colour="black", edge_alpha=0.3, edge_width=0.2) +
  geom_node_point( color="darkslateblue", size=7) +
  geom_node_text(aes(label=name), angle=90, hjust=0, nudge_y = -5.5, size=3.5) +
  theme_void() +
  theme(legend.position="none", plot.margin=unit(rep(2,4), "cm"))
    
# network
graph <- simpleNetwork(coauthor_network)

simpleNetwork(coauthor_network,     
              Source = 1, 
              Target = 2,  
              height = 800,     
              width = 800,
              linkDistance = 100,    
              fontSize = 5,      
              fontFamily = "serif",   
              linkColour = "black",   
              nodeColour = "darkslateblue",
              opacity = 0.9,   
              zoom = T  
)




