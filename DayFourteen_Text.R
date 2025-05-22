#lets work with some text
library(stringr)
library(tidyr)
library(dplyr)
library(ggplot2)

#for today, lets work with the music data

#if you need to have a look, this is our key information today
music$lyrics

#there are a lot of really cool features in stringr on its own, a lot of them work better if you use them in a MUTATE
#lets explore a few just on their own

#how long
str_length(music$lyrics)

#so which song is shortest?
music$lyrics[319]

#in a nice data frame
music_long<-music %>% 
  mutate("long" = str_length(music$lyrics))

#let's graph that
music_long %>% 
  ggplot(aes(long, tempo, colour=danceability))+geom_point()+scale_color_distiller(palette = "PRGn", direction = 1)

#detect a string
str_detect(music$lyrics, "apple")

#count the uses of a string 
str_count(music$lyrics, "orange")

#extract the string
str_extract(music$lyrics, "banana")

#which indicies include the string
str_which(music$lyrics, "lemon")
str_which(music$lyrics, "lime")

#since we know its song 316, just go there
str_locate(music$lyrics, "lime")
#so lime is characters 914 to 917
music$lyrics[316]

#now we can start breaking things apart, which can be really helpful 
str_split(music$lyrics, "real")
#go take a look at song 410...

#more useful..
musicB<-music %>% 
  mutate("sections"=str_split(lyrics, "real")) %>% unnest_wider(sections, names_sep = "a")
View(musicB)

#not the greatest example as one song ends up 28 wide, but you can see the utility here

#sometimes you just have a lot of garbage to manage
str_trunc(music$lyrics, 100, side = c("right"))

#this is just a very nice clean helper
str_trim(music$lyrics, side = c("both"))

#another great helper, get rid of all those pesky capital letters
str_to_lower(music$lyrics)

#regex is where things will really start to cook for you
music %>% 
  filter(str_detect(name, "^O")) %>% 
  filter(str_detect(name, "e$"))

#so we could like make a scatterplot of all the songs with the letter Z
music %>% 
  filter(str_detect(name, "z")) %>% 
  ggplot(aes(popularity, danceability, colour=year))+geom_point()

#here is a more advanced regex

#every song which includes a word where an s is followed by a y
str_detect(music$lyrics, "s(?=y)")
#some of those might not be strawberry
#Lets do a mutate...

musicC<-music %>% 
  mutate("test1" = str_detect(music$lyrics, "a(?=p{2})")) %>% 
  mutate("test2" = str_detect(music$lyrics, "apple"))
View(musicC)

#we can see that detecting a followed by 2 ps is not the same as searching for apple



