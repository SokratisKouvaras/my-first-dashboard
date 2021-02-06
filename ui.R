sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Covid-19 Dashboard", 
        tabName = "dashboard", 
        icon = icon("home")
        ),
      menuItem(
        "Dataset Overview", 
        tabName = "dataset", 
        icon = icon("table")
        )
    )
  )

header <- dashboardHeaderPlus(title = 'My first Dashboard')

body <- dashboardBody(
    tabItems(
      tabItem(
        tabName = "dashboard",
            fluidRow(
                boxPlus(
                  width = 12,
                  closable = FALSE,
                  collapsible = TRUE,
                  title = "Basic Metrics",
                  status = "warning",
                  appButton(
                    inputId = "kpi1",
                    label = "Total no of cases", 
                    icon = icon("users"), 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    dashboardBadge(textOutput("total_number_of_cases",inline=TRUE), color = "orange")
                  ),
                  appButton(
                    inputId = "kpi2",
                    label = "Last Updated", 
                    icon = icon("calendar-check"), 
                    enable_badge = TRUE, 
                    badgeColor = "red",
                    dashboardBadge(textOutput("max_date",inline=TRUE), color = "orange")
                  ),
                  
                  appButton(
                    inputId = "kpi3",
                    label = "Total cases of men",
                    icon = icon("male"), 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    dashboardBadge(textOutput("no_of_men_cases",inline=TRUE), color = "orange")
                  ),
                  appButton(
                    inputId = "kpi4",
                    label = "Total cases of women", 
                    icon = icon("female"), 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    dashboardBadge(textOutput("no_of_women_cases",inline=TRUE), color = "orange")
                  )
                )
                ),
              fluidRow(
                boxPlus(
                  title = "Timeline",
                  radioButtons("grouping", "Group by:",
                               c("Total" = "total",
                                 "Region" = "region",
                                 "Province" = "province",
                                 "Age Group" = "agegroup",
                                 "Sex"="sex"),
                               inline = TRUE),
                  plotlyOutput("timeline_plot", height = 250),
                  collapsed = FALSE,
                  status = "warning",
                  closable = FALSE,
                  collapsible = TRUE,
                  width = 12
                  )
                ),
              fluidRow(
                boxPlus(
                  title = "Case distribution between provinces of the same Region",
                  plotlyOutput("heatmap_per_region", height = 250),
                  collapsed = FALSE,
                  status = "warning",
                  closable = FALSE,
                  collapsible = TRUE,
                  width = 12
                )
              ),
              fluidRow(
                boxPlus(
                  title = "Case distribution between sexes per age group",
                  plotlyOutput("heatmap_per_agegroup", height = 250),
                  collapsed = FALSE,
                  status = "warning",
                  closable = FALSE,
                  collapsible = TRUE,
                  width = 12
                )
              ),
              fluidRow(
                boxPlus(
                  title = "Province Overview",
                  plotlyOutput("province_bar_plot", height = 250),
                  collapsed = FALSE,
                  status = "warning",
                  closable = FALSE,
                  collapsible = TRUE,
                  width = 6
                  
                ),
                boxPlus(
                  title = "Region Overview",
                  plotlyOutput("region_bar_plot", height = 250),
                  collapsed = FALSE,
                  status = "warning",
                  closable = FALSE,
                  collapsible = TRUE,
                  width = 6
                  
                )
              ),
              fluidRow(
                boxPlus(
                  collapsed = TRUE,
                  closable = FALSE,
                  collapsible = TRUE,
                  width = 6,
                  height = NULL,
                  title = "About me",
                  status = "warning",
                  socialButton(
                    url = "https://www.linkedin.com/in/sokratis-kouvaras/",
                    type = "linkedin"
                  )
                )
              )
              
      ),
      tabItem(
        tabName = "dataset",
        fluidRow(
          dataTableOutput("table")
        )
      )      
    )
  )
  
ui <-  function(input,output,session){
    dashboardPagePlus(
      title = "My first Dashboard",
      skin = "red",
      header = header,
      sidebar = sidebar,
      body = body)
  }
