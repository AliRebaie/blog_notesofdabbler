
#
# Work through Hadley Wickham's rvest package code to scrape tripadvisor data
#
#  https://github.com/hadley/rvest/blob/master/demo/tripadvisor.R
#

library(rvest)
library(magrittr)

url <- "http://www.tripadvisor.com/Hotel_Review-g37209-d1762915-Reviews-JW_Marriott_Indianapolis-Indianapolis_Indiana.html"

reviews <- url %>%
  html() %>%
  html_node("#REVIEWS .innerBubble")

id <- reviews %>%
  html_node(".quote a") %>%
  html_attr("id")

quote <- reviews %>%
  html_node(".quote span") %>%
  html_text()

rating <- reviews%>%html_node(".rating .rating_s_fill")%>%html_attr("alt")%>%gsub(" of 5 stars","",.)%>%as.integer()

date <- reviews%>%html_node(".rating .ratingDate")%>%html_attr("title")%>%strptime("%b %d, %Y")%>%as.POSIXct()

review <- reviews %>% html_node(".partial_entry")%>%html_text()

review_alt <- reviews %>% html_node("//p[@class='partial_entry'][1]",xpath=TRUE)%>%html_text()

df=data.frame(id,quote,rating,date,review,stringsAsFactors=FALSE)
