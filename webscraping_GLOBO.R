library("httr")
library("rvest")
library("dplyr")
library("tidyverse")
library("jsonlite")

site <- read_html("https://g1.globo.com/tecnologia/")
urls <- site %>%
        html_nodes(".gui-color-hover") %>% 
        html_attr("href")
urls

urls=urls[!is.na(urls)]
urls

titulos = c()
corpos = c()
datas= c()

for (i in urls){ 
  fonte <- read_html(i)
  titulo <- fonte %>% 
    html_node(".content-head__title") %>%
    html_text()
  
  titulos <- append(titulos, titulo)
  
  fonte <- read_html(i)
  data <- fonte %>% 
    html_node("time") %>%
    html_text()
  
  datas <- append(datas, data)
  
  
  fonte <- read_html(i)
  corpo <- fonte %>% 
    html_nodes("article") %>%
    html_text()
  
  corpo_unico <- paste (corpo, collapse = "  ")
  corpos <- append(corpos, corpo_unico)
  
}
corpo_unico
base = data.frame(urls,datas,titulos,corpos)

