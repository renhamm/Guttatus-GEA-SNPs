#loading packages
library(algatr)
library(here)
library(wingen)
library(tess3r)
library(ggplot2)
library(terra)
library(raster)
library(fields)
library(rworldmap)
library(automap)
library(cowplot)
library(corrr)
library(ggcorrplot)
library(FactoMineR)
library(factoextra)
library(RStoolbox)
library(geodata) 
library(dplyr)
library(tidyr)
library(tibble)
library(vegan)
library(gdm)

# for plotting (from TESS)
source("http://membres-timc.imag.fr/Olivier.Francois/Conversion.R")
source("http://membres-timc.imag.fr/Olivier.Francois/POPSutilities.R")


#These are the major input files
#1. genotype dosage matrix (the gen argument)
#2. coordinates for samples (the coords argument)
#3. environmental layers (the envlayers argument)


#====================================================================

setwd("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/mmrr_gdm")


#getting coodinates file
#first column is longitude and second is latitude
envData=read.csv("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/Corrected_BioClim327.csv", header = TRUE)
coords <- envData[ , c(3,4) ]
bc19 <- envData[ , c(5:23)]



#####WORLDCLIM#####
wclim <- get_worldclim(coords = coords, res = 2.5)
#plot(wclim[[1]], col = turbo(100), axes = FALSE)
cors_env <- check_env(wclim)

#getting env layers file
#use wingen to get raster
PCA_data <- read.csv("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/plinkPCA/G4t90_327.eigenvec.csv", header=TRUE)
#coords <- PCA_data[ , c("Long","Lat") ]

States <- raster::getData("GADM", country = "United States", level = 1)
States <- States[States$NAME_1 == c("California","Oregon"),]

###getting original worldclim data
bioclim <- getData("worldclim",var="bio",res=2.5)
bioclim1 <- mask(x = bioclim, mask = States)
#plot(bioclim1$bio1, xlim=c(-125, -114), ylim=c(32, 47))
check_results <- check_dists(wclim, coords)
#get PCs of variables
env_pcs <- rasterPCA(wclim, spca = TRUE)
env_pcs123 <- rasterPCA(wclim, spca = TRUE, nComp = 3)
# Let's take a look at the results for the top three PCs
#plots <- lapply(1:3, function(x) ggR(env_pcs$map, x, geom_raster = TRUE))
#plots[[1]] 
#ggRGB(env_pcs$map, 1, 2, 3, stretch = "lin", q = 0)

#create raster from coords for WINGEN
raster <- coords_to_raster(coords, res = 1)
#plot(raster, axes = FALSE)
#points(coords, pch = 19)

#calculate environmental distances
env <- raster::extract(env_pcs123$map, coords)
env_dist <- env_dist(env)
#plot(env_dist$PC1)


#getting geogrpahic distance
geo_dist <- geo_dist(coords, type = "Euclidean")
# Make a fun heat map with the pairwise distances
geo_dist <- as.data.frame(geo_dist)
colnames(geo_dist) <- rownames(geo_dist)


#getting topographic distance
library(geodata)
dem <- elevation_30s(country = "USA", path = getwd())
CA.OR_dem <- crop(dem, env_pcs$map)
plot(CA.OR_dem, axes = FALSE)
points(coords, pch = 19)
topo_dist <- geo_dist(coords, type = "topo", lyr = CA.OR_dem)
# Make a fun heat map with the pairwise distances
topo_dist <- as.data.frame(topo_dist)
colnames(topo_dist) <- 1:327
rownames(topo_dist) <- 1:327

CA.OR_lyr <- coords_to_raster(coords, buffer = 1, plot = TRUE)



#================================================================
#here we are getting all the genetic data

#getting genotype dosage matrix
library(vcfR)
vcf <- read.vcfR("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.vcf.gz", verbose = FALSE )
dosage <- vcf_to_dosage(vcf)

simple_dos <- simple_impute(dosage)
str_dos <- str_impute(gen = dosage, K = 1:3, entropy = TRUE, repetitions = 3, quiet = FALSE, save_output = FALSE)


#================================================================

# First, create a grid for kriging
# We can use one environmental layer (PC1), aggregated (i.e., increased cell size) to increase computational speed
krig_raster <- raster::aggregate(env_pcs123$map[[1]], fact = 2)



#=================================================================


gendist <- read.table("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/G4t90_327.dist", header=FALSE)
Y <- as.matrix(gendist)

