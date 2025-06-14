#for now we should rock a kafka story
text <- c("For we are like tree trunks in the snow. ",
          "In appearance they lie sleekly and a little push should be enough to set them rolling.",
          "No, it can't be done, for they are firmly wedded to the ground.",
          "But see, even that is only appearance.")


#there is a nice way to create a happy corpus dataframe...
library(tidyverse)
library(tidytext)
text_df <- data.frame(line = 1:4, text = text)

#take a look at all that tidy elegance
text_df

#here is the key idea for all text methods - we need to break this down into tokens
#this is a key method in machine learning, sentiment...all of it. 
library(magrittr)
#you have seen this structure before
#start big and pipe into something more specific
tidy_text<-text_df %>%
  #WORDS from the column called TEXT
  unnest_tokens(word, text)

#this function is really well done, notice how it took all of those apart?

#a theoretical note: what do we do with stopwords?
#what if some of the words don't mean?
data(stop_words)

tidy_stop <- tidy_text %>%
  dplyr::anti_join(stop_words)

#much like centrality in the last unit, these are NOT settled questions
#if we use a tensor flow based method, stopwords are always incldued.

View(tidy_stop)
#that is an elegant dataset
library(gutenbergr)
#all possible authors
View(gutenberg_authors)

#some works by some famous authors
gutenberg_works(author=="Asimov, Isaac" | author == "Fitzgerald, F. Scott (Francis Scott)")

paradise<-gutenberg_download(805)
youth<-gutenberg_download(31547)

#let's go vanilla
paradise %>% 
  unnest_tokens(word, text) %>% 
  count(word) %>% 
  arrange(desc(n))

#oh that isn't nice
youth_words<-youth %>% 
  unnest_tokens(word, text) %>% 
  dplyr::anti_join(stop_words) %>% 
  dplyr::count(word) %>% 
  dplyr::arrange(desc(n))

#now for azimov
paradise_words<-paradise %>% 
  unnest_tokens(word, text) %>% 
  dplyr::anti_join(stop_words) %>% 
  dplyr::count(word) %>% 
  dplyr::arrange(desc(n))


#now we can plot those
g<-data.frame("author"="azimov", youth_words, total=sum(youth_words$n))
a<-data.frame("author"="fitzgerald", paradise_words, total=sum(paradise_words$n))

compare<-bind_rows(a,g)

library(ggplot2)
compare %>% 
  ggplot(aes(n, n/total, colour=author)) + 
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5)+scale_x_log10() +
  scale_y_log10() +facet_grid(~author)
