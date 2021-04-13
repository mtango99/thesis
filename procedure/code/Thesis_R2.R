#Thesis, R segment (Figure Panel B)
#Maddie Tango

#SET YOUR WORKING DIRECTORY

#INSTALL AND LOAD IN PACKAGES
install.packages("landscapemetrics")
install.packages("raster")
install.packages("rgdal")

require(landscapemetrics)
library(raster)
library(sp)
library(rgdal)

#YOU NEED 3 RASTERS (.tif files worked for me):
    #Rasters should be clipped to the scale (buffer) you're measuring & in the correct CRS
#1. NALCMS land cover raster: reclassified into 6 [7 with differentiated lakes] land cover types
      landcoverraster <- raster(file.choose()) #1
      landcoverraster #see min/max
      landcoverraster <- setMinMax(landcoverraster)
      landcoverraster #see that min/max is now accurate
      image(landcoverraster) #make sure it looks correct
#2. Forest raster: extract forest class from NALCMS land cover raster
      forest <- raster(file.choose())
      image(forest)
#3. TPI layer: ridges >1SD & valleys <-1SD from mean
      TPI<- raster(file.choose()) #3
      image(TPI)

##For details about what each of these landscape metrics measure, use the help
      #function by typing, e.g. '?lsm_c_pland', into the console

#PERCENT AREA OF EACH CLASS, class level, units = %
lsm_c_pland(landcoverraster, directions = 8)
  
#EDGE DENSITY: class level, units: meters/hectare
lsm_c_ed(landcoverraster, count_boundary = FALSE, directions = 8)

#MEAN PATCH SIZE, class level, units: hectares
lsm_c_area_mn(landcoverraster, directions = 8)

#LARGEST PATCH INDEX, class level, units = %
lsm_c_lpi(landcoverraster, directions = 8)

#AGGREGATION INDEX, landscape level, units: %
lsm_l_ai(landcoverraster) 
  #Equals 0 for maximally disaggregated and 100 for maximally aggregated classes

#CLUMPINESS INDEX, class level, no units
lsm_c_clumpy(landcoverraster)
    #clumpiness index should be calculated at patch level (Peters et al. 2020), 
    #but only class level is available in package

#SIMPSON'S EVENNESS INDEX, landscape level, no units
lsm_l_siei(landcoverraster, directions = 8)

#FOREST CORE AREA PERCENTAGE OF LANDSCAPE, class level, units = %; edge depth unit: CELLS
lsm_c_cpland(forest, directions = 8, consider_boundary = FALSE, edge_depth = 1.3114)
    #cell size of my forest layer: 30.50175714734205457,-30.50194929572346325: approximate as 30.502. 
    #so edge depth should be 40/30.502 = 1.3114

#PERCENT AREA OF TPI RIDGES AND VALLEYS, class level, units = %
lsm_c_pland(TPI, directions = 8)
