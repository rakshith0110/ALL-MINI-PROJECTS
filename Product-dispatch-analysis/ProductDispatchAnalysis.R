setwd("E:/2nd CSE - 3RD SEMISTER/2.PRACTICALS LAB - 3rd SEM/R Programming Lab/MINI PROJECT/PRODUCT  DISPATCH ANALYSIS")
getwd()
#---------------------------------------------------------------------------------
                                  #HYBRID#
#---------------------------------------------------------------------------------
#HYBRID-Bar plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)

library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)
ggplot(df, aes(x = MONTHS, y = HYBRID, fill = MONTHS)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5),custom_y_labels, limits = c(0, 100)) +
  scale_fill_manual(values = rainbow(12)) +
  geom_text(aes(label = HYBRID), position = position_dodge(width = 0.9), vjust = -0.5) +
  labs( title = "Product Dispatch Analysis",
        subtitle = "HYBRID -Bar chat", 
        caption = "2023" ) + 
  theme(legend.position = "top", 
        panel.background = element_rect(fill = "lightgrey"),  # Set background color
        plot.background = element_rect(fill = "lightskyblue")) +  # Set plot area background color
  ggsave("1a.HYBRID-bar plot.png",device = "png")
#-----------------------------------------------------------------------------------------------------
#HYBRID-Combination chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a combination chart (bar chart and line chart)
ggplot(df, aes(x = MONTHS, y = HYBRID, group = 1)) +
  geom_bar(stat = "identity", position = "dodge", fill = "skyblue") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5),custom_y_labels, limits = c(0, 100)) +
  
  # Add line chart
  geom_line(color = "red") +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = HYBRID), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "HYBRID -Combination Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("1b.HYBRID-Combination chart.png", device = "png")

#--------------------------------------------------------------------------
#HYBRID-Line plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a line chart
ggplot(df, aes(x = MONTHS, y = HYBRID, group = 1)) +
  geom_line(color = "skyblue") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5),custom_y_labels, limits = c(0, 100)) +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = HYBRID), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "HYBRID -Line Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("1c.HYBRID-line chart.png", device = "png")
#----------------------------------------------------------------------------
#HYBRID-Pie chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a pie chart
ggplot(df, aes(x = "", y = HYBRID,fill = MONTHS)) +
  geom_bar(stat = "identity", width = 1) +
  
  # Set custom axis labels
  scale_fill_manual(values = rainbow(12)) +
  
  # Add values on top of the slices
  geom_text(aes(label = HYBRID), position = position_stack(vjust = 0.5)) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "HYBRID -Pie Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("1d.HYBRID-Pie chart.png", device = "png")
#--------------------------------------------------------------------------------
                                  #MASTER#
#---------------------------------------------------------------------------------
#MASTER-Bar plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)
ggplot(df, aes(x = MONTHS, y = MASTER, fill = MONTHS)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5), custom_y_labels, limits = c(0, 100)) +
  scale_fill_manual(values = rainbow(12)) +
  geom_text(aes(label = MASTER), position = position_dodge(width = 0.9), vjust = -0.5) +
  labs(title = "Product Dispatch Analysis",
       subtitle = "MASTER -Bar chat",
       caption = "2023") +
  theme(legend.position = "top",
        panel.background = element_rect(fill = "lightgrey"),  # Set background color
        plot.background = element_rect(fill = "lightgreen")) +  # Set plot area background color
  ggsave("2a.MASTER-bar plot.png", device = "png")
#-----------------------------------------------------------------------------------------------------
#MASTER-Combination chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a combination chart (bar chart and line chart)
ggplot(df, aes(x = MONTHS, y = MASTER, group = 1)) +
  geom_bar(stat = "identity", position = "dodge", fill = "green") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5), custom_y_labels, limits = c(0, 100)) +
  
  # Add line chart
  geom_line(color = "red") +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = MASTER), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "MASTER -Combination Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("2b.MASTER-Combination chart.png", device = "png")

#--------------------------------------------------------------------------
#MASTER-Line plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a line chart
ggplot(df, aes(x = MONTHS, y = MASTER, group = 1)) +
  geom_line(color = "green") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5), custom_y_labels, limits = c(0, 100)) +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = MASTER), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "MASTER -Line Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("2c.MASTER-line chart.png", device = "png")
#----------------------------------------------------------------------------
#MASTER-Pie chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a pie chart
ggplot(df, aes(x = "", y = MASTER, fill = MONTHS)) +
  geom_bar(stat = "identity", width = 1) +
  
  # Set custom axis labels
  scale_fill_manual(values = rainbow(12)) +
  
  # Add values on top of the slices
  geom_text(aes(label = MASTER), position = position_stack(vjust = 0.5)) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "MASTER -Pie Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("2d.MASTER-Pie chart.png", device = "png")
#---------------------------------------------------------------------------------
                                    #LEKSUN#