# Extract enviro vars
env <- raster::extract(env_pcs123$map, coords)
# Calculate environmental distances
X <- env_dist(env)
# Add geographic distance to X
X[["geodist"]] <- geo_dist(coords)

#with all variables
set.seed(10)
results_full <- mmrr_run(Y, X, nperm = 99, stdz = TRUE, model = "full")

#with variable selection
set.seed(01)
results_best <- mmrr_run(Y, X, nperm = 99, stdz = TRUE, model = "best")


pdf("mmrr_full.pdf")
mmrr_plot(Y, X, mod = results_full$mod, plot_type = "cov", stdz = TRUE)
dev.off()

pdf("mmrr_best.pdf")
mmrr_plot(Y, X, mod = results_best$mod, plot_type = "all", stdz = TRUE)
dev.off()

pdf("gendist-IBD_mmrr.pdf")
mmrr_plot(Y, X, mod = results_full$mod, plot_type = "vars", stdz = TRUE)
dev.off()

pdf("fittedvar_obs-gendistY_pred-gendistX.pdf")
# Fitted variable plot
mmrr_plot(Y, X, mod = results_full$mod, plot_type = "fitted", stdz = TRUE)
dev.off()



#mmrr_finalTable_full <- mmrr_table(results_full, digits = 2, summary_stats = TRUE)

pdf("mmrr-table_best.pdf")
mmrr_finalTable_best <- mmrr_table(results_best, digits = 2, summary_stats = TRUE)
dev.off()

#write.csv(mmrr_finalTable_full, "mmrr_finalTable_full.csv", row.names=FALSE, quote=FALSE) 
#write.csv(mmrr_finalTable_best, "mmrr_finalTable_best.csv", row.names=FALSE, quote=FALSE)



#========================================================================
#========================================================================
#========================================================================
#gdm_packages()

# Set to 100 GB, for example
#options(future.globals.maxSize = 100000 * 1024^2)
# 1024^2 calculates the number of bytes in a megabyte (1024 bytes per kilobyte, and 1024 kilobytes per megabyte). 4000 is the approx. number of megabytes in 4 gigabytes




#GEAsamples_gendist <- read.table("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/G4t90_327.dist")
#GEAsamples_gendist <- as.matrix(GEAsamples_gendist)
#x1 <- coords

#R <- 3963.34
#coslat1 <- cos((x1[, 2] * pi)/180)
#sinlat1 <- sin((x1[, 2] * pi)/180)
#coslon1 <- cos((x1[, 1] * pi)/180)
#sinlon1 <- sin((x1[, 1] * pi)/180)

#pp <- cbind(coslat1 * coslon1, coslat1 * sinlon1, sinlat1) %*%
  t(cbind(coslat1 * coslon1, coslat1 * sinlon1, sinlat1))
#trunc <- function(x, ..., prec = 0) base::trunc(x * 10^prec, ...) / 10^prec
#pp <- (trunc(pp, prec = 7)) # 0.1234
#diag(pp) <- 1
#GeoDist = (R * acos(ifelse(abs(pp) > 1, 1 * sign(pp), pp)))


#env <- raster::extract(env_pcs123$map, coords)


#gdm_best <- gdm_run(gendist = GEAsamples_gendist, 
                    coords = coords, 
                    env = env, 
                    model = "best", 
                    scale_gendist = TRUE,
                    nperm = 500, 
                    sig = 0.05)




#pdf("gdm_diss.pdf")
#gdm_plot_diss(gdm_best$model)
#dev.off()

#pdf("gdm_isplines.pdf")
#par(mfrow = c(2, 2))
#gdm_plot_isplines(gdm_best$model)
#dev.off()

#pdf("gdm_table.pdf")
#gdm_table(gdm_best)
#dev.off()


#pdf("gdm_map.pdf")
#gdm_map(gdm_best$model, env, coords)
#dev.off()



#map <- gdm_map(gdm_best$model, env, coords, plot_vars = FALSE)

#maprgb <- map$pcaRastRGB

# Now, use `extrap_mask()` to do buffer-based masking
#map_mask <- extrap_mask(coords, maprgb, method = "buffer", buffer_width = 1.25)

# Plot the resulting masked map
#pdf("gdm_map_extrap.pdf")
#plot_extrap_mask(maprgb, map_mask, RGB = TRUE, mask_col = rgb(1, 1, 1, alpha = 0.6))
#dev.off()


