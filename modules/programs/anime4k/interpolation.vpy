import vapoursynth as vs
from vapoursynth import core
import os
import sys

# Debug logging
def log(msg):
    with open('/tmp/vapoursynth-debug.log', 'a') as f:
        f.write(f"{msg}\n")

log("=== VapourSynth script started ===")

# Load MVTools plugin explicitly
mvtools_paths = [
    os.path.expanduser('~/.local/lib/vapoursynth/libmvtools.so'),
    '/nix/store/xrgmywyzsnh6z6fvfjzqpadzbwk1082s-vapoursynth-mvtools-24/lib/vapoursynth/libmvtools.so',
]

for path in mvtools_paths:
    if os.path.exists(path):
        try:
            core.std.LoadPlugin(path)
            log(f"Loaded MVTools from: {path}")
            break
        except Exception as e:
            log(f"Failed to load {path}: {e}")

# Get video from mpv
try:
    clip = video_in
    log(f"Got video_in: {clip.format}")
except Exception as e:
    log(f"Failed to get video_in: {e}")
    raise

# Get target FPS (default to 60 if not set)
try:
    dst_fps = display_fps
except:
    dst_fps = 60.0

# Convert to compatible format
clip = core.resize.Bicubic(clip, format=vs.YUV420P8)

# Ensure clip has valid FPS
if not hasattr(clip, 'fps') or clip.fps_num == 0 or clip.fps_den == 0:
    clip = core.std.AssumeFPS(clip, fpsnum=24000, fpsden=1001)

log(f"Source FPS: {clip.fps_num}/{clip.fps_den}")

# Create super clip and analyze motion
super = core.mv.Super(clip, pel=2)
backward = core.mv.Analyse(super, isb=True, blksize=16)
forward = core.mv.Analyse(super, isb=False, blksize=16)
log("Motion analysis complete")

# Interpolate to 165fps for high refresh rate displays
clip = core.mv.FlowFPS(clip, super, backward, forward, num=60, den=1)
log(f"Interpolation complete - Output: {clip.fps_num}/{clip.fps_den}")

clip.set_output()