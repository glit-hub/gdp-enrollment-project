#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(plotly)

fluidPage(
  titlePanel("Country's income on the enrollment rates of men and women around the world from 1999 to 2005"),
  
  # Main Tabset Panel
  tabsetPanel(
    # First tab: Overview
    tabPanel(
      "Overview",
      fluidRow(
        column(
          width = 8,
          tags$h2("What this app answers"),
          tags$p("How does a country’s income (GDP per capita) relate to male vs. female secondary-school enrollment, and how does this differ by world region (1999–2005)?"),
          tags$h3("Why it matters"),
          tags$p("Educational gender parity remains uneven globally. Linking GDP, gender, and enrollment highlights where growth and gaps coexist.")
        ),
        column(
          width = 4,
          tags$h3("At a glance"),
          tags$ul(
            tags$li("Scope: 1999–2005; global coverage by country & region"),
            tags$li("Data: World Bank GDP, UN GenderStats, US Census IDB, Kaggle region map"),
            tags$li("Methods: cleaning, joins, regional aggregation, time-series viz"),
            tags$li("Tech: R, Shiny, dplyr, ggplot2, plotly")
          )
        )
      )
    ),
    # Second tab: Findings and caveats
    tabPanel(
      "Findings",
      fluidRow(
        column(
          width = 8,
          tags$h2("Key Takeaways (1999–2005)"),
          tags$ul(
            tags$li(HTML("<b>GDP and enrollment move together overall</b>, but gender gaps persist and vary by region.")),
            tags$li(HTML("<b>Sub-Saharan Africa’s enrollment grew the fastest (~50%)</b> despite having the lowest average GDP per capita.")),
            tags$li(HTML("<b>Europe & Central Asia showed slight declines</b> in enrollment despite higher GDP.")),
            tags$li(HTML("<b>After 2003, low-income males surpassed high-income males</b> in average enrollment; high-income females stayed ahead of low-income females."))
          ),
          tags$h3("How to read this"),
          tags$ul(
            tags$li("Growth charts standardize to each region/gender’s first year."),
            tags$li("Map ratios near 1 indicate parity; blue > more males, red > more females.")
          ),
          tags$h3("Caveats"),
          tags$ul(
            tags$li("Enrollment counts are influenced by population size; growth % mitigates this."),
            tags$li("Missing values were carried forward/backward within 1999–2005 windows."),
            tags$li("GDP is in current USD; regional averages mask within-region dispersion.")
          )
        ),
        column(
          width = 4,
          tags$h3("Jump to charts"),
          tags$p(HTML("• <a href='#' onclick=\"$('#plotChoice').val('gdp').trigger('change')\">GDP by Region</a>")),
          tags$p(HTML("• <a href='#' onclick=\"$('#plotChoice').val('growth').trigger('change'); $('#demoChoice').val('reg').trigger('change')\">Enrollment Growth by Region</a>")),
          tags$p(HTML("• <a href='#' onclick=\"$('#plotChoice').val('growth').trigger('change'); $('#demoChoice').val('gender').trigger('change')\">Enrollment Growth by Gender</a>")),
          tags$p(HTML("• <a href='#' onclick=\"$('a:contains(\\'Geospatial Map\\')').click()\">Geospatial Maps</a>")),
          tags$hr()
        )
      )
    ),
    # Third Tab: Plots
    tabPanel(
      "Plots",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "plotChoice",
            "Choose a Plot",
            choices = c("GDP" = "gdp", "Growth" = "growth", "Gender" = "gender")
          ), 
          conditionalPanel(
            condition = "input.plotChoice === 'growth'",
            selectInput(
              "demoChoice",
              "Group by Region or Gender?",
              choices = c("Region" = "reg", "Gender" = "gender")
            )
          ), 
          conditionalPanel(
            condition = "input.plotChoice == 'gdp'",
            checkboxGroupInput(
              "selectRegions",
              "Select Region(s): ",
              choices = c(
                "East Asia & Pacific", "Europe & Central Asia", 
                "Latin America & Caribbean", "Middle East & North Africa", 
                "North America", "South Asia", "Sub-Saharan Africa"
              ),
              selected = c("East Asia & Pacific", "Europe & Central Asia", 
                           "Latin America & Caribbean", "Middle East & North Africa", 
                           "North America", "South Asia", "Sub-Saharan Africa")
            ),
            sliderInput(
              "yearRange",
              "Select Year Range",
              min = 1999, max = 2005, value = c(1999, 2005), step = 1, sep = ""
            )
          ),
          conditionalPanel(
            condition = "input.plotChoice == 'gender'",
            checkboxGroupInput(
              inputId = "plotType",
              label = "Choose Plot Type",
              choices = c("Bar", "Line"),
              selected = "Bar",
              
            ),
          ),
          tags$hr(),
          tags$div(
            tags$strong("Warning:"),
            tags$p("Plots may take some time to populate"))

        ),
        mainPanel(
          plotOutput("chosenPlot", height = "1200px", width = "95%")
        )
      )
    ),
    # Fourth Tab: Map
    tabPanel(
      "Geospatial Map",
      sidebarLayout(
        sidebarPanel(
          selectInput("mapProjection",
                      "Select Projection",
                      choices = c("Map" = "map", "Globe" = "globe"),
                      selected = "map"),
          h3("Trends Overview"),
          p("This map visualizes the average male-to-female ratio of enrollment across countries and regions from 1999 to 2005."),
          p("Countries with no data are shown in gray, while those with available data are color-coded based on the ratio."),
          p("Ratios closer to 1 indicate parity in enrollment between males and females, while values above or below 1 indicate disparities."),
          p("For the enrollment map, countries appearing more white indicate relatively 
            equal enrollment ratios between males and females while blue indicates greater male ratio and red/pink indicate greater female ratio."),
          p("Overall, there seems to be a correlation between the average male-to-female enrollment in education and the average GDP per capita
            from 1999-2005 as countries with very low GDP per capita tend to have a very high male-to-female ratio meaning that there is a much greater
            proportion of boys in education compared to girls. It can also be seen vice versa where high income countries have enrollment ratios close to one."),
          p("Furthermore, what is an even greater observation from the geospatial visualizations is that regions also share a trend. For example,
            Africa and the Middle East tend to have lower GDP per capita and also more unequal gender enrollment compared to other parts of the world
            especially North America and Europe."),
          tags$hr(),
          tags$div(
            tags$strong("Warning:"),
            tags$p("Plots may take some time to populate"))
        ),
        mainPanel(
          fluidRow(
            h3("Enrollment Ratio")
          ),
          fluidRow(
            plotlyOutput("enrollmentMap", height = "500px")
          ),
          fluidRow(
            h3("GDP Per Capita")
          ),
          fluidRow(
            plotlyOutput("gdpMap", height = "500px")
          )
        )
      )
    ),
    # Fifth Tab: Data Tables
    tabPanel(
      "Datasets",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "dataChoice",
            "Choose a Dataset:",
            choices = c(
              "GDP Data" = "gdp", 
              "Demographic Data" = "demog", 
              "Demographic Data (With Region)" = "demog_region",
              "Mapping Data" = "map_data"
            )
          ),
          tags$hr(),
          tags$div(
            tags$strong("Warning:"),
            tags$p("Datasets may take some time to populate"))
        ),
        mainPanel(
          dataTableOutput("chosenTable")
        )
      )
    )
  )
)
