library(tidytext)
library(topicmodels)
library(ggplot2)
library(dplyr)
library(tidyr)
library(tm)
library(stringr)


#to start we will use the classic AP stories example
#this is an antique
data("AssociatedPress")

#this object is a DTM
AssociatedPress


#this is our core mechanic - we pass our DTM to LDA; K is number of topics.
#this is an antique example designed for a two topic spread
ap_lda <- LDA(AssociatedPress, k = 2, control = list(seed = 1234))

#cross-check and verify
ap_lda

#did we pick the right number of topics
#perplexity should start high, then drop, then often increase again at the end
perplexity(ap_lda)


#and what are those
#these are the words which represent each topic
terms(ap_lda, k=5)


#but which words...
ap_topics <- tidy(ap_lda, matrix = "beta")
ap_topics

#group by TOPIC and get the TOP TEN
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>% 
  ungroup() %>%
  arrange(topic, -beta)

#now make a plot of that
ap_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  scale_y_reordered()


#this cute but largely useless for in situ models
#this will give us a better look into the differences
beta_wide <- ap_topics %>%
  mutate(topic = paste0("topic", topic)) %>%
  pivot_wider(names_from = topic, values_from = beta) %>% 
  filter(topic1 > .001 | topic2 > .001) %>%
  mutate(log_ratio = log2(topic2 / topic1))

#and a visual on that
beta_wide %>% 
  ggplot(aes(topic1, topic2, colour=log_ratio))+geom_text(aes(label=term))

#OK here is the problem with tidytext, they don't rep that this is what we all wanted
ap_documents <- tidy(ap_lda, matrix = "gamma")
ap_documents

#and this is the real deep key - NOT IN THE TEXTBOOK
ap_wide<-ap_documents %>%
  pivot_wider(id_cols=document, 
              names_from = topic,
              values_from = c(gamma))

#would you look at that...
View(ap_wide)

#so we don't get too frustrated lets rename the columns
colnames(ap_wide)[2]<-"A"
colnames(ap_wide)[3]<-"B"

#and there is your visual
ap_wide %>% 
  ggplot(aes(A,B, colour=document))+geom_point()


#now here is the next key step...
#we need to convert 


#import with a different name...

#first we will just combined the lyric lines back into a single object
songsB<-music %>% 
  group_by(name) %>% 
  select(c(album,name,lyrics))

#this is quanteda code that we are using as a loader
#NEW SKILL - CALLING FUNCTIONS FRMO AN UNATTACHED PACKAGE
song_corpus<-quanteda::corpus(songsB$lyrics, docvars = data.frame(song=songsB$name, album=songsB$album))


#now we can go ahead and call the object, read the results carefully
song_corpus

#this is a CORPUS object, so it is the texts with some metadata
#in this case we associated the TRACK and ALBUM names as those "DOCVARS"



#Let's use the songs then and model those
#quanteda can allow export to many distinct methods

#three distinct steps
#corpus to DFM
song_dfm<-song_corpus %>% 
  quanteda::tokens(remove_punct = TRUE, remove_symbols = TRUE) %>%
  quanteda::tokens_remove(quanteda::stopwords("en")) %>% 
  quanteda::dfm(verbose=FALSE)
#tidy it
D <-tidy(song_dfm)

#really simple stopwords
get_stopwords()

more<-data.frame(word=c("(",")",",","'","?","like", "\\"))
D<-D %>% 
  rename("word"="term") %>% 
  anti_join(get_stopwords()) %>% 
  anti_join(more) %>% 
  rename("term"="word")

#you jsut want to be sure that whatever pre-processing you do, the rename to TERM goes LAST  


#output as a DTM
song_dtm<-D%>%
  cast_dtm(document, term, count)


#now what...

#right back to our method, let's go 7 topics though because 9 albums
song_lda <- LDA(song_dtm, k = 7, control = list(seed = 1234))
tm_documents <- tidy(song_lda, matrix = "gamma")


#from here on it gets into special dan territory 
tm_wide<-tm_documents %>%
  pivot_wider(id_cols=document, 
              names_from = topic,
              values_from = c(gamma))

#now to split that
library(stringr)
#get rid of those pesky texts
id_vars<-str_remove_all(tm_wide$document, "text")

#add that back to the data
with_docs<-data.frame(tm_wide, song_number=as.numeric(id_vars))

#now you should find some way to connnect MUSIC to with_docs...


