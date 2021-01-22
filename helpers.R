# Helper functions -------------------------------------------------------------

get_dataset <- function(){
  temp = tempfile(fileext = ".xlsx")
  download.file(CONFIG.DATASET_URL, destfile=temp, mode='wb')
  dataset <- readxl::read_excel(temp, sheet =1)
  dataset
}

prepare_barplot <- function(df,col){
  df %>%
    group_by(!!as.name(col)) %>%
    summarise(CASES = sum(CASES)) %>%
    mutate(!!as.name(col) := ifelse(is.na(!!as.name(col)),'Uknown',!!as.name(col))) %>%
    arrange(desc(CASES)) %>%
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
              color = df$REGION) %>%
    layout(title = "Number of cases by region",
           xaxis = list(title = "Region",
                        categoryorder = "array",
                        categoryarray = ~REGION,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = FALSE)) %>%
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
                        zeroline = FALSE)) %>%
    config(displayModeBar = FALSE)
}

create_timeline_histogram <- function(df){
  df %>%
    plot_ly() %>%
    add_trace(type = 'scatter',
              mode = 'lines',
              x = ~DATE,
              y = ~CASES
              ) %>%
    layout(title = "Daily record of cases",
           xaxis = list(title = "Date",
                        showgrid = F,
                        dtick = 7,
                        zeroline = FALSE),
           yaxis = list(title = "Number of cases",
                        showgrid = F,
                        zeroline = FALSE)) %>%
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