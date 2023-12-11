ffmpeg -nostats -loglevel 0 -vaapi_device /dev/dri/renderD128 -f x11grab -video_size 1920x1080 -i :0 -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor -r 60 -vf 'hwupload,scale_vaapi=format=nv12' -c:v h264_vaapi -qp 0 -c:a aac ~/Videos/$(date +'%Y-%m-%d-%T')-record.mp4

