
CONFIG.DATASET_URL = 'https://epistat.sciensano.be/Data/COVID19BE.xlsx'
CONFIG.TABLE_OPTIONS = list(scrollY = 500,
                            scrollX = 500,
                            deferRender = TRUE,
                            scroller = FALSE,
                            paging = TRUE,
                            pageLength = 50,
                            buttons = list(list(extend = 'colvis', targets = 0, visible = FALSE)),
                            dom = 'lBfrtip',
                            fixedColumns = TRUE)
CONFIG.TABLE_COLUMN_NAMES <- c(
  'Date',
  'Province',
  'Region',
  'Age Group',
  'Sex',
  'Cases'
)
CONFIG.X_AXIS <- c('Brussels','Flanders','Wallonia','Unknown')
CONFIG.Y_AXIS <- c(
  'Brussels',
             'Antwerpen',
             'Limburg',
             'OostVlaanderen',
             'VlaamsBrabant',
             'WestVlaanderen',
             'BrabantWallon',
             'Hainaut',
             'Liège',
             'Luxembourg',
             'Namur',
             'Unknown')
Encoding(CONFIG.Y_AXIS) <- "UTF-8"