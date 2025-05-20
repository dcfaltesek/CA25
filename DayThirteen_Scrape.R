#scraping is a very helpful skill
#when we scrape we can use R like a web browser
#so long as you have a sense of how a webpage is built you can find where the goodies are

library(rvest)

url<-"https://en.wikipedia.org/wiki/Grammy_Award_for_Best_New_Artist"
path<-"/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/table[8]"

url %>% 
  read_html() %>% 
  html_element(xpath=path) %>% 
  html_table()

result<-url %>% 
  read_html() %>% 
  html_element(xpath=path) %>% 
  html_table()

library(stringr)

result$Nominees

noms<-str_split(result$Nominees, "\n")

library(reshape2)

melt(noms)
melty_noms<-melt(noms)
#here is a quick and dirty join
#add a KEY to result

library(dplyr)
result_B<-result %>% mutate("L1" = as.integer(row.names(result)))

inner_join(result_B, melty_noms)


#you can also grab text by style
urlB<-"https://theonion.com/republican-infighting-erupts-over-whether-trump-bill-beautiful-or-handsome/"
css<-".theonion-dingbat"

urlB %>% 
  read_html() %>% 
  html_element(css=css) %>% 
  html_text()

#what if we just want the captions from the pictures
urlC<-"https://www.artforum.com/features/carnegie-eric-crosby-art-museums-relevance-1234729871/"
cssB<-".wp-block-pullquote"
cssC<-"figure"

#all CSS classes starting with figure
urlC %>% 
  read_html() %>% 
  html_element(css=cssC) %>% 
  html_text()

