# Copyright (C) 2016 Bohdan Khomtchouk

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
  output$text2 <- renderText({ "Please note that all cell values must be positive (i.e., corresponding to raw gene expression values, i.e., read counts per gene per sample) from a ChIP-seq or RNA-seq experiment.  A sample .csv file is provided under the 'Download Sample Input File' button.  Press that button, save the file to your computer, then click the 'Choose File' button to upload it.  In offbeat cases where the input file is a combination of various standard (or non-standard) delimiters, simply use the 'Text to Columns' feature in Microsoft Excel under the 'Data' tab to parse the file before using shinyheatmap." })
  output$text3 <- renderText({ "1) After uploading a .csv file, both a static and interactive heatmap will be produced in their respective panels.  You may customize your static heatmap parameters in the sidebar panel and download the heatmap to your computer.  Likewise, you may customize the interactive heatmap parameters in its own dedicated panel (located under the 'Interactive Heatmap' tab) and download your heatmap.  This 'Interactive Heatmap' tab is great for zooming in and out of the contents of the heatmaps (both from the interior of the heatmap, as well as from the dendrogram panes).  This is especially useful for finely examining extremely large biological input datasets of hundreds of thousands of rows." })
  output$text4 <- renderText({ "2) For more information about this software, please visit the shinyheatmap publication." })

  # sample file download
  output$downloadData <- downloadHandler(
  	filename <- function() {
    	paste('genes', 'File', '.csv', sep='')
  	},
  	content <- function(file) {
    	file.copy("genesFile.csv", file)
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
  
  
  staticHeatmap <- reactive({
		genexp <- datasetInput()
   		names_genexp <- genexp[[1]]
   		genexp <- genexp[, -1, with = FALSE]
   		row.names(genexp) <- names_genexp
   		heatmap.2(
   				 data.matrix(genexp), 
   				 trace = input$trace, 
   				 scale = input$scale, 
   				 dendrogram = input$dendrogram, 
   				 key = input$key, 
   				 cexRow = as.numeric(as.character(input$xfontsize)),
      		     cexCol = as.numeric(as.character(input$yfontsize)),
   				 Rowv = TRUE, 
   				 Colv = TRUE, 
   				 col = colorpanel (256, low = input$lowColor, high = input$highColor)
   				 )
  		})
  
  
  output$static <- renderPlot({
		if(!is.null(datasetInput()))
      		staticHeatmap()
  	})
  	
  
  interactiveHeatmap <- reactive({
		genexp <- datasetInput()
   		names_genexp <- genexp[[1]]
   		genexp <- genexp[, -1, with = FALSE]
   		row.names(genexp) <- names_genexp
   		heatmaply(genexp, k_row = 30, k_col = 4)
  		})
  
  
  output$interactive <- renderPlotly({
		if(!is.null(datasetInput()))
      		interactiveHeatmap()
  	})
  	  
  								
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