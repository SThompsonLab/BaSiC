#make text larger, axes thicker, etc

purty_graph <- theme(legend.position = "top", legend.text = element_text(size = 10), 
      legend.title = element_text(size = 14), 
      plot.title = element_text(size=18),
      axis.line = element_line(color = "black", size = 1.5), 
      axis.ticks = element_line(color = "black", size = 1.5), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      panel.background = element_blank(),
      axis.title = element_text(size = 16, family = "sans", color = "black"), 
      axis.text = element_text(size = 12, family = "sans", color = "black"))

 #add this to above if you need x axis labels to be tilted            
         
         axis.text.x = element_text(angle = 45, vjust = 0.5)) 

#The cellCycle_colors palette are the hexdecimal codes for G1, S, G2/M, mitosis, and premature mitosis respectively, as used in Justice et al, 2019
cellCycle_colors <- c("#D4D4D4", "#98C84C", "#23B8CC", "#F16B1A", "#E5001C")

#The temp_colors palette are the hexadecimal codes for 4, 22, and 37C, respectively:
temp_colors <- c("#638dff", "#cbb193ff", "#ffc35dff")

#transform y axis to log scale with pretty, Sunnie-friendly labels 
#(make sure to load package "scales")

+ scale_y_continuous(trans = "log10", breaks = trans_breaks("log10", function(x) 10^x),
                     labels = trans_format("log10", math_format(10^.x)))