#day three - more sophistication in graphs
#remember to load those libraries
library(ggplot2)
library(dplyr)
library(nycflights23)

#we need to start by getting some data to work with, a good place to start is with flights, yep
flights

#because object permanence is overrated, lets put that in our environment
flights<-flights

#and because we want things to run smoothly lets do some filtering to make things smaller
#we have two options here - you can store a filtered dataset in the environment OR you can pipe it each time
#here is how each of those looks

#all the flights on United NOT at Newark
flightsB<-filter(flights, carrier == "UA" & origin != "EWR")

#or you can write it like this for DELTA not at LGA
#start with the biggest thing and send that forward
flights %>% 
  filter(carrier == "DL" & origin != "JFK")

#now we will make a quick scatterplot, here are both ways
ggplot(flightsB, aes(time_hour, dep_time, colour=flight))+geom_jitter()

#this one is a little more complicated but can pay dividends later (once we have big long multipipe structures)
flights %>% 
  filter(carrier == "DL" & origin != "JFK") %>% 
  #notice the FILTERED data is the LEFT side of the argument...
  ggplot(aes(time_hour, dep_time, colour=flight))+geom_jitter()

#not to keep you guessing, why did I use flight number? Because I wanted a stochastic continuous variable for color
#this gives us lots of dots all along the domain for the palatte
#why did I switch to NOT JFK? Because Delta sends a lot of "prestige" flights from JFK so they have very low numbers
#the colors are less fun

#we are going to manipulate colors first
#today we are just playing with CONTINOUS variable colors, more on that mathy math soon

#to keep our lines down, we will use the stored flightsB example (but you can totally use the piped one too)
ggplot(flightsB, aes(time_hour, dep_time, colour=flight))+geom_jitter()+scale_color_gradient2(low = "red", high = "blue",
                                                                                             mid = "white", midpoint = 500)
#this example is a lot of fun because you can play with all three colors and the midpoint where the color noted as blue lives

ggplot(flightsB, aes(time_hour, dep_time, colour=flight))+geom_jitter()+scale_color_gradient2(low = "red", high = "orange",
                                                                                              mid = "yellow", midpoint = 500)

#if you are copying from cheatsheets, be sure to check to see that the correct quotation marks came in via character code (that can really be a bummer)

#here is another fun one - just swaping in another basic monochromatic palatte, its like Regis Philbin in 2000...
#for documentation sake I am going to add a line break after the +
ggplot(flightsB, aes(time_hour, dep_time, colour=flight))+geom_jitter()+
  #gradientn lets you pick a palatte with a set of colors and then declare how many "stops" or total colors are used, so here is a 24 color rainbow
  #sort of a psychadelic look
  scale_color_gradientn(colours=rainbow(24))

#a lot of the documentation involves storing a basic graph as a variable and then just adding to it, this will show you how to use the documentation 
G<-ggplot(flightsB, aes(time_hour, dep_time, colour=flight))+geom_jitter()

G+scale_color_distiller(palette = "Blues")
G+scale_color_distiller(palette = "Greens")
G+scale_color_distiller(palette = "Purples")


#let's change a few more elements eh?
#what if we want a fun panel color
G+scale_color_distiller(palette = "Greens")+theme(panel.background = element_rect(fill = "#67c9ff"))

#now what if we want fun background and panel colors
G+scale_color_distiller(palette = "Greens")+theme(plot.background = element_rect(fill = "lightpink"))+theme(panel.background = element_rect(fill = "#67c9ff"))

#now lets add all the features
G+scale_color_distiller(palette = "Greens")+theme(plot.background = element_rect(fill = "lightpink"))+
  theme(panel.background = element_rect(fill = "#67c9ff"))+
  ggtitle("Wow what a cool graphic", subtitle = "An exploration of Colour!" )

#or using base R
G+scale_color_distiller(palette = "Greens")+theme(plot.background = element_rect(fill = "lightpink"))+
  theme(panel.background = element_rect(fill = "#67c9ff"))+
  labs(title = "My sweet colors",
     subtitle = "to show some skills",
     caption = "and create a nice thing",
     tag = "Fig. 1")

#you can really get under the hood and change almost anything
G+scale_color_distiller(palette = "Greens")+theme(plot.background = element_rect(fill = "lightpink"))+
  theme(panel.background = element_rect(fill = "#67c9ff"))+
  labs(title = "My sweet colors",
       subtitle = "to show some skills",
       caption = "and create a nice thing",
       tag = "Fig. 1")+
  theme(plot.title = element_text(family = "serif",              # Font family
                                face = "bold",                 # Font face
                                color = 4,                     # Font color
                                size = 15,                     # Font size
                                hjust = 1,                     # Horizontal adjustment
                                vjust = 1,                     # Vertical adjustment
                                angle = -10))+
  #you can use the same sort of code to change every element
  theme(plot.subtitle = element_text(family = "serif",              # Font family
                                  face = "italic",                 # Font face
                                  color = 2,                     # Font color
                                  size = 15,                     # Font size
                                  hjust = -1,                     # Horizontal adjustment
                                  vjust = 1,                     # Vertical adjustment
                                  angle = +10))



