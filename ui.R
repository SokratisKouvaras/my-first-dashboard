ui <-  function(input,output,session){dashboardPagePlus  (
  title = "My first Dashboard",
  skin = "red",
  header = dashboardHeaderPlus(title = 'My first Dashboard'),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem("Test", tabName = "test", icon = icon("home")),
      menuItem("Tab 1", tabName = "dashboard", icon = icon("home")),
      menuItem("Dataset Overview", tabName = "dataset", icon = icon("table")),
      menuItem("Tab 3", tabName = "visuals", icon = icon("area-chart"))
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
                ),
                boxPlus(
                  title = "VIEW 1",
                  plotOutput("word_cloud_companies", height = 250),
                  collapsed = FALSE,
                  status = "warning",
                  closable = FALSE,
                  collapsible = TRUE,
                  width = 6,
                  selectInput("no_of_companies", "Drop-down choices: ",
                              c("Choice 1" = "choice1",
                                "Choice 2" = "choice2",
                                "Choice 3" = "choice3"),
                              selected = "choice1"),
                  selectInput("attedance", "Drop-down choices: ",
                              c("Choice 1" = "choice1",
                                "Choice 2" = "choice2",
                                "Choice 3" = "choice3"),
                              selected = "choice1")
                ),
                boxPlus(
                  title = "VIEW 2",
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
      ),
      tabItem(tabName = "visuals",
              fluidRow(title = "Registration",
                       box(
                         width=12,
                         plotOutput("time_series"),
                         title ="View 1",
                         closable = TRUE,
                         collapsible = TRUE,
                         status = "warning",
                         enable_sidebar = TRUE,
                         sidebar_width = 12,
                         sidebar_start_open = FALSE,
                         selectInput("variable", "Drop-down choices: ",
                                     c("Choice 1" = "choice1",
                                       "Choice 2" = "choice2",
                                       "Choice 3" = "choice3"),
                                     selected = "choice1"),
                         selectInput("attedance_time", "Drop-down choices: ",
                                     c("Choice 1" = "choice1",
                                       "Choice 2" = "choice2",
                                       "Choice 3" = "choice3"),
                                     selected="choice1")
                       )
              ),
              fluidRow(title="Job Function",
                       box(
                         plotOutput("histogram"),
                         width = 12,
                         title = "View 2", 
                         closable = TRUE, 
                         status = "warning", 
                         solidHeader = FALSE, 
                         collapsible = TRUE,
                         enable_sidebar = TRUE,
                         sidebar_width = 12,
                         selectInput("attedance_job_function", "Drop-down choices: ",
                                     c("Choice 1" = "choice1",
                                       "Choice 2" = "choice2",
                                       "Choice 3" = "choice3"),
                                     selected="choice1")
                         
                       )
              )
      )
    )
  )
)
}
