# Load all the packages we want!
library(shinydashboard)
library(shinydashboardPlus)
library(shiny)
library(shinythemes)
library(shinyBS)
library(anytime)
library(DT)
library(leaflet)
library(ggplot2)
library(ggwordcloud)
library(plotly)
library(readxl)
library(tidyr)
library(dplyr)

# Source additional configuration files and helper functions
source("config.R")
source("helpers.R")

covid_dataset <- get_dataset()

port <- Sys.getenv('PORT')

shiny::runApp(appDir = getwd(),
              host = '0.0.0.0',
              port = as.numeric(port))