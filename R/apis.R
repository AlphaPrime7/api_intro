#Topic: API Introduction
#Reference: DataQuest

#packages needed
api_list <- c("httr","jsonlite")
for(i in api_list){
  if(!(i %in% installed.packages())){
    install.packages(i)
  }
}

#call the packages
library(httr)
library(jsonlite)

rapidapi_signup <- function(url="https://rapidapi.com/auth/sign-up"){
  library(devtools)
  browseURL(url)
  usethis::edit_r_environ() #help you make an renviron file for storing the API key
}

#SEASONS
url <- "https://api-nba-v1.p.rapidapi.com/seasons"
renv_key <- Sys.getenv('RAPID_API')
host <- 'api-nba-v1.p.rapidapi.com' #host stays the same

rapidapi_response <- function(url,host, renv_key){
  library(httr)
  library(jsonlite)
  res <- GET(url,add_headers(`x-rapidapi-host`= host,`x-rapidapi-key`= renv_key),
             content_type("application/octet-stream"))
  response_data <-fromJSON(rawToChar(res$content))
  response_data <- as.data.frame(response_data$response)
  return(response_data)
}

seasons <- rapidapi_response(url,host,renv_key)

#STANDINGS 2022
url <- "https://api-nba-v1.p.rapidapi.com/standings" #changes

#query string changes
queryString <- list(
  league = "standard",
  season = "2022"
)

rapidapi_respquerry <- function(url,host, queryString = NULL, renv_key){
  library(httr)
  library(jsonlite)
  response <- VERB("GET", url, query = queryString, 
                    add_headers(`x-rapidapi-key` = renv_key, 
                    `x-rapidapi-host` = host), 
                    content_type("application/octet-stream"))
  response_data <-fromJSON(rawToChar(response$content))
  response_data <- as.data.frame(response_data$response)
  return(response_data)
}

standings <- rapidapi_respquerry(url,host,queryString = queryString,renv_key)
