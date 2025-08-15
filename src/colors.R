library(tidyverse)

p_col = "#2A0944"
q_col = "#FEC260"
c_col = "#3FA796"

p_col = "#9DBF9E"
q_col = "#FFB800"
c_col = "#E56399"

p_col_dark = "#799B7A"
q_col_dark = "#DB9400"
c_col_dark = "#9E1C52"

drought_col = "#EF8354"
watered_col = "#175676"

gg_spcolor = scale_color_manual(name = "Seedling species", breaks = c("P", "Q"), 
                                labels = c("Bigcone", "Oak"),
                                values = c(p_col, q_col, c_col))
gg_spfill = scale_fill_manual(name = "Seedling species", breaks = c("P", "Q"), 
                              labels = c("Bigcone", "Oak"),
                              values = c(p_col, q_col, c_col))

gg_nspcolor = scale_color_manual(name = "Neighbor species", breaks = c("P", "Q"), 
                                labels = c("Bigcone", "Oak"),
                                values = c(p_col, q_col, c_col))
gg_nspcolord = scale_color_manual(name = "Neighbor species", breaks = c("P", "Q"), 
                                 labels = c("Bigcone", "Oak"),
                                 values = c(p_col_dark, q_col_dark, c_col_dark))
gg_nspfill = scale_fill_manual(name = "Neighbor species", breaks = c("P", "Q"), 
                              labels = c("Bigcone", "Oak"),
                              values = c(p_col, q_col, c_col))

gg_soilcolor = scale_color_manual(name = "Soil condition", breaks = c("P", "Q", "C"), 
                                  labels = c("Bigcone", "Oak", "Control"),
                                  values = c(p_col, q_col, c_col))
gg_soilcolord = scale_color_manual(name = "Soil condition", breaks = c("P", "Q", "C"), 
                                  labels = c("Bigcone", "Oak", "Control"),
                                  values = c(p_col_dark, q_col_dark, c_col_dark))
gg_soilfill = scale_fill_manual(name = "Soil condition", breaks = c("P", "Q", "C"), 
                                labels = c("Bigcone", "Oak", "Control"),
                                values = c(p_col, q_col, c_col))

gg_nsoilcolor = scale_color_manual(name = "Neighbor soil", breaks = c("P", "Q", "C"), 
                                   labels = c("Bigcone", "Oak", "Control"),
                                   values = c(p_col, q_col, c_col))
gg_nsoilcolord = scale_color_manual(name = "Neighbor soil", breaks = c("P", "Q", "C"), 
                                   labels = c("Bigcone", "Oak", "Control"),
                                   values = c(p_col_dark, q_col_dark, c_col_dark))

gg_nsoilfill = scale_fill_manual(name = "Neighbor soil", breaks = c("P", "Q", "C"), 
                                 labels = c("Bigcone", "Oak", "Control"),
                                 values = c(p_col, q_col, c_col))

gg_droughtcolor = scale_color_manual(name = "Watering\ntreatment", breaks = c("D", "C"), 
                                     labels = c("Drought", "Watered"),
                                     values = c(drought_col, watered_col))
gg_droughtfill = scale_fill_manual(name = "Watering\ntreatment", breaks = c("D", "C"), 
                                   labels = c("Drought", "Watered"),
                                   values = c(drought_col, watered_col))
white_theme = theme(
  plot.title = element_text(color = "white", size = 14, face = "bold"),
  axis.title.x = element_text(color = "white", size = 12),
  axis.title.y = element_text(color = "white", size = 12),
  axis.text.x = element_text(color = "white"),
  axis.text.y = element_text(color = "white"),
  legend.text = element_text(color = "white"),
  legend.title = element_text(color = "white"),
  strip.text = element_text(color = "white"))


no_grids = theme( panel.grid = element_blank(), # Remove all gridlines
                  axis.line = element_line(color = "white"))  # Keep axis lines
no_axistext = theme(axis.text = element_blank())+
  theme(axis.text.x = element_blank(), axis.text.y = element_blank())  # Remove axis text
