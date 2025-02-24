
library(googlesheets4)
library(timevis)
library(htmlwidgets)
library(webshot2)
library(tidyverse)
library(dplyr)

options(chromote.port = 9221)

# gs4_auth(path = "my-project-451804-f2c8ebde5fb1.json")
gs4_auth(path = Sys.getenv("GOOGLE_SHEET_CREDENTIALS"))

# Replace with your Google Sheet URL or Sheet ID
sheet_url <- "https://docs.google.com/spreadsheets/d/19SGRA-yeXmTxM-G24HiyQBAoXyvWJtzQyqeaI-i1C3M/edit?gid=0#gid=0"


# Read the entire sheet
df <- read_sheet(sheet_url)


groups <- df |> select(group,groups) |>  arrange(group) |> group_by(group) |> slice_head(n=1) |> ungroup() |> 
  mutate(content =if_else(!groups %in% c('Semi','final'), paste('Group', if_else(group==1,'A','B')), groups),
         id=row_number()
         ) |> select(-groups) 

# View data
# head(df)

tv <- timevis(df,width = "100%",
              options = list(
                format = htmlwidgets::JS("{ minorLabels: { minute: 'h:mma', hour: 'ha' }}")
              ),
              groups = groups
              )


# Save the output as an HTML file
saveWidget(tv, "timeline.html", selfcontained = TRUE)

# Take a screenshot and save as an image
webshot("timeline.html", file = "timeline.png", cliprect = "viewport",vwidth = 1300, vheight = 1400)

