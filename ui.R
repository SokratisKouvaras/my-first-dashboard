ui <-  function(input,output,session){dashboardPagePlus  (
  title = "My first Dashboard",
  skin = "red",
  header = dashboardHeaderPlus(title = 'My first Dashboard'),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem("Covid-19 Dashboard", tabName = "dashboard", icon = icon("home")),
      menuItem("Dataset Overview", tabName = "dataset", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = 'test',
              column(width = 12,
              fluidRow(infoBoxOutput('total_number_of_cases_infobox',width = 3))
              )
              ),
      tabItem(tabName = "dashboard",
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
                    label = "KPI 2", 
                    icon = icon("users"), 
                    enable_badge = TRUE, 
                    badgeColor = "red",
                    dashboardBadge(textOutput("total_number_of_female_cases",inline=TRUE), color = "orange")
                  ),
                  
                  appButton(
                    inputId = "USD1",
                    label = "KPI 3",
                    url = "",
                    icon = icon("home"), 
                    enable_badge = FALSE, 
                    badgeColor = NULL, 
                    badgeLabel = NULL
                  ),
                  appButton(
                    inputId = "USD2",
                    label = "KPI 3", 
                    icon = icon("calendar"), 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    badgeLabel = NULL
                  ),
                  appButton(
                    inputId = "USD2",
                    label = "KPI 4", 
                    icon = icon("calendar"), 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    badgeLabel = NULL
                  ),
                  appButton(
                    inputId = "USD3",
                    label = "KPI 5", 
                    icon = icon("language"), 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    dashboardBadge("2",color="orange")
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
      tabItem(tabName = "dataset",
              dataTableOutput("table")
      )      
    )
  )
)
}
