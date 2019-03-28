# bonnarhythms
A R+Python project to craft a playlist that represents the rhythms of the Bonnaroo 2019 lineup

Result ~ https://open.spotify.com/playlist/6hLQ3q1Rq7o0gmmJCQGuyf

### Thanks to the open source community that made this algorhytmic playlist possible
Spotify: https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/

spotipy: https://spotipy.readthedocs.io/en/latest/

pam clustering: https://www.rdocumentation.org/packages/cluster/versions/2.0.7-1/topics/pam

### Background
After previous experiments working with the Spotify API in R, I wanted to dive into a tangible use case for a cross-toolkit project: crafting the perfect playlist for events. Music festival lineups provide a perfect "universe" of sound. And the "OFFICIAL" playlists only loosely capture broad "genres" of artists that would be performing: https://www.bonnaroo.com/news/official-bonnaroo-playlists-2019/

Unofficially, I was committed to making something better. :) The Spotify API enables users to retrieve the Top 10 tracks of an artist (by their name), and each track has audio features on which quantitative analysis can be peformed:
* acousticness
* danceability
* energy
* instrumentalness
* liveness
* loudness
* speachiness
* valence
* tempo

### Process
The algorhythm of choice for this project was Partitioning Around Medoids -- a mathematical tool for identifying representative observations in a dataset through clustering. From a set of 1009 songs, the clustering algorhythm identified the 100 tracks that would act as the most representative "centers" of each cluster of music. In this sense, each track in the resulting playlist best represents the ~10 songs that are closest to it in terms of audio features. 

Data was standardized and PCA was applied (with 90% of variance retained) to ensure orthogonality ahead of clustering. Euclidean distance was used. 

### Results and Next steps
The playlist freakin' rocks and captures many of the heavy hitters. We see the emergence of a very large field of "dancey" music along with most variance in the acoustic/instrumental ranges. This process could be extended to have just a subset of artists as an input to the algorhythm (as opposed to the whole lineup), so you can create a Roo playlist based on the specific schedule of artists you want to see. 
