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

# for plotting (from TESS)
source("http://membres-timc.imag.fr/Olivier.Francois/Conversion.R")
source("http://membres-timc.imag.fr/Olivier.Francois/POPSutilities.R")



#These are the major input files
#1. genotype dosage matrix (the gen argument)
#2. coordinates for samples (the coords argument)
#3. environmental layers (the envlayers argument)


#====================================================================

setwd("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/wingen")


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
CA.OR_dem <- crop(dem, env_pcs123$map)
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
krig_raster <- raster::aggregate(env_pcs$map[[1]], fact = 2)


#======================================================================
#======================================================================
#======================================================================

# Set to 4 GB, for example
options(future.globals.maxSize = 10000 * 1024^2)  
# 1024^2 calculates the number of bytes in a megabyte (1024 bytes per kilobyte, and 1024 kilobytes per megabyte). 4000 is the approx. number of megabytes in 4 gigabytes

GEAsamples_lyr <- coords_to_raster(coords, res = 0.5, buffer = 5)
envlayer <- rast(env_pcs123$map[[1]])


wgd_pi <- window_gd(vcf,
  coords,
  GEAsamples_lyr,
  stat = "pi",
  wdim = 3,
  fact = 0
)

wgd_ho <- window_gd(vcf,
  coords,
  GEAsamples_lyr,
  stat = "Ho",
  wdim = 3,
  fact = 0
)


#===================================================================

###generic
par(mfrow = c(1, 2), oma = rep(1, 4), mar = rep(2, 4))
# Plot map of pi
pdf("wgd_pi.pdf")
plot_gd(wgd_pi, main = "Moving window pi", bkg = envlayer, xlim=c(-125, -114), ylim=c(32, 47))
dev.off()

pdf("wgd_ho.pdf")
plot_gd(wgd_ho, main = "Heterozygosity", bkg = envlayer, xlim=c(-125, -114), ylim=c(32, 47))
dev.off()

# Plot sample count map
pdf("sampleCounts.pdf")
plot_count(wgd_pi, main = "Sample counts", xlim=c(-125, -114), ylim=c(32, 47))
dev.off()


#====================================================================


kgd_pi <- krig_gd(wgd_pi, index = 1:2, GEAsamples_lyr, disagg_grd = 5)
kgd_ho <- krig_gd(wgd_ho, index = 1:2, GEAsamples_lyr, disagg_grd = 5)

mgd_1 <- mask_gd(kgd_pi, kgd_pi[["sample_count"]], minval = 1)
mgd_2 <- mask_gd(kgd_ho, kgd_ho[["sample_count"]], minval = 2)

#par(mfrow = c(1, 2), oma = rep(1, 4), mar = rep(2, 4))
#plot_gd(mgd_1, main = "Kriged & masked pi", bkg = envlayer)
#plot_gd(mgd_2, main = "Kriged & masked pi", bkg = envlayer)

# Resample envlayer based on masked layer
r <- terra::resample(envlayer, mgd_1)

# Perform masking
mgd <- mask_gd(mgd_1, r)
mgd2 <- mask_gd(mgd_2, r)

# Plot masked map
pdf("pi_krigedMasked.pdf")
plot_gd(mgd, main = "Kriged & Masked Pi", bkg = r)
dev.off()

pdf("ho_krigedMasked.pdf")
plot_gd(mgd2, main = "Kriged & Masked Heterozygosity", bkg = r)
dev.off()










