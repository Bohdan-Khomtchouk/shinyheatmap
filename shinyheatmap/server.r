# Copyright (C) 2016-2018 Bohdan Khomtchouk

# This file is part of shinyheatmap.

# ------------------------------------------------------------------------------------

options(shiny.maxRequestSize=30*1024^2)
library(shiny)
library(data.table)
library(gplots)
library(heatmaply)
library(tools)


# backend 
server <- shinyServer(function(input, output) {	
  
  # instructions tab
  output$text1 <- renderText({ "0) You can easily make a .csv file by simply saving your Microsoft Excel workbook as a .csv through 'Save As'.  Before saving as a .csv, your Excel file should look something like:" })
  output$text2 <- renderText({ "Please note that all cell values must be positive (i.e., corresponding to raw gene expression values, i.e., read counts per gene per sample) from a ChIP-seq or RNA-seq experiment.  Some sample .csv files are provided for download.  You may download these files to your computer, then click the 'Browse...' button to upload either of them.  In offbeat cases where the input file is a combination of various standard (or non-standard) delimiters, simply use the 'Text to Columns' feature in Microsoft Excel under the 'Data' tab to parse the file before using shinyheatmap." })
  output$text3 <- renderText({ "1) After uploading a .csv file, both a static and interactive heatmap will be produced in their respective panels.  Otherwise, if the input dataset is too large, the user is prompted to navigate to shinyheatmap's high performance web server (called fastheatmap), which is especially useful for interactively examining extremely large biological input datasets (e.g., tens or hundreds of thousands of rows).  Fastheatmap is the fastest interactive heatmap software in the world (>100,000 times faster than competitors):" })
  output$text4 <- renderText({ "2) You may customize your static heatmap parameters in the left sidebar panel and download the heatmap to your computer.  Likewise, you may customize the interactive heatmap parameters in its own dedicated panel (which will appear on-hover under the 'Interactive Heatmap' tab in the top right corner) and download your heatmap.  This 'Interactive Heatmap' tab is great for zooming in and out of the contents of the heatmaps (both from the interior of the heatmap itself, as well as from the dendrogram panes)." })
  output$text5 <- renderText({ "3) For more information about this software, please visit the shinyheatmap publication.  If you are using shinyheatmap in your work, please cite the paper accordingly (Khomtchouk BB, Hennessy JR, Wahlestedt C: 'shinyheatmap: Ultra fast low memory heatmap web interface for big data genomics.' PLoS One. 2017, 12(5): e0176334)." })
  
  
  # sample file download (small dataset)
  output$downloadSmallData <- downloadHandler(
    filename <- function() {
      paste('small', 'Genes', 'File', '.csv', sep='')
    },
    content <- function(file) {
      file.copy("smallGenesFile.csv", file)
    },
    contentType = "text/csv"
  )
  
  
  # sample file download (mid-sized dataset)
  output$downloadMidData <- downloadHandler(
    filename <- function() {
      paste('mid', 'Genes', 'File', '.csv', sep='')
    },
    content <- function(file) {
      file.copy("midGenesFile.csv", file)
    },
    contentType = "text/csv"
  )
  
  
  # sample file download (huge dataset)
  output$downloadHugeData <- downloadHandler(
    filename <- function() {
      paste('huge', 'Genes', 'File', '.csv', sep='')
    },
    content <- function(file) {
      file.copy("hugeGenesFile.csv", file)
    },
    contentType = "text/csv"
  )
  
  
  # file upload
  datasetInput <- reactive({
    validate(
      need(input$filename != 0, "To begin drawing a heatmap, please select a file for input") 
    )
    inFile <- input$filename
    if (is.null(inFile)) return(NULL)
    fread(inFile$datapath)
  })
  
  
  # static heatmap prep
  staticHeatmap <- function(){
    genexp <- datasetInput()
    genexp_df <- as.data.frame(genexp)
    names_genexp_df <- genexp_df[,1]
    n <- NROW(names_genexp_df)
    genexp_df_mat <<- data.matrix(genexp_df[-1])  ## make global for clusteredInput() function
    k <- NCOL(genexp_df_mat)
    row.names(genexp_df_mat) <<- names_genexp_df  ## make global for clusteredInput() function
    if (n > 2000) {
      output$image <- renderUI({
        tags$img(src = "https://cloud.githubusercontent.com/assets/9893806/19628924/44e7168c-9937-11e6-9808-89452fbdd62d.png")
      })
      url <- a("fastheatmap", href = "http://fastheatmap.com/", target = "_blank")
      output$sorry <- renderUI({tagList("You are using an input dataset with", n, "rows and", k, "columns.  Please use our high-performance computing server", "for visualizing such large datasets:", url)})
    }
    else {
      heatmap.2(
        genexp_df_mat, 
        trace = input$trace, 
        scale = input$scale, 
        dendrogram = input$dendrogram,
        distfun = function(x) dist(x, method = input$distanceMethod),
        hclustfun = function(x) hclust(x, method = input$agglomerationMethod), 
        key = input$key, 
        cexRow = as.numeric(as.character(input$xfontsize)),
        cexCol = as.numeric(as.character(input$yfontsize)),
        Rowv = if (input$dendrogram == "both" | input$dendrogram == "row") TRUE else FALSE, 
        Colv = if (input$dendrogram == "both" | input$dendrogram == "column") TRUE else FALSE,
        col = if (input$midColor == "none") colorpanel(256, low = input$lowColor, high = input$highColor) else colorpanel(256, low = input$lowColor, mid = input$midColor, high = input$highColor)
      )
    }
  }
  
  
  # static heatmap output
  output$static <- renderPlot({
    if(!is.null(datasetInput()))
      withProgress(message = 'Making static heatmap:', value = 0, {
        genexp <- datasetInput()
        genexp_df <- as.data.frame(genexp)
        names_genexp_df <- genexp_df[,1]
        n <- NROW(names_genexp_df)
        for (i in 1:n) {
          incProgress(1/n, detail = "Please wait...")
          #incProgress(1/n, detail = paste("Percentage completed:", (i/n)*100, "%"))
        }
        staticHeatmap()
      })		
  })
  
  
  # re-sort input file after hierarchical clustering (prep stage)
  clusteredInput <- function(){
    heatmap_object <- staticHeatmap()
    genexp_df_mat[rev(heatmap_object$rowInd), heatmap_object$colInd]
  }
  
  
  # re-sort input file after hierarchical clustering (download stage)
  output$downloadClusteredInput <- downloadHandler(
    filename = function() {
      paste(basename(file_path_sans_ext(input$filename)), '_clustered', '.csv', sep='')
    },
    content = function(file) {
      write.csv(clusteredInput(), file)
    }
  )
  
  
  # interactive heatmap prep
  interactiveHeatmap <- reactive({
    genexp <- datasetInput()
    genexp_df <- as.data.frame(genexp)
    names_genexp_df <- genexp_df[,1]
    n <- NROW(names_genexp_df)
    genexp_df_mat <- data.matrix(genexp_df[-1])
    k <- NCOL(genexp_df_mat)
    row.names(genexp_df_mat) <- names_genexp_df
    if (n > 2000) {
      output$image2 <- renderUI({
        tags$img(src = "https://cloud.githubusercontent.com/assets/9893806/19628924/44e7168c-9937-11e6-9808-89452fbdd62d.png")
      })
      url <- a("fastheatmap", href = "http://fastheatmap.com/", target = "_blank")
      output$sorry2 <- renderUI({tagList("You are using an input dataset with", n, "rows and", k, "columns.  Please use our high-performance computing server", "for visualizing such large datasets:", url)})
    }
    else {
      heatmaply(genexp_df_mat, k_row = 30, k_col = 4, srtCol = 45) %>% layout(margin = list(l = 100, b = 200))
    }
  })
  
  
  # interactive heatmap output
  output$interactive <- renderPlotly({
    if(!is.null(datasetInput()))
      withProgress(message = 'Making interactive heatmap:', value = 0, {
        genexp <- datasetInput()
        genexp_df <- as.data.frame(genexp)
        names_genexp_df <- genexp_df[,1]
        n <- NROW(names_genexp_df)
        for (i in 1:n) {
          incProgress(1/n, detail = "Please wait...")
        }
        interactiveHeatmap()
      })	
  })
  
  
  # static heatmap download								
  output$downloadHeatmap <- downloadHandler(
    filename <- function() {
      paste0(basename(file_path_sans_ext(input$filename)), '_heatmap', '.png', sep='')
    },
    content <- function(file) {
      png(file)
      tiff(
        file,
        width = 4000,
        height = 2000,
        units = "px",
        pointsize = 12,
        res = 300
      )
      staticHeatmap()
      dev.off()
    }
  )
  
  
})