#---------------------------------------------------------------------------------
#LEKSUN-Bar plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)
ggplot(df, aes(x = MONTHS, y = LEKSUN, fill = MONTHS)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5), custom_y_labels, limits = c(0, 100)) +
  scale_fill_manual(values = rainbow(12)) +
  geom_text(aes(label = LEKSUN), position = position_dodge(width = 0.9), vjust = -0.5) +
  labs( title = "Product Dispatch Analysis",
        subtitle = "LEKSUN -Bar chat", 
        caption = "2023" ) + 
  theme(legend.position = "top", 
        panel.background = element_rect(fill = "lightgrey"),  # Set background color
        plot.background = element_rect(fill = "lightpink")) +  # Set plot area background color
  ggsave("3a.LEKSUN-bar plot.png", device = "png")
#-----------------------------------------------------------------------------------------------------
#LEKSUN-Combination chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a combination chart (bar chart and line chart)
ggplot(df, aes(x = MONTHS, y = LEKSUN, group = 1)) +
  geom_bar(stat = "identity", position = "dodge", fill = "pink") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5), custom_y_labels, limits = c(0, 100)) +
  
  # Add line chart
  geom_line(color = "red") +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = LEKSUN), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "LEKSUN -Combination Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("3b.LEKSUN-Combination chart.png", device = "png")

#--------------------------------------------------------------------------
#LEKSUN-Line plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a line chart
ggplot(df, aes(x = MONTHS, y = LEKSUN, group = 1)) +
  geom_line(color = "pink") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5), custom_y_labels, limits = c(0, 100)) +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = LEKSUN), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "LEKSUN -Line Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("3c.LEKSUN-line chart.png", device = "png")
#----------------------------------------------------------------------------
#LEKSUN-Pie chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a pie chart
ggplot(df, aes(x = "", y = LEKSUN, fill = MONTHS)) +
  geom_bar(stat = "identity", width = 1) +
  
  # Set custom axis labels
  scale_fill_manual(values = rainbow(12)) +
  
  # Add values on top of the slices
  geom_text(aes(label = LEKSUN), position = position_stack(vjust = 0.5)) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "LEKSUN -Pie Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("3d.LEKSUN-Pie chart.png", device = "png")
#---------------------------------------------------------------------------------
                                   #FACADE#
#---------------------------------------------------------------------------------
#FACADE-Bar plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)
ggplot(df, aes(x = MONTHS, y = FACADE, fill = MONTHS)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5),custom_y_labels, limits = c(0, 100)) +
  scale_fill_manual(values = rainbow(12)) +
  geom_text(aes(label = FACADE), position = position_dodge(width = 0.9), vjust = -0.5) +
  labs( title = "Product Dispatch Analysis",
        subtitle = "FACADE -Bar chat", 
        caption = "2023" ) + 
  theme(legend.position = "top", 
        panel.background = element_rect(fill = "lightgrey"),  # Set background color
        plot.background = element_rect(fill = "lightyellow")) +  # Set plot area background color
  ggsave("4a.FACADE-bar plot.png",device = "png")

#-----------------------------------------------------------------------------------------------------
#FACADE-Combination chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a combination chart (bar chart and line chart)
ggplot(df, aes(x = MONTHS, y = FACADE, group = 1)) +
  geom_bar(stat = "identity", position = "dodge", fill = "orange") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5),custom_y_labels, limits = c(0, 100)) +
  
  # Add line chart
  geom_line(color = "red") +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = FACADE), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "FACADE -Combination Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("4b.FACADE-Combination chart.png", device = "png")

#--------------------------------------------------------------------------
#FACADE-Line plot#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a line chart
ggplot(df, aes(x = MONTHS, y = FACADE, group = 1)) +
  geom_line(color = "orange") +
  
  # Set custom axis labels
  scale_x_discrete(breaks = custom_x_labels) +
  scale_y_continuous(breaks = seq(0, 100, by = 5),custom_y_labels, limits = c(0, 100)) +
  
  # Add points to the line chart
  geom_point(color = "red") +
  
  # Add values on top of the points
  geom_text(aes(label = FACADE), vjust = -0.5) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "FACADE -Line Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("4c.FACADE-line chart.png", device = "png")

#----------------------------------------------------------------------------
#FACADE-Pie chart#
df = read.csv("DispatchedLightsList.csv")
summary(df)
str(df)
library(ggplot2)
# Custom names for x-axis limits and months
custom_x_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
custom_y_labels <- c("LIGHTS")
# Convert MONTHS to a factor with custom labels
df$MONTHS <- factor(df$MONTHS, levels = 1:12, labels = custom_x_labels)

# Create a pie chart
ggplot(df, aes(x = "", y = FACADE,fill = MONTHS)) +
  geom_bar(stat = "identity", width = 1) +
  
  # Set custom axis labels
  scale_fill_manual(values = rainbow(12)) +
  
  # Add values on top of the slices
  geom_text(aes(label = FACADE), position = position_stack(vjust = 0.5)) +
  
  # Add titles and labels
  labs(
    title = "Product Dispatch Analysis",
    subtitle = "FACADE -Pie Chart",
    caption = "2023"
  ) +
  
  # Save the plot
  ggsave("4d.FACADE-Pie chart.png", device = "png")