# RandomProjects
Here is some stuff I made for some reason\
creq.sh is a shell script that lists the dependencies for any *.c in your current directory and subdirectories.
Add it to a directory in your $PATH to use anywhere!
usage:
```
creq.sh
```

seperatestreams.sh is a bash script that seperates individual audio streams from an mkv video container into wav audio files.\
The script uses the [ffmpeg](https://ffmpeg.org/) multimedia framework.\
It does not yet support an arbitrary number of audio streams although, it can be easily modified to suit your use case.\
usage:
```
seperatestreams.sh "source file or directory" "optional destination directory"
```
