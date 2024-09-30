library(rvest)
library(httr)
library(wdman)
library('RSelenium')


url <- "https://www.jobs.ch/de/stellenangebote/?term=data%20scientist"

page <- read_html("https://www.jobs.ch/de/stellenangebote/?term=data%20scientist")
links <- html_attr(html_nodes(page, "a[href]"), "href")


# Filter the links that start with "/de/stellenangebote/detail/"
filtered_links <- grep("^/de/stellenangebote/detail/", links, value = TRUE)

# Print the filtered links
print(filtered_links)

# Extract numbers between detail/ and /?source using regular expression
detail_numbers <- gsub(".*/detail/([a-f0-9-]+?)/\\?source=.*", "\\1", filtered_links)

# Print the extracted numbers
print(detail_numbers)

newUrl <- paste0("https://www.jobs.ch/de/stellenangebote/?term=data%20scientist&jobid=",detail_numbers[2])

newUrl <- "https://www.jobs.ch/de/stellenangebote/?term=data%20scientist&jobid=337300c8-e828-4369-9754-a7a702430783"
jobdetail <- read_html(newUrl)

title <- jobdetail %>% 
  html_nodes(., "h4[data-cy='company-name']") %>% 
  html_text
title

pensum <- jobdetail %>% 
  html_nodes(., "span[class='Span-sc-1ybanni-0 Text__span-sc-1lu7urs-12 Text-sc-1lu7urs-13 VacancyInfo___StyledText-sc-1o72fha-0 ftUOUz iZJSew']") %>% 
  html_text %>% as.numeric
pensum

description_external <- jobdetail %>% 
  html_nodes(".Div-sc-1cpunnt-0.hyUcpI") %>%
  html_text()
description_external

description_internal <- jobdetail %>% 
  html_nodes(., "div[data-cy='vacancy-description']") %>% 
  html_text
description_internal

company <- jobdetail %>%
  html_nodes(., "h4[data-cy='company-name']") %>%
  html_text()
company

test <- jobdetail %>%
  html_nodes("ul.Ul-sc-1n42qu0-0.Ul-sc-1otw97l-0.iyCZQP.kNGQob")
test

test1 <- test %>%
  html_node("li.Li-sc-ennkmk-0.Li-sc-l8g2j9-0.bhfpZz")
test1

test2 <- test1 %>%
  html_node("div.Div-sc-1cpunnt-0.Flex-sc-mjmi48-0.epsord")
company

test3 <- test2 %>%
  html_node("a.Link__ExtendedRR6Link-sc-czsz28-1.koTxGb Link-sc-czsz28-2.bzpUGN")
test3

desired_span <- test %>% html_nodes("span[data-cy='rating-stars']")

# Extract the title attribute from the selected span
title_attribute <- desired_span %>% html_attr("title")

# Print the title attribute
cat(title_attribute)



con <- dbConnect(MySQL(),
                 user = 'root',
                 password = 'Pa$$w0rd',
                 host = 'localhost:3306',
                 dbname = 'final_project'
                 )
