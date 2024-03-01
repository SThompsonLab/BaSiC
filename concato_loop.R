thelist <- list.files(path = "data/", pattern = "_all_cells.csv")

print(thelist)

done <- c()

for (unique in thelist) {
  
  if (!unique %in% done) {
    
    file <- read.csv(paste0("data/",unique))
      
      if(!exists("concato")){
        
        concato <- file
      }
      else {
        concato <- rbind(concato, file)
      }
    }
      
    done <- append(done, unique)
    
  }
  

write.csv(concato, "data/experiment_all_cells.csv")

rm(concato)
rm(file)
rm(done)
rm(thelist)
rm(unique)

data <- read.csv("Concato_DMSO_DMSO_all_cells.csv")

names(data)

bingus <- ggplot(data, aes(x=Mean_ANC_edu, y=Mean_ANC_ph3)) + geom_point() + facet_wrap("Infection")

bingus
