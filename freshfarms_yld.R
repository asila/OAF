library(reshape2)
sample <- read.csv("~/rres2/data/Batch 1 and Batch 2 Bumula and Bunambobi soil samples of 70 farms send to  RRes micro.csv")

yld <- read.csv("~/rres2/data/finalSample_final.csv")

fos <- read.csv("~/rres2/data/Yield four seasons.csv")

fosm <- melt (fos, id.vars=c("ex.id","tag"))
pp <- acast(fosm, ex.id ~ tag ~variable)

Yc <- as.data.frame(pp[,,1])
Yt <- as.data.frame(pp[,,2])
Yr <- as.data.frame(pp[,,3])
Yc$ex.id <- row.names(Yc)
Yt$ex.id <- row.names(Yt)
Yr$ex.id <- row.names(Yr)

Yc <- Yc[,c("ex.id","SR2015","LR2016","SR2016")]
Yt <- Yt[,c("ex.id","SR2015","LR2016","SR2016")]
Yr <- Yr[,c("ex.id","SR2015","LR2016","SR2016")]


sam.yld <- merge(sample,yld, by.y ="Group.1" ,by.x = "Site.OAFID")
Yc$ex.id <- paste0("farm ",Yc$ex.id)
colnames(Yc) <- c("ex.id",paste0(colnames(Yc[,-1]),"_Yc"))
sam.yld <- merge(sam.yld,Yc)

Yt$ex.id <- paste0("farm ",Yt$ex.id)
colnames(Yt) <- c("ex.id",paste0(colnames(Yt[,-1]),"_Yt"))
sam.yld <- merge(sam.yld,Yt)

Yr$ex.id <- paste0("farm ",Yr$ex.id)
colnames(Yr) <- c("ex.id",paste0(colnames(Yr[,-1]),"_Yr"))
sam.yld <- merge(sam.yld,Yr)

write.table(sam.yld, file = "~/rres2/data/Sampled farms with season yld data.csv", sep = ",", row.names = FALSE)


p <- which(!sample$Site.OAFID%in%yld$Group.1)

sample[p,1:4]

write.table(na.omit(sample[p,]), file = "~/rres2/data/Sampled farms missing yld data.csv", sep = ",", row.names = FALSE)

write.table(sam.yld, file = "~/rres2/data/Sampled farms with yld data.csv", sep = ",", row.names = FALSE)