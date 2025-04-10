#advanced ggplot2
library(ggplot2)
library(dplyr)
library(nycflights23)

#this is an idea for next tuesday - but lets start with it here - 
#continuous variables measures, discrete are categories

#sometimes this is really easy
glimpse(flights)

#various numbers make sense as they are simply numbers

#tail num and flight can be more fun as they are utterly random

#origin is much more like a FACTOR

#an important dimenison of what we want to do generally is to create new variables
flights %>% 
  group_by(origin) %>% 
  summarize(mean(dep_delay, na.rm=TRUE))

#what does na.rm mean? Lets try without it?
flights %>% 
  group_by(origin) %>% 
  summarize(mean(dep_delay))

#do you think it was fixing the result? 

#lets calculate a quick MEAN
(1+2+5+"NA")/4

#lets load in some new data...

glimpse(weddings25)

#which are continuous which are discrete?
#what even are these data

weddings25 %>% group_by(State) %>% summarize(mean(Budget))

weddings25 %>% group_by(State) %>% count()

#now lets hit some plots
#one continuous
ggplot(weddings25, aes(Budget))+geom_freqpoly()
ggplot(weddings25, aes(Budget))+geom_density()
ggplot(weddings25, aes(Budget))+geom_histogram()
ggplot(weddings25, aes(Budget))+geom_area(stat="bin")

#dual continuous
ggplot(weddings25, aes(Dress, Budget))+geom_point()
ggplot(weddings25, aes(Dress, Experience))+geom_smooth()

#one discrete one continuous
ggplot(weddings25, aes(State, Budget))+geom_boxplot()+guides(x = guide_axis(angle = 45))

#dual discrete
ggplot(weddings25, aes(Result, ExpGiven))+geom_count()

#continuous bivar
ggplot(weddings25, aes(Budget, Experience))+geom_density2d()

#faceting
ggplot(weddings25, aes(Dress, Venue, colour=Food))+geom_jitter()

ggplot(weddings25, aes(Dress, Venue, colour=Food))+geom_jitter()+facet_grid(~Result)

#lets hit a few quic statistical tests
analysis<-aov(Result ~ Dress + Venue + Food, data=weddings25)

plot(analysis)
summary(analysis)

#there are many things we can control...
ggplot(weddings25, aes(Food, Budget, size=Guests))+geom_jitter()
