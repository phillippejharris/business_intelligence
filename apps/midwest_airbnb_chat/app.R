library(shiny)
library(bslib)
library(DBI)
library(RSQLite)
library(ellmer)
library(querychat)

# 1. Database Connection
con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

# 2. LLM Client
client = ellmer::chat_openai(
  model = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

# 3. Querychat Instance
qc = querychat::querychat(
  con, "listings",
  client             = client,
  tools              = c("filter", "query", "visualize"),
  greeting           = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description   = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

# 4. Custom UI using qc$ui() wrapped in bslib theme & title
ui = page_fillable(
  title = "Midwest Airbnb Explorer",
  theme = bs_theme(bootswatch = "cerulean"),
  div(
    style = "padding: 10px 15px; background-color: #2c3e50; color: white; font-weight: bold; font-size: 1.2rem;",
    "Midwest Airbnb Explorer"
  ),
  div(
    style = "padding: 10px 15px; background-color: #ecf0f1; border-bottom: 1px solid #bdc3c7;",
    p(style = "margin: 0; color: #34495e;", "About: Query 14,887 Airbnb listings across Chicago, Columbus, and the Twin Cities.")
  ),
  div(
    style = "flex-grow: 1; height: calc(100vh - 110px);",
    qc$ui()
  )
)

server = function(input, output, session) {
  qc$server()
}

options(
  shiny.host = "0.0.0.0", 
  shiny.port = as.integer(Sys.getenv("PORT", "7860"))
)

shinyApp(ui, server)