# Helper functions -------------------------------------------------------------

get_dataset <- function(){
  temp = tempfile(fileext = ".xlsx")
  download.file(CONFIG.DATASET_URL, destfile=temp, mode='wb')
  dataset <- readxl::read_excel(temp, sheet =1)
  dataset %>%
    tidyr::replace_na(list(PROVINCE="Unknown",
                    REGION="Unknown",
                    AGEGROUP="Unknown",
                    SEX="Unknown")) %>%
    mutate(DATE = as.Date(DATE,"%Y-%m-%d"))
}

prepare_barplot <- function(df,col){
  df %>%
    group_by(!!as.name(col)) %>%
    summarise(CASES = sum(CASES), .groups = 'drop') %>%
    mutate(!!as.name(col) := ifelse(is.na(!!as.name(col)),'Uknown',!!as.name(col))) %>%
    arrange(desc(CASES)) %>%
    ungroup()
}

prepare_total_timeline_plot <- function(df){
  df %>%
    group_by(DATE)%>%
    summarise(CASES=sum(CASES),  .groups = 'drop') %>%
    arrange(DATE) %>%
    ungroup()
}

prepare_grouped_timeline_plot <- function(df,col_name){
  df %>%
    group_by(!!as.name(col_name),DATE) %>%
    summarize(CASES=sum(CASES)) %>%
    ungroup()
}

prepare_table <- function(df){
  df %>%
    rename('Sex'=SEX,
           'Date'=DATE,
           'Province'=PROVINCE,
           'Region'=REGION,
           'Age Group'=AGEGROUP,
           'Cases'=CASES)
}

create_region_barplot <- function(df){
  df %>%
    plot_ly() %>%
    add_trace(type = "bar",
              x = ~REGION,
              y = ~CASES,
              color = ~REGION) %>%
    layout(title = "Number of cases by region",
           xaxis = list(title = "Region",
                        categoryorder = "array",
                        categoryarray = ~REGION,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = TRUE)) %>%
    config(displayModeBar = FALSE)
}

create_province_barplot <- function(df){
  df %>%
    plot_ly() %>%
    add_trace(type = "bar",
              x = ~PROVINCE,
              y = ~CASES) %>%
    layout(title = "Number of cases by province",
           xaxis = list(title = "Province",
                        categoryorder = "array",
                        categoryarray = ~PROVINCE,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = TRUE)) %>%
    config(displayModeBar = FALSE)
}

create_total_timeline_histogram <- function(df){
  df %>%
    plot_ly() %>%
    add_trace(type = 'scatter',
              mode = 'lines',
              x = ~DATE,
              y = ~CASES
              ) %>%
    layout(title = "Daily record of cases",
           hovermode = "x unified",
           xaxis = list(title = "Date",
                        showgrid = F,
                        type = 'date',
                        dtick = 7*86400000.0,
                        zeroline = T),
           yaxis = list(title = "Number of cases",
                        showgrid = T,
                        zeroline = TRUE)) %>%
    config(displayModeBar = FALSE)
  
}

create_region_timeline_histogram <- function(df){
  first_region <- df %>%
    pull(REGION) %>%
    unique()
  first_region <- first_region[1]
  
    plot_ly(
      data = df[which(df$REGION==first_region),],
      type = 'scatter',
      mode='lines',
      x = ~DATE,
      y = ~CASES,
      color= ~REGION
    ) %>%
    add_trace(
      data = df[which(!(df$REGION==first_region)),],
      type = 'scatter',
      mode='lines',
      x = ~DATE,
      y = ~CASES,
      color=~REGION,
      visible = "legendonly"
    ) %>%
    layout(title = "Daily record of cases by Region",
           hovermode = "x unified",
           xaxis = list(title = "Date",
                        showgrid = F,
                        type = 'date',
                        dtick = 7*86400000.0,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = TRUE)) %>%
    config(displayModeBar = FALSE)
  # df %>%
  #   group_by(REGION) %>%
  #   do(p = plot_ly(., x = ~DATE, y = ~CASES)) %>%
  #   subplot(nrows = NROW(.), shareX = TRUE)
}

