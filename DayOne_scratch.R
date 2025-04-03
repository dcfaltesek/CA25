library(ggplot2)
library(ggvis)
library(dplyr)


glimpse(cocaine)
cocaine %>% 
  ggplot(aes(weight, price, colour=potency))+geom_jitter()



A<-6

"pink"=="orange"

tristate_cocaine<-filter(cocaine, state == "FL" | state == "NY" | state == "OR")


ggplot(tristate_cocaine, aes(price, potency, colour=state))+geom_point()

cocaine %>%
  filter(state == "IA" | state == "NH")%>%
  ggplot(aes(price, potency, size = weight, colour=state))+geom_jitter()


# Character dataset for mysterious text reconstruction
char_data <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
               "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ")

# Mysterious encoded lines (index positions from char_data)
mystery_lines <- list(
  c(14, 5, 22, 5, 18, 27, 7, 15, 14, 14, 1, 27, 7, 9, 22, 5, 27, 25, 15, 21, 27, 21, 16),    # never gonna give you up
  c(14, 5, 22, 5, 18, 27, 7, 15, 14, 14, 1, 27, 12, 5, 20, 27, 25, 15, 21, 27, 4, 15, 23, 14), # never gonna let you down
  c(14, 5, 22, 5, 18, 27, 7, 15, 14, 14, 1, 27, 18, 21, 14, 27, 1, 18, 15, 21, 14, 4, 27, 1, 14, 4, 27, 4, 5, 19, 5, 18, 20, 27, 25, 15, 21), # run around desert you
  c(14, 5, 22, 5, 18, 27, 7, 15, 14, 14, 1, 27, 13, 1, 11, 5, 27, 25, 15, 21, 27, 3, 18, 25), # make you cry
  c(14, 5, 22, 5, 18, 27, 7, 15, 14, 14, 1, 27, 19, 1, 25, 27, 7, 15, 15, 4, 2, 25, 5),       # say goodbye
  c(14, 5, 22, 5, 18, 27, 7, 15, 14, 14, 1, 27, 20, 5, 12, 12, 27, 1, 27, 12, 9, 5, 27, 1, 14, 4, 27, 8, 21, 18, 20, 27, 25, 15, 21) # tell a lie and hurt you
)

# Function to decode and print mystery lines
decode_lyrics <- function(lines, dictionary) {
  for (line in lines) {
    cat(paste0(dictionary[line], collapse = ""), "\n")
  }
}

# Activate the decoder 🕵
decode_lyrics(mystery_lines, char_data)





