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
library(algatr)
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

setwd("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/tess")


#getting coodinates file
#first column is longitude and second is latitude
envData=read.csv("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/Corrected_BioClim327.csv", header = TRUE)
coords <- envData[ , c(3,4) ]
bc19 <- envData[ , c(5:23)]



#####WORLDCLIM#####
wclim <- get_worldclim(coords = coords, res = 2.5)
plot(wclim[[1]], col = turbo(100), axes = FALSE)
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
plot(bioclim1$bio1, xlim=c(-125, -114), ylim=c(32, 47))
check_results <- check_dists(wclim, coords)
#get PCs of variables
env_pcs <- rasterPCA(wclim, spca = TRUE)
env_pcs123 <- rasterPCA(wclim, spca = TRUE, nComp = 3)
# Let's take a look at the results for the top three PCs
plots <- lapply(1:3, function(x) ggR(env_pcs$map, x, geom_raster = TRUE))
plots[[1]] 
ggRGB(env_pcs$map, 1, 2, 3, stretch = "lin", q = 0)

#create raster from coords for WINGEN
raster <- coords_to_raster(coords, res = 1)
plot(raster, axes = FALSE)
points(coords, pch = 19)

#calculate environmental distances
env <- raster::extract(env_pcs$map, coords)
env_dist <- env_dist(env)
plot(env_dist$PC1)



#getting geogrpahic distance
geo_dist <- geo_dist(coords, type = "Euclidean")
# Make a fun heat map with the pairwise distances
geo_dist <- as.data.frame(geo_dist)
colnames(geo_dist) <- rownames(geo_dist)


CA.OR_lyr <- coords_to_raster(coords, buffer = 1, plot = TRUE)



#================================================================
#here we are getting all the genetic data

#getting genotype dosage matrix
library(vcfR)
vcf <- read.vcfR("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/tess/G4t90_327_14chr_pruned0.2.vcf.vcf", verbose = FALSE )
#vcf <- read.vcfR("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.vcf.gz", verbose = FALSE )

print("vcfLoaded")
library(adegenet)
x = vcfR2genlight(vcf)
print("vcf converted")
rm(vcf)
df = data.frame(lapply(x@gen, as.integer))
genotype_matrix = t(as.matrix(df))
row.names(genotype_matrix) = NULL

#dosage <- vcf_to_dosage(genotype_matrix)

simple_dos <- simple_impute(genotype_matrix)

#simple_dos[is.na(simple_dos)] <- 0
#================================================================

# First, create a grid for kriging
# We can use one environmental layer (PC1), aggregated (i.e., increased cell size) to increase computational speed
krig_raster <- raster::aggregate(env_pcs$map[[1]], fact = 2)

# If you want to see the difference between the non-aggregated (original) and aggregated rasters:
#terra::plot(env_pcs$map[[1]], col = mako(100), axes = FALSE, xlim=c(-125, -114), ylim=c(32, 47))


sum(is.na(simple_dos))
sum(is.na(coords))

# Set to 500 GB, for example
options(future.globals.maxSize = 500000 * 1024^2)
# 1024^2 calculates the number of bytes in a megabyte (1024 bytes per kilobyte, and 1024 kilobytes per megabyte). 4000 is the approx. number of megabytes in 4 gigabytes



# Busing auto to select more reasonable estimate for the "best" K compared to manual selection
tess3_result <- tess_ktest(simple_dos, coords, Kvals = 1:10, ploidy = 2, K_selection = "auto")



#Get TESS object and best K from results
tess3_obj <- tess3_result$tess3_obj
bestK <- tess3_result[["K"]]

# Get Qmatrix with ancestry coefficients
qmat <- qmatrix(tess3_obj, K = bestK)

#krige Q values
krig_admix <- tess_krig(qmat, coords, krig_raster)

write.csv(qmat, "tess_qmat.csv", row.names=FALSE, quote=FALSE) 
write.csv(krig_admix, "tess_krig-admix.csv", row.names=FALSE, quote=FALSE) 


pdf("tess_ggbarplot.pdf")
tess_ggbarplot(qmat, legend = FALSE)
dev.off()

pdf("tess_maxQ.pdf")
par(mfrow = c(2, 2), pty = "s", mar = rep(0, 4))
tess_ggplot(krig_admix, plot_method = "maxQ")
dev.off()

pdf("tess_minQ.pdf")
tess_ggplot(krig_admix, plot_method = "allQ_poly", minQ = 0.10)
dev.off()

pdf("tess_sepQvals.pdf")
#plot all Q values seperately
par(mfrow = c(1, nlyr(krig_admix)), mar = rep(2, 4), oma = rep(1, 4))
tess_plot_allK(krig_admix, col_breaks = 20, legend.width = 2, xlim=c(-125, -114), ylim=c(32, 47))
dev.off()








