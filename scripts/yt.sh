#!/usr/bin/env fish
# ytm-flac.fish — Download a single track from YouTube/YouTube Music to FLAC with cover
# Output: /home/pc/Music

if test (count $argv) -lt 1
    echo "Usage: ytm-flac.fish <url>"
    exit 1
end

set URL $argv[1]
set OUTDIR "/home/pc/Music"
set TEMPLATE "%(artist|uploader)s - %(title)s"

# Check dependencies
for bin in yt-dlp ffmpeg
    if not type -q $bin
        echo "✖ Missing dependency: $bin"
        echo "  Install on Arch: sudo pacman -S yt-dlp ffmpeg"
        exit 127
    end
end

mkdir -p "$OUTDIR"

yt-dlp --cookies-from-browser chrome  \
    -f bestaudio/best \
    -x --audio-format flac \
    --add-metadata \
    --embed-thumbnail \
    --write-thumbnail \
    --convert-thumbnails jpg \
    --no-playlist \
    --output "$OUTDIR/$TEMPLATE.%(ext)s" \
    --postprocessor-args "FFmpegExtractAudio:-compression_level 12" \
    "$URL"

