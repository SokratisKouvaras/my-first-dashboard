ui <-  function(input,output,session){dashboardPagePlus  (
  skin = "red",
  header = dashboardHeaderPlus(title = 'My first Dashboard'),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem("Tab 1", tabName = "dashboard", icon = icon("home")),
      menuItem("Tab 2", tabName = "dataset", icon = icon("table")),
      menuItem("Tab 3", tabName = "visuals", icon = icon("area-chart"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                
                boxPlus(
                  width = 12,
                  closable = FALSE,
                  collapsible = TRUE,
                  title = textOutput("org_name",inline=TRUE),
                  status = "warning",
                  
                  appButton(
                    inputId = "USD",
                    label = "KPI 1", 
                    icon = icon("registered"), 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    dashboardBadge(textOutput("no_of_participants",inline=TRUE), color = "orange")
                  ),
                  appButton(
                    inputId = "USD0",
                    label = "KPI 2", 
                    icon = icon("users"), 
                    enable_badge = TRUE, 
                    badgeColor = "red",
                    dashboardBadge("630", color = "orange")
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
                  width = 12,
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
                  ),
                  socialButton(
                    url = "https://github.com/SokratisKouvaras",
                    type = "github"
                  )
                ),
              )
      ),
      tabItem(tabName = "dataset",
              DT::dataTableOutput("table")
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
