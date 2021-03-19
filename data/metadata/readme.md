# Metadata
Organize and store documentation and metadata in this folder, and include relevant information here.

Metadata files should be listed for relevant data sources in [data/data_metadata.csv](../data_metadata.csv)

## JohnDayWShed

This is the John Day River watershed LiDAR DEM. The LiDAR dataset is a 1 m resolution bare earth DEM that was collected between Aug 19-27, 2008. The dataset was larger, but was clipped down for the purposes of easily sharing data. The main focus of the raster is the Middle Fork of the John Day River (Figure 1) and encompasses all CHaMP data provided in the CHaMP_Data_MFJD dataset. A [collection report](Camp_Creek_Lidar_Report_2008.pdf) and [acceptance report](2008_OLC_Camp_Creek_Acceptance_Report.pdf) were provided in the material, which includes horizontal and vertical uncertainty values and other logistical considerations for the dataset.

LiDAR data and the associated metadata were downloaded from the Oregon Department of Geology and Mineral Industries (DOGAMI) data portal at [https://gis.dogami.oregon.gov/maps/lidarviewer/](https://gis.dogami.oregon.gov/maps/lidarviewer/).

Download into the `data/raw/private` directory from https://geography.middlebury.edu/jholler/data/rosgenrr/JohnDayWShed.zip

## JohnDayWShed_Ortho

This dataset is a National Agricultural Imagery Program (NAIP) 4-Band 8 Bit image from 2016. NAIP aerial imagery is acquired during the agricultural growing season, across the continental USA. The program is run by the United States Department of Agriculture’s Farm Service Agency. Orthoimages feature 1 m resolution and the red, green, blue, and near infrared spectral bands.

This dataset was accessed through the NOAA Data Access Viewer website (https://coast.noaa.gov/dataviewer/?#/), which contains imagery, land cover, and elevation/LiDAR data for portions of the United States. Data was clipped to the extent of the LiDAR DEM to allow for easier sharing of the dataset.

![area of interest](aoi.jpg) 
Figure 1. State of Oregon, USA, with the Middle Fork John Day River outlined in black. The green dots within the watershed boundary show the location of the Columbia Habitat Monitoring Program (CHaMP) data points provided for this project.

Download into the `data/raw/private` directory from https://geography.middlebury.edu/jholler/data/rosgenrr/JohnDayWShed_OrthoPrj.zip

## CHaMP_Data_MFJD

The Columbia Habitat Monitoring Program (CHaMP) observed 26 watersheds in the Columbia River watershed, chosen to maximize contrasts in current habitat conditions. The main goal of this monitoring program was to generate and implement a set of standard methods for monitoring fish habitat (https://www.champmonitoring.org/). The Kasprak et al. (2016) article employed a variety of classification schemes using the CHaMP dataset, including the Rosgen Stream Classification method. The data provided for this module is a subset of the overall dataset, that overlapped with available bare earth light detection and ranging (LiDAR) digital elevation models (DEM) for the state of Oregon, USA. The subset includes points within the Middle Fork John Day River (MFJD).

Data was accessed through a National Oceanic and Atmospheric Administration (NOAA) data portal and was available upon request (https://www.fisheries.noaa.gov/inport/item/18087). The data originally came as two CSV datasets with latitude and longitude positions. These data were joined and converted into a point vector shapefile using the lat/long positions. The final dataset includes data on grain size, bankfull depth, width, and volume, collection years, discharge during collection, sinuosity (to compare against your values), and other stream classification designations to help characterize the dataset. Please note that there are multiple points occupying a single location, as these points represent different collections throughout the years.

Variable names and descriptions are tabulated in [MFJD_Variables.csv](MFJD_Variables.csv)
