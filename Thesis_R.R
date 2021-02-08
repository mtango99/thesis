#Thesis, R segment (Figure Panel B)
#Maddie Tango

#patch, class, & landscape level metrics
#https://r-spatialecology.github.io/landscapemetrics/articles/articles/general-background.html#:~:text=Class%20level%20metrics%20are%20suitable,including%20all%20patches%20and%20classes.
#https://rdrr.io/cran/landscapemetrics/man/
#https://cran.r-project.org/web/packages/landscapemetrics/landscapemetrics.pdf


#https://www.neonscience.org/resources/learning-hub/tutorials/raster-data-r
#https://cran.r-project.org/web/packages/landscapemetrics/vignettes/getstarted.html

install.packages("landscapemetrics")
require(landscapemetrics)
#first need to make layers with buffers/x distance outside of turbines and cookie cut NALCMS layers from that

install.packages("raster") #this might be included in landscapemetrics
install.packages("rgdal")

library(raster)
library(sp)
library(rgdal)

#set working directory
#setwd("D:/_MADDIE_LAPTOP/SEAGATE_Thesis_Spatial_Layers/Thesis_R")

#Upload NALCMS land cover raster here (reclassified into 6 land cover types), clipped to 25 km buffer (or whichever you're measuring) & in the correct CRS
#a .tif file worked for me
landcoverraster <- raster(file.choose())
#NALCMS_WVSP <- raster("D:/_MADDIE_LAPTOP/SEAGATE_Thesis_Spatial_Layers/BeechRidge_WV/NALCMS_WVSP")
#CHANGED THIS TO THE RECLASSIFIED = NALCMS_reclassifiedtotal

landcoverraster
landcoverraster <- setMinMax(landcoverraster)

#not sure what this does:
#check_landscape(landscapemetrics::landscape)
#check_landscape(landscapemetrics::podlasie_ccilc)
#check_landscape(landscapemetrics::augusta_nlcd)

#lsm_p_perim(landscape) #not sure what landscape is... already loaded in?
#lsm_p_perim(landcoverraster)

list <- list_lsm() #lists all available functions
list

#https://cran.r-project.org/web/packages/landscapemetrics/landscapemetrics.pdf
# check for patches of class 1
patched_raster <- get_patches(landcoverraster, class = 14)
# count patches
length(raster::unique(patched_raster[[1]]))
# check for patches of every class
patched_raster_all <- get_patches(landcoverraster)
patched_raster_all

image(landcoverraster)
#image(landcoverraster, zlim=c(1,3)) #should show only certain values? maybe classes are diff

edgedensity <- lsm_c_ed(landcoverraster, count_boundary = FALSE, directions = 8) #edge density, class level
edgedensity
#Looks right! For the 6 classes :)

# A tibble: 6 x 6
#layer level class    id metric value
#<int> <chr> <int> <int> <chr>  <dbl>
#  1     1 class    14    NA ed      2.07
#2     1 class    15    NA ed     18.0 
#3     1 class    17    NA ed     23.5 
#4     1 class    18    NA ed      1.37
#5     1 class    20    NA ed     55.3 
#6     1 class    21    NA ed     25.6 
#UNITS: meters per hectare!

#NALCMS_forest: forest core area "Core area percentage of landscape (Core area metric)"
#cpland
#see functions here: https://github.com/r-spatialecology/landscapemetrics/blob/master/R/lsm_c_cpland.R
#see code usage here: https://cran.r-project.org/web/packages/landscapemetrics/landscapemetrics.pdf

forest <- raster(file.choose()) #"D:/_MADDIE_LAPTOP/SEAGATE_Thesis_Spatial_Layers/Beech Ridge, WV/NALCMS_forest")
#Warning message:
#In showSRID(uprojargs, format = "PROJ", multiline = "NO", prefer_proj = prefer_proj) :
 # Discarded datum Unknown based on GRS80 ellipsoid in CRS definition
    #did this happen to others...? YES for each raster. 

forest@crs@projargs #units are in meters

image(forest)

