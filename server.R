server <- function(input,output,session){
  
  # Dataset table --------------------------------------------------------------
  output$table <- DT::renderDataTable({
    tryCatch({
      covid_dataset %>%
        prepare_table() %>%
        create_datatable(CONFIG.TABLE_OPTIONS)
    },
    error=function(err) {
      warning(paste('output$table throws the following error: ',geterrmessage()))
      create_empty_dataframe(CONFIG.TABLE_COLUMN_NAMES) %>%
        create_datatable(CONFIG_TABLE_OPTIONS)
    }
    )
  })
  
  # Total number of cases Text output ------------------------------------------
  output$total_number_of_cases <- renderText({
    sum(covid_dataset$CASES)
  })
  
  # Total cases of men ---------------------------------------------------------
  output$no_of_men_cases <- renderText({
    covid_dataset %>%
      filter(SEX=='M') %>%
      pull(CASES) %>%
      sum() %>%
      as.character()
  })
  
  
  # Total cases of women  ------------------------------------------------------
  output$no_of_women_cases <- renderText({
    covid_dataset %>%
      filter(SEX=='F') %>%
      pull(CASES) %>%
      sum() %>%
      as.character()
  })
  
  # Last date of dataset update ------------------------------------------------
  output$max_date <- renderText({
    covid_dataset %>%
      filter(!(is.na(DATE))) %>%
      pull(DATE) %>%
      max() %>%
      as.character()
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
  
  # Plotly heatmap chart -------------------------------------------------
  output$heatmap_per_agegroup <- renderPlotly({
    covid_dataset %>%
      group_by(AGEGROUP,SEX) %>%
      summarise(CASES=sum(CASES)) %>%
      plot_ly(x=~AGEGROUP,y=~SEX,z=~CASES,type="heatmap")%>%
      config(displayModeBar = FALSE)
  })
  
  # Plotly heatmap chart per region -------------------------------------------------
  output$heatmap_per_region <- renderPlotly({
    covid_dataset %>%
      group_by(REGION,PROVINCE) %>%
      summarise(CASES=sum(CASES)) %>%
      plot_ly(x=~REGION,y=~PROVINCE,z=~CASES,type="heatmap")%>%
      layout(
        xaxis=list(
          categoryorder = "array",
          categoryarray = CONFIG.X_AXIS
        ),
        yaxis=list(
          categoryorder = "array",
          categoryarray = CONFIG.Y_AXIS
        )
      ) %>%
      config(displayModeBar = FALSE)
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
        prepare_grouped_timeline_plot('REGION') %>%
        create_region_timeline_histogram()
    }else if(input$grouping=="province") {
      covid_dataset %>%
        prepare_grouped_timeline_plot('PROVINCE') %>%
        create_province_timeline_histogram()
    }else if(input$grouping=="agegroup") {
      covid_dataset %>%
        prepare_grouped_timeline_plot('AGEGROUP') %>%
        create_agegroup_timeline_histogram()
    }else if(input$grouping=="sex") {
      covid_dataset %>%
        prepare_grouped_timeline_plot('SEX') %>%
        create_sex_timeline_histogram()
    }
    
  })
}
