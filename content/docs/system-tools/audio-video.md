---
title: "audio/video"
linkTitle: "audio-video"
date: 2017-01-05
---

### FFmpeg


wav to mp3


ffmpeg -i audio.wav audio.mp3



Par exemple, on peut passer d’une vidéo Full-HD à HD (ou inférieur), et/ou à un bitrate de 1500 Kb/s avec les options :
-𝘀 pour choisir la taille
et
-𝗯:𝘃 pour choisir le bitrate video

Par exemple :
ffmpeg -i mavideo-depart.mp4 -s 1280x720 -b:v 1500k mavideo-modifiee.mp4



Autre action souvent demandée : extraire l’audio d’une vidéo.
On utilisera les options :
-𝘃𝗻 pour désactiver la vidéo et récupérer l'audio seul
-𝗯:𝗮 pour définir le bitrate audio (par exemple 192 Kb/s)
dans la commande suivante :
ffmpeg -i video.mp4 -vn -b:a 192k audio.mp3




Découper un extrait à un endroit précis :
– définir le début avec l’option -𝘀𝘀
– définir la fin avec -𝘁𝗼
puis utiliser la commande suivante, par exemple pour découper un extrait allant de 2’15’’ à 3’52’’
ffmpeg -i mavideo.mp4 -ss 00:02:15 -to 00:03:52 mon-extrait-video.mp4



### youtube-dl
