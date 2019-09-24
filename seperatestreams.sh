#!/bin/bash

fromfile() {
if [[ $# -ge 2 ]] ; then	
input=$1
dir="${2}/"
filename=$2
elif [[ $# -eq 1 ]] ; then
input=$1
dir=""
filename=$(basename -- "$input")
filename="${filename%.*}" 
fi
#ffmpeg -i /tmp/a.wav -map 0:a -b:a 64k /tmp/a.mp2 -map 0:a -b:a 128k /tmp/b.mp2
ffmpeg -i  $input -codec:v:0 -discard \
-map 0:1 -c:a pcm_s32le "${dir}${filename}audio1combo.wav" \
-map 0:2 -c:a pcm_s32le "${dir}${filename}audio2comp.wav" \
-map 0:3 -c:a pcm_s32le "${dir}${filename}audio3mic.wav"
}
fromdir() {
#find video file
	#parse files and types
for file in *
do	
	if [[ -f "$file" ]]; then
		echo "found file $file"
		#check extention
		if [[ $file =~ \.mkv$ ]] ; then
			filename=$(basename -- "$file")
			extension="${filename##*.}"
			filename="${filename%.*}"
			echo "$filename"
			echo "$extension"
		#create directory for file
			mkdir $filename
			mv $file $filename	
			file="$filename/$file"
			fromfile $file $filename
		fi
	fi
done
#TODO
	#seperate audio
	#done	#dynamic names for each stream ex. "videoname"audiostream#.type

	# seperate arbitrary number of audio streams
}
function dotest() {

video1=$2
streams=$(ffprobe -v error -show_entries  stream=index -of default=noprint_wrappers=1:nokey=1 $video1)

echo "${streams}"
#ffprobe -show_streams -select_streams a $video1  # stream=index,codec_type:stream_tags=language -of compact $video1 2>&1 | { while read line; do if $(echo "$line" | grep -q -i "stream #"); then echo "$line"; fi; done; while read -d $'\x0D' line; do if $(echo "$line" | grep -q "time="); then echo "$line" | awk '{ printf "%s\r", $8 }'; fi; done; }	


}
	#ffprobe -v error -show_entries stream=index,codec_name,codec_type $file 
	#echo $file
	#video1=$file		

	#	ffprobe -show_entries stream=index,codec_type -of compact $file 2>&1 | { while read line; do if $(echo "$line" | grep -q -i "stream #"); then echo "$line"; fi; done; while read -d $'\x0D' line; do if $(echo "$line" | grep -q "time="); then echo "$line" | awk '{ printf "%s\r", $8 }'; fi; done; }	


#video1=
#ffprobe -show_entries stream=index,codec_type:stream_tags=language -of compact $video1 2>&1 | { while read line; do if $(echo "$line" | grep -q -i "stream #"); then echo "$line"; fi; done; while read -d $'\x0D' line; do if $(echo "$line" | grep -q "time="); then echo "$line" | awk '{ printf "%s\r", $8 }'; fi; done; }	

function checkarg(){
#echo "checking args"
if [[ -f $1 ]] ; then
	echo "arg 1 is file"
	fromfile $@
elif [[ -d $1 ]] ; then
	echo "arg 1 is dir"
	fromdir $@
else
	dotest $@
fi
}

if [[ $# -ge 1 ]] ; then	
	checkarg $@
else
	echo "Error: Args must be either file or dir"
	exit 1
fi
	
