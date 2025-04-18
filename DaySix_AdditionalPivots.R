w25i<-weddings25 %>% 
  pivot_longer(Season)
View(w25i)

w25O<-weddings25 %>% 
  select(c(State, Budget, Season))

w25O %>% 
  pivot_wider(names_from = State, values_from = Budget, values_fn = mean)

fish_encounters
fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen)



P<-weddings25 %>% 
  select(c(Age, Budget, Result))

P2<-P %>% pivot_wider(names_from = Result, values_from = Budget, values_fn = mean)
View(P2)



P<-weddings25 %>% 
  select(c(Age, Age.1, Budget, Result))

P2<-P %>% 
  mutate("difference" = Age-Age.1)

P3<-P2 %>%
  select(c(difference, Budget, Result)) %>% 
  pivot_wider(names_from = Result, values_from=Budget, values_fn = mean)

View(P3)

TV %>% 
  ggplot(aes(Year, Rating, colour=Type))+geom_jitter()+facet_wrap(~Network)



