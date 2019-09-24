# RandomProjects
Here is some stuff I made for some reason
seperatestreams.sh is a bash script that seperates individual audio streams from an mkv video container into wav audio files.
The script uses the [ffmpeg](https://ffmpeg.org/) multimedia framework.
It does not yet support an arbitrary number of audio streams although, it can be easily modified to suit your use case.
usage: 
```
seperatestreams.sh "source file or directory" "optional destination directory"
```
