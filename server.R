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
  
  output$time_series <- renderPlot({
    ggplot(filtered_df(),aes(x=filtered_df()[,8],color=data3$AttendanceState)) + 
      geom_bar(color="#86BC25",fill="steelblue") + 
      theme(axis.text.x = element_text(angle=45, hjust = 1)) + 
      labs(x = "Registration Day") + 
      scale_x_date(date_labels = "%d-%m-%Y",breaks='7 days')
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
  
  # Plotly bar chart
  output$region_bar_plot <- renderPlotly({
    covid_dataset %>%
      prepare_barplot('REGION') %>%
      create_region_barplot()
  })
    
  # Plotly bar chart
  output$province_bar_plot <- renderPlotly({
    covid_dataset %>%
      prepare_barplot('PROVINCE') %>%
      create_province_barplot()
  })
  
  # Plotly bar chart
  output$timeline_plot <- renderPlotly({
    covid_dataset %>%
      #prepare_barplot('PROVINCE') %>%
      create_timeline_histogram()
  })
}
