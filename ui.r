# Library for required packages and source for required files
source("./scripts/drawGraph.r")

# Countries HoverInfo https://gallery.shinyapps.io/093-plot-interaction-basic/
# Creates tab at the top of the page and a widget for the map that allows the
# user to pick a year or hit play and watch as the graph changes from 1980-2013
shinyUI(
  navbarPage(
    "MigrantMapper by Digital Deliquents",
    inverse = TRUE,
    tabPanel('Overview',
             sidebarLayout(
               position = "right",
               sidebarPanel(
                 sliderInput(inputId="mapYear",
                             "Year", 
                             min=1980, 
                             max=2013,
                             value = 1980,
                             animate=TRUE,
                             sep=""
                             
                 )
               ),
               # Introduces the map and the issue of immigration to the reader
               mainPanel(
                 h3("General Information about Immigration in USA", 
                    align = "center"),
                 br(),
                 p("Immigration has become a hot button issue in the United 
                    States. Using data from the United Nations Population 
                    Division of the Department of Economic and Social 
                    Affairs (DESA), we've attempted to chart global migration 
                    patterns to show the realistic scale and trends of 
                    worldwide immigration. We hope that by showing the 
                    realities of immigration we may challenge preconceived
                    notions about the issue."), 
                 br(),
                 plotlyOutput("map"),
                 br(),
                 
                 # Description of the way the map works 
                 # Explains hover function and different colors
                 p("The map above is essentially a heat map for immigration.  
                    Each country is filled in a different shade to 
                    signify the number of immigrants from that country. 
                    The countries colored in dark have a large number of 
                    immigrants coming to the United States, while lighter 
                    colors mean fewer immigrants. Hovering over a country 
                    will display the number of immigrants from that country."),
                 br(),
                 br(),
                 br()
               )
             )
    ),
    # Creates the tab at the top of the page 
    # and a widget to pick the country for the pie chart
    tabPanel("Details",
             sidebarLayout(
               position = "right",
               sidebarPanel(
                 inputId="mapYear", 
                 sliderInput(inputId="pie.country.count",
                             "Countries", 
                             min=1, 
                             max=20,
                             value = 10,
                             animate=TRUE
                 )
               ),
               # Creates a pie chart and describes how the 
               # pie chart works in conjunction with the widget
               mainPanel(
                 plotlyOutput("total.pie.chart"),
                 br(),
                 p("While Mexico is by far the largest contributor to immigrants to the US with more than the 3 next
                   largest contributors it still accounts for a miniscule portion of the total. Only making up
                  20% of all immigrants since 1980, Mexico has seen a disproportionately large response compared
                  to its actual impact. Suprisingly The Philippines is the second largest contributor
                  of immigrants outcompeting more far more populous China, and India."),
                 p("This pie chart displays the portion of immigration for each country.  Using the Countries tool,
                   you can move the slider to decide the number of countries to display the immigration statistics. 
                   Leaving the slider at one will display Mexico's immigration statistics and compare it to all the other
                   countries combined. Each time the slider is moved, the country with the next highest amount of 
                   immigration will be displayed on the pie chart.")
               )
             ),
             # Widget that allows the user to pick a country to display data
             tabsetPanel(
               sidebarLayout(
                 position = "right",
                 sidebarPanel(
                   selectInput("text",
                               label = "Country",
                               choices = birthplaces$OdName,
                              selected="Total"
                   )
                 ),
                 # Creates a bubble chart of immigration to certain country 
                 # (based on country selected by widget)
                 mainPanel(
                   h3("Immigrants from a specific country"),
                   p(textOutput("countryInfo")),
                   br(),
                   plotlyOutput("searchCountry"),
                   br(),
                   span("Interesting events:"),
                   br(),
                   span("Peak of FARC power in Columbia in the 2000's."),
                   br(),
                    span("Collapse of the Soviet Union in 1991: Estonia, Unknown, Poland, Latvia"),
                   br(),
                   span("Tiananmen Square 1989: Hong Kong"),
                   br(),
                   span("Immigration Act of 1990: Total, El Salvador, Mexico, Guatamala, Unknown"),
                   br(),
                   span("1997-1999 Immigration Dip: England, Canada, Australia, France, Germany"),
                   br(),
                   span("US withdrawl from Iraq and Arab Spring 2011: Iraq, Syria"),
                   hr()
                 )
               )
             )
    ),
    # Creates a tab at the top of the page and a widget to select a country
    # Widget traces the selected country's data along the original graph
    tabPanel("Plot",
             sidebarLayout(
               position = "right",
               sidebarPanel(
                 inputId="sumChartPanel", 
                 selectInput(
                   inputId = "countrySumSelectedCountry",
                   label = h3("Country"),
                   choices = c("None", getCountriesWithoutTotals()),
                   selected = 1
                 ),
                 p("Selecting a country will display a trace 
                   of the number of immigrants from that country.")
               )
               ,
               # Creates the stacked bar chart and describes the bar chart
               mainPanel(
                         plotlyOutput("countrySumChart"),
                         br(),
                         p("This bar chart displays the total yearly 
                            immigration into the United States. Each color is 
                            for a different region of the world (for example, 
                            purple = Central America). When hovering over a 
                            bar, the statistics for that region will be 
                            displayed for that year. Most regions have a steady
                            flow of immigration, but Central America has 
                            major changes from year to year."),
                         br(),
                         p("In the late 80's and early 90's changes to US immigration policy through the American Homecoming Act
                           and Immigration Act of 1990 saw a surge in immigrants from Vietnam and Central America.
                           The Immigration Act of 1990 expanded immigration quotas, increased visa accessability, removed restrictions
                            on homosexual immigrants, created family reunifaction visas, streamlined refugee visas,
                           and created the diversity visas program. This led to a tremendous surge in immigrants from 
                           Central America using the new family visas. El Salvador produced an especially large
                           number of immigrants fleeing natural disasters with the expanded access to family reunification visas."),
                         br(),
                         br()
               )
             )
    ),
    # Creates a tab at the top of the page 
    # Conclusion of the project
    tabPanel("About",
             mainPanel(
               h1("Project Description"),
               hr(),
               h3("Why does immigration matter?"),
               br(),
               p("The data throughout this website comes from", tags$a(href="http://www.un.org/en/development/desa/population/migration/data/empirical2/migrationflows.shtml", "UN Immigration Data"),
                 ". Migration statistics are important for the design of sensible migration policies, as immigrants are influential to the social stability and economic development of the United States.
                 Comparing the number of immigrants flowing into US and economic gain sheds light on the issue, and whether immigration has a positive or negative impact to this country."),
               p("http://ir.lawnet.fordham.edu/cgi/viewcontent.cgi?article=1270&context=ilj
                https://www.wcl.american.edu/hrbrief/v6i3/immigration.htm
                  http://immigrationtounitedstates.org/337-amerasian-homecoming-act-of-1987.html
                 http://www.fairus.org/facts/us_laws
                 http://www.migrationpolicy.org/article/salvadoran-immigrants-united-states"),
               hr(),
               h3("Developers"),
               p("Xiuxing Lao"),
               p("Leon Tan"),
               p("Shiwen Zhu"),
               p("Ben Kelleran")
             ),
             
             fluidRow(
               img(src="http://nebula.wsimg.com/28e334a7d5626b9fe824f3b720ebf58f?AccessKeyId=D2AC8955135E87ED9D4F&disposition=0&alloworigin=1", width = "250px")
             )
    )
  )
)


