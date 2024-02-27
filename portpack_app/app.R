library(shiny)
library(shinyMobile)
library(ggplot2)
library(dplyr)

load("C:/Users/Caitlin.Eger/OneDrive - RTR Technologies, LLC/Documents/portpack/data/current_port_status.rda")
port <- port_status %>% select(port_number) %>% unique() %>% unlist() %>% unname()
mod <- port_status %>% select(modality) %>% unique() %>% unlist() %>% unname()
ln_typ <- port_status %>% select(lane_type) %>% unique() %>% unlist() %>% unname()


# Define UI ----
ui <- fluidPage(

  # App title ----
  titlePanel("Border Wait times"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      selectizeInput(
        inputId = "port",
        label = "Port ID",
        multiple = FALSE,
        choices = port,
        options = list(create = FALSE,
                       placeholder = "Search Port ID",
                       maxItems = '1',
                       onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
                       onType = I("function (str) {if (str === \"\") {this.close();}}")

        )
      ),
      selectInput(
        inputId = "mod",
        label = "Crossing modality:",
        choices = mod,
        selected = "passenger"
      ),
      selectInput(
        inputId = "ln_typ",
        label = "Lane type:",
        choices = ln_typ,
        selected = "ready"
      )
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Formatted text for caption ----
      plotOutput(outputId = "main_plot", height = "300px"),

    )
  )
)

server <- function(input, output) {
  output$main_plot <- renderPlot({
    delay.min <- port_status %>% filter(port_number == input$port & modality == input$mod & lane_type == input$ln_typ) %>% drop_na() %>% select(delay_minutes) %>% unlist()
    hist(
      port_status$delay_minutes,
      probability = TRUE,
      breaks = as.numeric(25),
      xlab = "Wait time distribution in minutes",
      main = "Border Wait times at all ports"
    )
    abline(v = delay.min, col = "red")

    # if (input$individual_obs) {
    #   rug(faithful$eruptions)
    # }
    #
    # if (input$density) {
    #   dens <- density(faithful$eruptions,
    #                   adjust = input$bw_adjust)
    #   lines(dens, col = "blue")
    # }

  })
}

shinyApp(ui, server)