lsm_c_cpland( #class level, forest core area
  forest,
  directions = 8,
  consider_boundary = FALSE,
  edge_depth = 40
)
#0.435 output for forest class (1) [units = percentage]
#So core area takes up 0.435% of forest landscape (pretty small meaning the 40 m edge makes it pretty small left over)
#for non-forest, 0%. that doesn't make sense... METERS TO CELLS EDGE DEPTH CONVERSION
#if I do edge depth = 1, class 0 = 13.9% and class 1 = 65.5%
#If i do edge depth = 0, doesn't add to 100
  #cell size of my forest layer: 30.50175714734205457,-30.50194929572346325: approximate as 30.502. 
  #so edge depth should be 40/30.502 = 1.3114
  #NEW OUTPUT: 65.5%
#layer level class    id metric value
#<int> <chr> <int> <int> <chr>  <dbl>
#1     1 class     0    NA cpland  13.9
#2     1 class     1    NA cpland  65.5

#clumpiness index should be calculated at patch level (Peters et al. 2020), but only class level is available in package
#if at patch how do you then work with multiple outputs for your correlation study? 
  #they put in everything individually
#lsm_c_clumpy
lsm_c_clumpy(landcoverraster)
# A tibble: 6 x 6
#layer level class    id metric value
#<int> <chr> <int> <int> <chr>  <dbl>
#  1     1 class    14    NA clumpy 0.807
#2     1 class    15    NA clumpy 0.825
#3     1 class    17    NA clumpy 0.533
#4     1 class    18    NA clumpy 0.737
#5     1 class    20    NA clumpy 0.768
#6     1 class    21    NA clumpy 0.782


#Aggregation index
lsm_l_ai(landcoverraster) 
  #90.4%
  #Equals 0 for maximally disaggregated and 100 for maximally aggregated classes
  #in Peters, between 0 and 1, so 0.904
  #so pretty homogenous. 

#mean patch size (hectares)
lsm_c_area_mn(landcoverraster, directions = 8)
# A tibble: 6 x 6
#layer level class    id metric   value
#<int> <chr> <int> <int> <chr>    <dbl>
#  1     1 class    14    NA area_mn   5.17
#2     1 class    15    NA area_mn  11.7 
#3     1 class    17    NA area_mn   6.71
#4     1 class    18    NA area_mn   5.70
#5     1 class    20    NA area_mn 151.  
#6     1 class    21    NA area_mn   6.58


#largest patch index 
lsm_c_lpi(landcoverraster, directions = 8)
# A tibble: 6 x 6
#layer level class    id metric   value
#<int> <chr> <int> <int> <chr>    <dbl>
#  1     1 class    14    NA lpi     0.418 
#2     1 class    15    NA lpi     1.69    CROPLAND
#3     1 class    17    NA lpi     0.301 
#4     1 class    18    NA lpi     0.0638
#5     1 class    20    NA lpi    74.8        FOREST
#6     1 class    21    NA lpi     0.388 


#find percent area of each class
lsm_c_pland(landcoverraster, directions = 8)
# A tibble: 6 x 6
#layer level class    id metric  value
#<int> <chr> <int> <int> <chr>   <dbl>
#  1     1 class    14    NA pland   0.806
#2     1 class    15    NA pland   8.47 
#3     1 class    17    NA pland   3.98  #Urban (for local, 4.44%)
#4     1 class    18    NA pland   0.390
#5     1 class    20    NA pland  76.5       #FOREST
#6     1 class    21    NA pland   9.88 

#find percent area of TPI ridges and valleys
TPI<- raster(file.choose()) #TPI_reclass
lsm_c_pland(TPI, directions = 8)
# A tibble: 3 x 6
#layer level class    id metric value
#<int> <chr> <int> <int> <chr>  <dbl>
#  1     1 class    -1    NA pland   8.34
#2     1 class     0    NA pland  84.0 
#3     1 class     1    NA pland   7.70


#can't find Simpson's evenness index? lsm_l_siei
lsm_l_siei(landcoverraster, directions = 8) #0.476

#can I do linear densities in here? #they did this in ArcGIS

#THIS IS ALL 6 CLASSES. WILL NEED TO RERUN WITH LARGE/SMALL WATERBODIES. 