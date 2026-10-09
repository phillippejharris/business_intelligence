library(shiny)
library(bslib)
library(DBI)
library(RSQLite)
library(ellmer)
library(querychat)

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat::querychat(
  con, "listings",
  client           = client,
  tools            = c("filter", "query", "visualize"),
  greeting         = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

# Render UI using querychat's native ui layout while setting title & theme
ui = qc$ui(
  title = "Midwest Airbnb Explorer",
  theme = bs_theme(bootswatch = "cerulean")
)

server = function(input, output, session) {
  qc$server()
}

options(
  shiny.host = "0.0.0.0", 
  shiny.port = as.integer(Sys.getenv("PORT", "7860"))
)

shinyApp(ui, server)