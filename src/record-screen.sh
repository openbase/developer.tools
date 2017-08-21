#/bin/bash


prefix="/home/$USER/screenrecord/"

# create save folder if not exists.
mkdir -p $prefix

echo "DISPLAY used for capturing: ${DISPLAY}"

thedate=`date '+%y-%m-%d--%H-%M-%S'`
filename="${prefix}/${thedate}.mkv"

echo "Starting screen record to file ${filename} ..."

ffmpeg -s 1920x1080 -r 15 -f x11grab -i :0.0 -an -r 15 -preset ultrafast -crf 0 -pix_fmt yuv420p ${filename}

