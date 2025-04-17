#day six - pivots
#OK so I just gotta know, what do you think of the green ranger?
library(dplyr)
library(tidyr)

#go ahead an import dataset zords
zords

#Someone quick use the Dragon Dagger!

#ok can you make a GGPLOT OF IT? LIKE BY SEASON?

#this will be part of the idea for next TUESDAY
Seasons<-c("Dino", "Thunder", "Ninja","Shogun", "Zeo", "Aquatar", "SuperZeo")
Number<-c(1,2,3,4,5,6,7)
ranger_seasons<-data.frame(Seasons, Number)

#but this isn't easy at all
head(zords)

#that is because it is WIDE data, which is really nice for a human brain to look at
#computers need LONG data

zords %>% 
  #first step - we need to take everything EXCEPT the first column and make it LONGER
  pivot_longer(-Ranger)

#Well that was awesome, but it is missing some things, we need to get it to say the right stuff for name and value
zords %>% 
  pivot_longer(-Ranger, names_to="Seasons", values_to="Zord")

#well that was easy
library(dplyr)
long_rangers<-zords %>% 
  pivot_longer(-Ranger, names_to="Seasons", values_to="Zord") 

inner_join(long_rangers, ranger_seasons, by="Seasons") 

#so now we can plot that nonsense...
library(ggplot2)
inner_join(long_rangers, ranger_seasons) %>% 
  ggplot(aes(Number, Zord, colour=Ranger))+geom_point()


#for your analysis
full_rangers<-inner_join(long_rangers, ranger_seasons)

#pivots 
#why do we do them? 
#cognition - we like to look at wide data

#lets explore the function
#documentation
#https://tidyr.tidyverse.org/reference/pivot_longer.html

#additional examples from documentation
billboard

#so lets start with the first week
billboard %>% 
  select(artist, track, wk1)


#and now lets see the top
billboard %>% 
  select(artist, track, wk1) %>% 
  arrange(wk1)

#make it wide
billboard %>%
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    values_to = "rank",
    values_drop_na = TRUE
  )

billboard_long<-billboard %>%
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    values_to = "rank",
    values_drop_na = TRUE
  )

View(billboard_long)

ggplot(billboard_long, aes(week, rank))+geom_point()+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))

#now we get into the really weird fun stuff