# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
View(flights)
dep_delay_by_month <- flights %>% 
  group_by(month) %>% 
  summarize(
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  )

# Which month had the greatest average departure delay?
greatest_avg <- dep_delay_by_month %>% 
  filter(avg_dep_delay == max(avg_dep_delay)) %>% 
  pull(month)
print(greatest_avg) #7 (July)

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
dep_delay_by_month %>% 
  plot("month", "avg_dep_delay")

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
avg_arr_delay_dest <- flights %>% 
  group_by(dest) %>% 
  summarize(
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(avg_arr_delay == max(avg_arr_delay, na.rm = TRUE)) %>% 
  pull(dest) #CAE

# You can look up these airports in the `airports` data frame!
airport <- airports %>% 
  filter(faa == "CAE")
print(airport)

# Which city was flown to with the highest average speed?
highest_avg_speed <- flights %>% 
  mutate(
    avg_speed = distance / air_time) %>% 
  filter(avg_speed == max(avg_speed, na.rm = TRUE)) %>% 
  pull(dest)
print(highest_avg_speed)
#ATL