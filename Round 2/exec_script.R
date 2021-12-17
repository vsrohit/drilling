# Global details for the analysis ----------------------------------------------
# !!!!Execute these before you execute the functions
nExp <- 10    # Number of experimens
sf   <- 10000 # Sampling Frequency
f    <- 5000  # Frame size

#These values are determined after executing Step 1. Store the values here after
# running Step 1
start_c <- f * c(10, 1, 40, 15, 10, 8, 1, 6, 10, 21) + 1
end_c <- f * c(33, 24, 50, 38, 25, 19, 7, 16, 26, 60)
start_e <- f * c(0, 0, 25, 6, 0, 3, 0, 1, 5, 10) + 1
end_e   <- start_c - 1

# Get the data and select the required component -------------------------------
#Read the raw data from csv
exp_data <- get_exp_data()

#Select only Fz data (column number 4)
Fz_data <- get_component(exp_data, 4) 

# Step 1 - Identifying the continuous data region ------------------------------
## After finding out the steady cutting zone, you need not rerun this step

# Find the mean for each frame and plot it
Fz_mean_ini <- Fz_data %>% 
  add_frame_numbers() %>%  #Adds data frame to data
  frame_stat(mean)

p <- stat_plot(Fz_mean_ini, "Frame number", "Mean")
save_plot("First graph.pdf",p, base_height = 11.69, base_width = 8.27)

# Use the plot to identify the frame numbers range of continuous data and store
# it in start_c and end_c

# Step 2 - Get continuous data with added frame number--------------------------
cont_Fz <-  Fz_data %>%
  get_continuous_data() %>%
  adjust_time() %>%
  add_frame_numbers()

# Step 2.5 - Export entry data for separate analysis ---------------------------
# Like cont_Fz, it also has frame number included
entry_Fz <- Fz_data %>%
  get_entry_data() %>%
  adjust_time() %>%
  add_frame_numbers()

# Step 3 - Violin plot ----
violin_data <- make_frames_as_factors(cont_Fz)
pvio <- plot_violin(violin_data)
save_plot("Violinplot.pdf",pvio,
          base_height = 11.69, base_width = 8.27)

# Step 4 - Caclulate stats and plot them-------
#Calculate mean and plot data
Fz_mean_1 <- frame_stat(cont_Fz, mean)
p_mean <- stat_plot(Fz_mean_1, "Frame number", "Mean")
save_plot("Continuous mean plot.pdf",p_mean,
          base_height = 11.69, base_width = 8.27)

#Calculate sd and plot data
Fz_sd_1 <- frame_stat(cont_Fz, sd)
p_sd <- stat_plot(Fz_sd_1, "Frame number", "Standard deviation")
save_plot("Continuous sd plot.pdf",p_sd,
          base_height = 11.69, base_width = 8.27)

#Calculate skewness and plot data
Fz_skew_1 <- frame_stat(cont_Fz, skewness)
p_skew <- stat_plot(Fz_skew_1, "Frame number", "Skewness")
save_plot("Continuous skew plot.pdf",p_skew,
          base_height = 11.69, base_width = 8.27)

#Calculate Kurtosis and plot data
Fz_kurt_1 <- frame_stat(cont_Fz, kurtosis)
p_kurt <- stat_plot(Fz_kurt_1, "Frame number", "Kurtosis")
save_plot("Continuous kurt plot.pdf",p_kurt,
          base_height = 11.69, base_width = 8.27)

#Calculate single stats for each experiment and store them in final_data
full_mean <- full(cont_Fz, mean)
full_sd <- full(cont_Fz, sd)
full_skew <- full(cont_Fz, skewness)
full_kurt <- full(cont_Fz, kurtosis)

final_data <- data.frame("Mean" = full_mean,
                         "Std.dev" = full_sd,
                         "Skewness" = full_skew,
                         "Kurtosis" = full_kurt)

write.csv(final_data, "final_data.csv")

#Calculate trends and store them in a data frame called final_data_trend
mean_trend <- trend(Fz_mean_1)
sd_trend <- trend(Fz_sd_1)
skew_trend <- trend(Fz_skew_1)
kurt_trend <- trend(Fz_kurt_1)
final_data_trend <- data.frame("Mean_trend" = mean_trend,
                               "Std.dev_trend" = sd_trend,
                               "Skewness_trend" = skew_trend,
                               "Kurtosis_trend" = kurt_trend)

write.csv(final_data_trend, "final_data_trend.csv")


