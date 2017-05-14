# shinyheatmap

## About
Purpose: To create user-friendly, highly customizable static and interactive biological heatmaps of big datasets in a web browser.

If you are using `shinyheatmap` in your work, please cite the paper (http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0176334) accordingly.

## Funding

`shinyheatmap` is financially supported by the United States Department of Defense (DoD) through the National Defense Science and Engineering Graduate Fellowship (NDSEG) Program. This research was conducted with Government support under and awarded by DoD, Army Research Office (ARO), National Defense Science and Engineering Graduate (NDSEG) Fellowship, 32 CFR 168a.

## Usage (for general public)

##### http://shinyheatmap.com/

## Installation (for developers only)

### Requirements for developers

* R programming language
  * RStudio

## How to run (for developers only)

##### Git clone this repo to your computer, and in RStudio type:
* `setwd("~/path/to/my_directory_that_contains_shinyheatmap_folder")`
* `install.packages("shiny")`
* `library(shiny)`
* `library(shinyapps)`
* `install.packages("data.table")`
* `library(data.table)`
* `install.packages("gplots")`
* `library(gplots)`
* `install.packages("heatmaply")`
* `library(heatmaply)`
* `install.packages("tools")`
* `library(tools)`
* `runApp("shinyheatmap")`
