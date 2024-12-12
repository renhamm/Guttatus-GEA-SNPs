#loading packages
library(dplyr)
library(tidyr)
library(tidyverse)

varList <- c("bladeLength", "germination", "heightAtFlower", "leafTrichomes", "leafWidth", "nodeOfFlower", "peduncleLength", "petioleLength", "timeToFlower", "totalNodes")

for (var in varList){
    file_list <- list()
    inputList <- list()
    for (i in 1:4){
        fileName <- paste("imputed_", i, "_pheno.", var, "_fullRange.param.txt", sep = "")
        assign(paste(var, "_FR_", i, sep = ""), (read.table(fileName, header = TRUE)) %>% rowid_to_column("ROW"))
        name4list <- paste(var, "_FR_", i, sep = "")
        file_list <- c(file_list, name4list)
    }
    inputList <- c(inputList, lapply(file_list, get))
    ensamb <- bind_rows(inputList)
    meanEnsamb <- ensamb %>% group_by(ROW) %>% summarise_all(mean)
    outputTxtName <- paste(var, "_FR_meanBSLMM.txt", sep = "")
    outputCsvName <- paste(var, "_FR_meanBSLMM.csv", sep = "")
    write.table(meanEnsamb, file = outputTxtName)
    write.csv(meanEnsamb, file = outputCsvName)
}