create_agegroup_timeline_histogram <- function(df){
  first_agegroup <- df %>%
    pull(AGEGROUP) %>%
    unique()
  first_agegroup <- first_agegroup[1]
  
  plot_ly(data = df[which(df$AGEGROUP==first_agegroup),],
          type = 'scatter',
          mode='lines',
          x = ~DATE,
          y = ~CASES,
          color= ~AGEGROUP) %>%
    add_trace(data = df[which(!(df$AGEGROUP==first_agegroup)),],
              type = 'scatter',
              mode='lines',
              x = ~DATE,
              y = ~CASES,
              color=~AGEGROUP,
              visible = "legendonly"
    ) %>%
    layout(title = "Daily record of cases by Age group",
           hovermode = "x unified",
           xaxis = list(title = "Date",
                        showgrid = F,
                        type = 'date',
                        dtick = 7*86400000.0,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = TRUE)) %>%
    config(displayModeBar = FALSE)
}

create_province_timeline_histogram <- function(df){
  first_province <- df %>%
    pull(PROVINCE) %>%
    unique()
  first_province <- first_province[1]

  plot_ly(data = df[which(df$PROVINCE==first_province),],
      type = 'scatter',
            mode='lines',
            x = ~DATE,
            y = ~CASES,
            color= ~PROVINCE) %>%
    add_trace(data = df[which(!(df$PROVINCE==first_province)),],
              type = 'scatter',
              mode='lines',
              x = ~DATE,
              y = ~CASES,
              color=~PROVINCE,
              visible = "legendonly"
     ) %>%
    layout(title = "Daily record of cases by Province",
           hovermode = "x unified",
           xaxis = list(title = "Date",
                        showgrid = F,
                        type = 'date',
                        dtick = 7*86400000.0,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = TRUE)) %>%
    config(displayModeBar = FALSE)
}

create_sex_timeline_histogram <- function(df){
  first_sex <- df %>%
    pull(SEX) %>%
    unique()
  first_sex <- first_sex[1]
  
  plot_ly(data = df[which(df$SEX==first_sex),],
          type = 'scatter',
          mode='lines',
          x = ~DATE,
          y = ~CASES,
          color= ~SEX) %>%
    add_trace(data = df[which(!(df$SEX==first_sex)),],
              type = 'scatter',
              mode='lines',
              x = ~DATE,
              y = ~CASES,
              color=~SEX,
              visible = "legendonly"
    ) %>%
    layout(title = "Daily record of cases by Sex",
           hovermode = "x unified",
           xaxis = list(title = "Date",
                        showgrid = F,
                        type = 'date',
                        dtick = 7*86400000.0,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = TRUE)) %>%
    config(displayModeBar = FALSE)
}

create_datatable <- function(df,options){
  df %>%
  datatable(
    filter = 'top', extensions = c('Buttons', 'Scroller'),
    options = options, 
    rownames = FALSE)
}

create_empty_dataframe <- function(col_names){
df <- data.frame(matrix(ncol = length(col_names), nrow = 0))
colnames(df) <- col_names
return(df)
}

create_default_datatable <- function(df, selection = "none", options = NULL, ...){
  if (is.null(options)){
    options <- get_default_datatable_options(df)
  }
  df %>%
    datatable(rownames = FALSE, escape = FALSE, selection=selection, options = options, ...)
}

#' Getter for datatable default options
#' @param df the target dataframe
#' @return list of options
get_default_datatable_options <- function(df){
  list(dom = "t", 
       ordering = TRUE, 
       pageLength = -1, 
       columnDefs = list(list(className = "dt-center",
                              targets = 1:(ncol(df)-1))))
}