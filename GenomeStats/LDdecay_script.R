library(dplyr)
library(stringr)
library(ggplot2)

setwd("/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD")
# Set to 4 GB, for example
options(future.globals.maxSize = 500000 * 1024^2)


LD <- read.table("allChr_decaystats_pruned.txt", header = FALSE, colClasses = c("integer", "numeric"))
colnames(LD) <- c("dist","R2")

LD$distc <- cut(LD$dist,breaks=seq(from=min(LD$dist)-1,to=max(LD$dist)+1,by=100))

LD1 <- LD %>% group_by(distc) %>% summarise(mean=mean(R2),median=median(R2))
LD1 <- LD1 %>% mutate(start=as.integer(str_extract(str_replace_all(distc,"[\\(\\)\\[\\]]",""),"^[0-9-e+.]+")),
                        end=as.integer(str_extract(str_replace_all(distc,"[\\(\\)\\[\\]]",""),"[0-9-e+.]+$")),
                        mid=start+((end-start)/2))

pdf("LDdecay.pdf")
ggplot()+
  geom_point(data=LD1,aes(x=start,y=mean),size=2,colour="grey20")+
  geom_line(data=LD1,aes(x=start,y=mean),size=2,alpha=0.5,colour="grey40")+
  labs(x="Distance (bases)",y=expression(LD~(r^{2})))+
  scale_x_continuous(breaks=c(0,1000,5000,10000,15000),labels=c("0","1kb","5kb","10kb","15kb"), limits = c(0, 20000))+
  theme_bw()+ theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
dev.off()


