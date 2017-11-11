library(ggplot2)
library(dplyr)
library(stringr)
library(rvest)
library(magrittr)
library(readr)

options <- commandArgs(trailingOnly = T)

index <- as.numeric(options[1])
print(index)

path <- "./data/gun-fields"
load(file = paste0(path,"/urls.RData"))



getFields <- function(url) {
  html <- read_html(url)
  
  nodes <- html %>%
    html_nodes(xpath = '//*[@id="main"]/div/div[4]/div/div[2]/div[2]/ul[2]/li') %>%
    html_text() %>%
    str_replace_all("\\r\\n", '') %>%
    str_trim() 
  
  allcategory <- data.frame(names = c("category", "manufacturer", "caliber", "action", "firearm type"), 
                            stringsAsFactors = F)
  
  category <- str_extract(nodes, '(.*?)(?=\\s{2,})') %>% tolower()
  fields <- str_replace(nodes, '(.*?)(\\s{2,})', '') %>%
    str_trim()
  
  dat <- data.frame(names=category, fields=fields, stringsAsFactors = F)

  merge(allcategory, dat, by = "names", all=T) %>%
    arrange(names) %$%
    return(fields)
}

fields <- data.frame(category = character(0),
                     manufacturer = character(0),
                     caliber = character(0),
                     action = character(0),
                     type = character(0),
                     stringsAsFactors = F)


for (i in (index):(index+99)) {
  fields[i,] <- getFields(df$Url[i])
  print(i)
  if (i %% 1000 == 0) {
    save(fields, file = paste0("fields-", index, ".RData"))
  }
}

write.csv(fields, file = paste0("fields-", index, ".csv"), row.names = F)


