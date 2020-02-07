# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
avg_arr_delay_dest <- flights %>% 
  group_by(dest) %>% 
  summarize(
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  select(dest, avg_arr_delay)

new_flight <- left_join(flights, avg_arr_delay_dest)

largest_avg_arr_delay <- new_flight %>% 
  group_by(dest) %>% 
  filter(avg_arr_delay == max(avg_arr_delay, na.rm = TRUE))
print(largest_avg_arr_delay)
# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
avg_arr_delay_airline <- flights %>% 
  group_by(carrier) %>% 
  summarize(
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  select(carrier, avg_arr_delay)
new_airline <- left_join(airlines, avg_arr_delay_airline)
smallest_avg_arr_delay <- new_airline %>% 
  filter(avg_arr_delay == min(avg_arr_delay, na.rm = TRUE)) %>% 
  pull(carrier)
print(smallest_avg_arr_delay)
#AS