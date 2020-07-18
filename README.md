<div align="center">

# shinyheatmap

<img src="https://user-images.githubusercontent.com/9893806/35200211-c8d27534-febe-11e7-837f-477e2b606ca3.png">

##### R Shiny web app for enormous biological heatmaps

</div>

## About
Purpose: To create user-friendly, highly customizable static and interactive biological heatmaps of big datasets in a web browser.

If you are using `shinyheatmap` in your work, please cite the paper (http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0176334).

## Citation
Khomtchouk BB, Hennessy JR, Wahlestedt C: "shinyheatmap: Ultra fast low memory heatmap web interface for big data genomics."  <i>PLoS One</i>.  2017, 12(5): e0176334.  

## Funding

`shinyheatmap` was originally financially supported (2014-2017) by the United States Department of Defense (DoD) through the National Defense Science and Engineering Graduate Fellowship (NDSEG) Program. This research was conducted with Government support under and awarded by DoD, Army Research Office (ARO), National Defense Science and Engineering Graduate (NDSEG) Fellowship, 32 CFR 168a.

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
* `install.packages("rsconnect")`
* `library(rsconnect)`
* `install.packages("data.table")`
* `library(data.table)`
* `install.packages("gplots")`
* `library(gplots)`
* `install.packages("heatmaply")`
* `library(heatmaply)`
* `library(tools)`
* `runApp("shinyheatmap")`

## Presentation
`shinyheatmap` was presented at the Bay Area R User Group (BARUG) Meeting, which was held at Intuit Building 9 – Invention and Innovation, Mountain View, CA.  Slides available here: https://github.com/joseph-rickert/BARUG/blob/master/Bohdan-Khomtchouk_BARUG_November-2017.pptx

## Contact

You are welcome to:

* submit suggestions and bug-reports at: <https://github.com/Bohdan-Khomtchouk/shinyheatmap/issues>
* send a pull request on: <https://github.com/Bohdan-Khomtchouk/shinyheatmap>
* compose an e-mail to: <bohdan@uchicago.edu>

## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

## Future plans

- [x] Outperform all state-of-the-art heatmap software (https://doi.org/10.1371/journal.pone.0176334.g004)
- [x] Retain the (comfortable) lead
- [x] Add [search functionality](https://github.com/Bohdan-Khomtchouk/fastheatmap/issues/6)
- [ ] Add high performance hierarchical clustering
- [ ] Add a desktop anchor view (i.e., having a "satellite" view when zooming in would be of great help on desktop screens.  In CytoscapeWeb or Cytoscape network visualization tools, for example, when users zoom in/out there is always a small window showing the big picture of the network at its higher level and a rectangle highlighting the region where users zoomed in)
- [ ] Add augmented reality enabled views that can break the heatmap out of a user's desktop directly into the user's spatial environment (work in progress: https://github.com/HeatmapDojo/ar-heatmap)