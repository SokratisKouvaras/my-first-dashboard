server <- function(input,output,session){
  
  # Dataset table --------------------------------------------------------------
  output$table <- DT::renderDataTable({
    tryCatch({
      covid_dataset %>%
        prepare_table() %>%
        create_datatable(CONFIG_TABLE_OPTIONS)
    },
    error=function(err) {
      warning(paste('output$table throws the following error: ',geterrmessage()))
      column_names <- c(
        'Date',
        'Province',
        'Region',
        'Age Group',
        'Sex',
        'Cases'
      )
      create_empty_dataframe(column_names) %>%
        create_datatable(CONFIG_TABLE_OPTIONS)
    }
    )
    
  })
  
  # Test ----------------------------------------------
  output$time_series <- renderPlotly({
    covid_dataset %>%
      create_animated()
  })
  
  # Total number of cases KPI box ----------------------------------------------
  output$total_number_of_cases <- renderInfoBox({
      infoBox(
      title = "Total no of cases",
      value = sum(covid_dataset$CASES)
    )
    })
  
  # Total number of cases Text output ------------------------------------------
  output$total_number_of_cases <- renderText({
    sum(covid_dataset$CASES)
  })
  
  # Number of female cases KPI box ----------------------------------------------
  output$total_number_of_cases_infobox <- renderInfoBox({
    infoBox(
      title = "Total no of cases",
      value = sum(covid_dataset$CASES)
    )
  })
  
  # Number of female cases Text output ------------------------------------------
  output$total_number_of_female_cases <- renderText({
    covid_dataset %>%
      filter(SEX=='F') %>%
      pull(CASES) %>%
      sum()
  })
  
  # Plotly Region bar chart ----------------------------------------------------
  output$region_bar_plot <- renderPlotly({
    covid_dataset %>%
      prepare_barplot('REGION') %>%
      create_region_barplot()
  })
    
  # Plotly Province bar chart --------------------------------------------------
  output$province_bar_plot <- renderPlotly({
    covid_dataset %>%
      prepare_barplot('PROVINCE') %>%
      create_province_barplot()
  })
  
  # Plotly Timeline line chart -------------------------------------------------
  output$timeline_plot <- renderPlotly({
    req(input$grouping)
    if(input$grouping=="total"){
    covid_dataset %>%
      prepare_total_timeline_plot () %>%
      create_total_timeline_histogram()
    }else if(input$grouping=="region") {
      covid_dataset %>%
        prepare_region_timeline_plot() %>%
        create_region_timeline_histogram()
    }else if(input$grouping=="province") {
      covid_dataset %>%
        prepare_province_timeline_plot() %>%
        create_province_timeline_histogram()
    }else if(input$grouping=="agegroup") {
      covid_dataset %>%
        prepare_agegroup_timeline_plot() %>%
        create_agegroup_timeline_histogram()
    }else if(input$grouping=="sex") {
      covid_dataset %>%
        prepare_sex_timeline_plot() %>%
        create_sex_timeline_histogram()
    }
    
  })
}
