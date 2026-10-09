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

# 4. UI with bslib theme, title, and querychat layout
ui = page_navbar(
  title = "Midwest Airbnb Explorer",
  theme = bs_theme(bootswatch = "cerulean"),
  nav_panel(
    "Chat",
    layout_sidebar(
      sidebar = sidebar(
        title = "About",
        p("Query 14,887 Airbnb listings across Chicago, Columbus, and the Twin Cities."),
        hr(),
        qc$ui_sql
      ),
      qc$ui_chat
    )
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