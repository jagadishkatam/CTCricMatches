
library(googlesheets4)
library(timevis)
library(htmlwidgets)

# Replace with your Google Sheet URL or Sheet ID
sheet_url <- "https://docs.google.com/spreadsheets/d/19SGRA-yeXmTxM-G24HiyQBAoXyvWJtzQyqeaI-i1C3M/edit?gid=0#gid=0"

# Read the entire sheet
df <- read_sheet(sheet_url)

# View data
# head(df)

tv <- timevis(df,width = "100%",
              options = list(
                format = htmlwidgets::JS("{ minorLabels: { minute: 'h:mma', hour: 'ha' }}")
              ))


# Save the output as an HTML file
saveWidget(tv, "timeline.html", selfcontained = TRUE)
