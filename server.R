server <- function(input,output,session){
  
  filtered_df <- reactive({
    if (input$variable=="all"){
      res <- data3
    }
    else{
      res <- data3[data3$RegistrationMethod == input$variable, ]
    }
    if (input$attedance_time=="all"){
      res <- res
    }
    else{
      res <- res[res$AttendanceState == input$attedance_time, ]
      
    }
    res
  })
  
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
  
  output$word_cloud_companies <-renderPlot({
    
    if(input$attedance == "both"){
      tempCompanies <- as.data.frame(xtabs(~ CompanyClass , data =data3))
    }else{
      tempCompanies <- as.data.frame(xtabs(~ CompanyClass , data = data3[data3$AttendanceState == input$attedance, ]))
    }
    response <- tempCompanies[tempCompanies$Freq >= input$no_of_companies, ]
    
    
    ggplot(response, 
           aes(
             label = CompanyClass,size = Freq,
             color = factor(sample.int(10, nrow(response), replace = TRUE)),)) +
      geom_text_wordcloud(shape ="circle") +
      theme_minimal()
    
  })
  
  output$word_cloud_job_functions <-renderPlot({
    
    temp <- as.data.frame(xtabs(~ JobFunctionClass , data = data3))
    
    ggplot(temp, 
           aes(
             label = JobFunctionClass,size = Freq,
             color = factor(sample.int(10, nrow(temp), replace = TRUE)),)) +
      geom_text_wordcloud(shape ="circle") + 
      theme_minimal()
    
  })
  
  output$histogram <- renderPlot({
    
    if (input$attedance_job_function=="all"){
      
      filtered_data<-data3
      
    }else{
      
      filtered_data <- data3[data3$AttendanceState == input$attedance_job_function,]
      
    }
    
    ggplot(filtered_data,aes(x=filtered_data[,15])) + 
      geom_bar(color="#86BC25",fill="steelblue") + 
      labs(x = "Job Function") + 
      theme(axis.text.x = element_text(angle=45, hjust = 1))
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
