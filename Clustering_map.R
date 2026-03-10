library(shiny)
library(plotly)
library(dplyr)

# data: food_umap3_df with columns U1, U2, U3, cluster, food_name, img_file
# img_file values like "FoodItems/85.jpg" (relative to www/)

food_umap3_df <- readRDS("food_umap3_df.rds")



library(shiny)
library(plotly)

ui <- fluidPage(
  tags$head(
    tags$head(
      tags$style(HTML("
/* ===== Global layout & base font ===== */
body {
  background: #f5f6fb;
  font-size: 17px;
}

.app-container {
  max-width: 750px;
  margin: 0 auto;
  padding: 24px 20px 40px;
}

/* ===== Title & subtitle ===== */
#app-title {
  font-weight: 800;
  letter-spacing: .2px;
  line-height: 1.15;
  color: #6488ea;
  text-align: center;
  margin: 10px 0 4px;
  font-size: 2.8 rem;
}

.app-subtitle {
  text-align: center;
  font-size: 1.6rem;
  color: #555a6b;
  margin-bottom: 24px;
  margin-top: 12px;
}

/* ===== Cards ===== */
.card {
  background: #fff !important;
  border: none !important;
  border-radius: 14px;
  box-shadow: 0 8px 20px rgba(100,136,234,.15);
  padding: 10px 10px 8px 10px;   /* smaller left/right padding for the plot */
}

/* right column panel */
.side-panel {
  min-height: 220px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
}

/* 'Hovered food' title */
.side-panel h3 {
  font-weight: 700 !important;
  font-size: 1.6rem;
  margin-bottom: 10px;
  color: #28282d;
}

/* ===== Footer tip ===== */
.footer-note {
  margin-top: 18px;
  font-size: 1.6rem;
  color: #777c8c;
  text-align: center;
}

/* ===== Mascot ===== */
.mascot-wrapper {
  margin-top: 32px;          /* pushes mascot further down */
  text-align: left;          /* align contents to the left */
  padding-left: 20px;
  margin-righ: 20px; 
}

.mascot-img {
  max-width: 200px;
  opacity: 0.90;
  display: block;
  margin-left: 0;
  margin-right: 50px;        /* keeps it left-aligned */
}
"))
    )
  ),
  
  div(class = "app-container",
      h1(id = "app-title", "Food Preference Clustering (UMAP/HDBSCAN)"),
      div(class = "app-subtitle",
          "Hover a point to see the corresponding food image."
      ),
      
      fluidRow(
        column(
          width = 8,
          div(class = "card",
              plotlyOutput("p3d", height = "520px")
          )
        ),
        column(
          width = 4,
          # hovered food panel
          div(class = "card side-panel",
              h3("Food item"),
              uiOutput("food_image")
          ),
          # FIXED mascot under the panel
          div(class = "mascot-wrapper",
              tags$img(
                src = "MascotFront.png", 
                class = "mascot-img"
              )
          )
        )
      ),
      
      div(class = "footer-note",
          "Tip: drag to rotate, scroll to zoom."
      )
  )
)




server <- function(input, output, session) {
  
  output$p3d <- renderPlotly({
    plot_ly(
      food_umap3_df,
      x = ~U1, y = ~U2, z = ~U3,
      color = ~cluster, colors = "Set2",
      type = "scatter3d", mode = "markers",
      marker = list(size = 6, opacity = 0.85),
      key = ~img_path,          # store image path in key
      source = "foods"
    ) %>%
      layout(
        scene = list(
          xaxis = list(title = "UMAP 1"),
          yaxis = list(title = "UMAP 2"),
          zaxis = list(title = "UMAP 3")
        )
      )
  })
  
  output$food_image <- renderUI({
    d <- event_data("plotly_hover", source = "foods")
    if (is.null(d)) return(NULL)
    
    # d$key is the img_file we stored
    tags$img(src = d$key[1], width = 130, height = 130)
  })
}

shinyApp(ui, server)
