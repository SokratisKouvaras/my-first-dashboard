
CONFIG.DATASET_URL = 'https://epistat.sciensano.be/Data/COVID19BE.xlsx'
CONFIG_TABLE_OPTIONS = list(scrollY = 500,
                            scrollX = 500,
                            deferRender = TRUE,
                            scroller = FALSE,
                            paging = TRUE,
                            pageLength = 50,
                            buttons = list(list(extend = 'colvis', targets = 0, visible = FALSE)),
                            dom = 'lBfrtip',
                            fixedColumns = TRUE)