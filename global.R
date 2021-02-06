# global.R file as a file that is being run once before your app starts.
# That means you can use it for all sorts of data processing, running models, and
# of course, to load in your data.
# Any R objects that are created in the global.R file become available to the
# app.R file, or the ui.R and server.R files.

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
library(dplyr)

# Source additional configuration files and helper functions
source("config.R")
source("helpers.R")

covid_dataset <- get_dataset()