# init.R 

my_packages <- c('shinydashboard',
                 'shinydashboardPlus',
                 'shiny',
                 'shinythemes',
                 'shinyBS',
                 'anytime',
                 'ggwordcloud',
                 'leaflet',
                 'ggplot2',
                 'plotly',
                 'DT')

install_if_missing <- function(package){
  if(package %in% rownames(installed.packages())==FALSE){
    install.packages(package)
  }
}

invisible(sapply(my_packages,install_if_missing))