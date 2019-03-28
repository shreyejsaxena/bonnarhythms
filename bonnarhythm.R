library(tidyverse)
library(cluster)
# library(devtools)
# install_github("vqv/ggbiplot")
# library(ggbiplot)

# drop duplicate tracks
features = read.csv('/Users/i868290/Documents/bonnarhythm/features.csv' )
features = features[!duplicated(features['uri']),]

# extract auditory features with track uri as row name
audio = features[c('acousticness', 'danceability', 'energy', 'instrumentalness', 'liveness', 'loudness', 'speechiness', 'tempo', 'valence')]
rownames(audio) = unlist(features['uri'])

# standardize data and apply principal components analysis (90% variance explained)
audio_std = data.frame(apply(audio,2,function(x){center = min(x); spread = max(x) - min(x);list = (x - center)/spread;}))
audio_pca = prcomp(audio_std)

# create euclidian distance matrix
pca_cutoff = function(pca_sdev, cutoff=.9){
  num_pc = 0;
  for(i in 1:length(pca_sdev)) {
    num_pc = num_pc+1;
    if((sum(pca_sdev[1:i]^2)/sum(pca_sdev^2)) > cutoff) return(num_pc);
  }
}
df_pca = data.frame(pca$x[,1:pca_cutoff(pca$sdev, cutoff=.9)]) # use scores of principal components for clustering
dist = as.matrix(dist(df_pca,method = "euclidean"))

# identify 100 representative songs through PAM clustering
pam_fit = pam(dist, diss = TRUE, k = 100)
representatives = pam_fit$medoids
lapply(representatives, function(x) write.table( data.frame(x), '/Users/i868290/Documents/bonnarhythm/representatives.csv'  , append= T, sep=',' ))
