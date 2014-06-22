##Getting and Cleaning Data Course Project

This is a project assignment for "Getting and Cleaning Data" Course from Coursera.

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

###The goal include:

####create one R script called run_analysis.R that does the following:

1. `Merges` the training and the test sets to create one data set.
2. `Extracts` only the measurements on the `mean and standard deviation` for each measurement. 
3. Uses `descriptive activity names` to name the activities in the data set
4. Appropriately labels the data set with `descriptive variable names`. 
5. Creates a second, independent `tidy data set` with the `average of each variable for each activity and each subject`.

This repository contain scripts for completeing the above project. R is a programming language used to perform above task. 

###run_analysis.R 

This file include the full script from downloading to creating a tidy dataset for analysis. The comments describe the step by step process too. 

##### How to use run_analysis.R

* If you haven't yet downloaded the data then just run the 'run_analysis.R' script. It will download and create a tidy dataset too.
* The first three line of code download the data.
* If you already have downloaded the data then set working directory to the place where data is downloaded and skip first three line of code by commenting it.(Example if you have your data (UCI HAR Dataset folder) in Desktop then setwd("~/Desktop")
* Then simply run the rest of the code in R.
* The result will be tidydata set as demanded by project.

For detail process please read the forth section of `CodeBook.md` file. 


###CodeBook.md

Details of data and its collection and feature selection process is described in CodeBook.md file. It aslo include links for downloading the data and its  full description. 


