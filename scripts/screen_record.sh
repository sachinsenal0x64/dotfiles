ffmpeg -nostats -loglevel 0 -vaapi_device /dev/dri/renderD128 -f x11grab -video_size 1920x1080 -i :0 -f pulse -i 46 -r 60  -vf 'format=nv12,hwupload' -b:v 12M -b:a 192k -c:v h264_vaapi -qp 1 -c:a aac ~/Videos/$(date +'%Y-%m-%d-%T')-record.mp4

