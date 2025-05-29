library(tidytext)
library(dplyr)
library(tidyr)
library(ggplot2)
library(textdata)
library(ggrepel)

music_counted <- music %>%
  #for the homework this is a really important line
  #the first argument being passed is the level of chunking you want
  #the second is the column where the text is
  unnest_tokens(word, lyrics) %>%
  #our data has an ID number for each song called "sid_id"
  #you may want to add a column like this to YOUR corpus
  count(name, word, sort = TRUE)%>%
  rename(per_line = n)

afinn<-get_sentiments("afinn")
nrc<-get_sentiments("nrc")

with_scores<-music_counted%>%
  #THIS IS THE INNERJOIN I WAS YELLING ABOUT!
  inner_join(afinn, by="word")

scores_per_song<-with_scores%>%
  group_by(name)%>%
  #notice our per line strategy is SUM
  summarize(line_value=sum(value), line_var=sd(value))

music_sentiments<-inner_join(music, scores_per_song, by="name")




