#day five discrete and continuous
#for more detailed treatment, see Ch 7 of cultural analytics

#lets start by getting a few key libraries up
library(ggplot2)
library(dplyr)

#now import your weddings data, either way is fine. 

#discrete means it is a set of identities, one of those is called FACTOR
#continuous means values (infinite) with in a range

#in computational art history: what are more useful, shade names OR color data?

#structured, semi-structured, unstructured

#what kind of data is this?
weddings25$Name

#what about this
weddings25$Budget

#and these?
weddings25$ExpGiven

#a fun color scheme


#lets consider this plot
ggplot(weddings25, aes(ExpGiven, ExpRank, colour=Result))+geom_jitter() + scale_color_viridis_c()

#this is too chunky, the category levels are making it hard for us to see the relationships
#dplyr gives us a lot of tools for synthesizing new data

#lets get some raw data here
w25<-weddings25 %>% mutate("others" = C1+C2+C3+C4)
View(w25)

#so lets make that again with a continuous space
ggplot(w25, aes(Experience, others, colour=Result))+geom_jitter() +scale_color_viridis_b()

#it almost feels like we need some new categorical variables

#is lets play with a factor
ggplot(w25, aes(Experience, others, colour=Result, shape=as.factor(Bride)))+geom_jitter() + scale_color_viridis_c()

#so it doesnt look like it is a show ordering function 

#lets try some mathy math
cor.test(w25$Experience, w25$others)
cor.test(w25$ExpGiven, w25$ExpRank)

#do we think the time space of the show is continuous? 
library(lubridate)
#fantastic library for easy date handling, restaurant menu on this soon...

#you tell it what you want, and within that, how the date is formatted
month(mdy(w25$Date))

#BEST PRACTICE
w25b<-w25 %>% mutate("GoodDate"=mdy(Date))

#notice what GoodDate is in w25b? it is a class called DATE
#suddenly we can play with discrete time domains

ggplot(w25b, aes(Experience, Result, colour=as.factor(month(GoodDate))))+
  geom_jitter()+scale_color_brewer("Set 1")

#lets get some data here
w25b %>% 
  group_by(month(GoodDate)) %>% 
  count()


#what if season matters too
w25b %>% 
  group_by(month(GoodDate), Season) %>% 
  count() %>% 
  View()

#or to do that visually

w25b %>% 
  group_by(GD=month(GoodDate), Season) %>% 
  count() %>% 
  ggplot(aes(Season, GD, colour=n))+geom_jitter()+scale_color_viridis_c()

#so one mean way to do this is OLD vs YOUNG brides, lets assume the air dates tell us something
#this looks really scary but I promise it isnt

#store it as w25C, starting with w25b
w25c<-w25b %>% 
  #make a new column called naturalseason, where if the month is Jan or Feb, its called winter
  mutate(naturalseason = if_else(month(GoodDate)<3 & month(GoodDate)>0, 
                                 #now NEST another if_else if false, the NEXT logical test, if it is Nov or Dec, also winter
                                 "winter", if_else(month(GoodDate)>10, "winter", 
                                                   #if it is october or september it is fall
                                                   if_else(month(GoodDate)<11 & month(GoodDate)>8, "fall",
                                                           #if it is august, july, or june its summer
                                                           if_else(month(GoodDate)<9 & month(GoodDate)>5, "summer",
                                                                   #all other months are spring and 
                                                                   #then we close FOUR nested if_else and a mutate, so FIVE BIG PARENS
                                                           "spring")))))    

#based on your new synthetic discrete, you can do summary vars                                                                                                                                                    "spring")))))
w25c %>% 
group_by(naturalseason) %>% 
summarize(mean(Experience), sd(Experience))

  #what big continuous is missing? actual SCORES
w25d<-w25c %>% mutate("total" = Dress+Venue+Food+Experience)
                                                                   
#lets look at our new CONTINOUS result space
 ggplot(w25d, aes(Age, total, colour=ExpGiven))+geom_jitter()+scale_color_distiller(palette = "Purples")
                                                                   
                                                                   
                                                                   