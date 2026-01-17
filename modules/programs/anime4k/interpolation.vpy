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
clip = video_in
log(f"Got video_in: {clip.format}")

# 1️⃣ Declare source color properties (CRITICAL)
clip = core.std.SetFrameProps(
    clip,
    _Matrix=1,      # BT.709
    _Transfer=1,    # BT.709
    _Primaries=1,   # BT.709
    _ColorRange=1  # limited
)

# 2️⃣ Convert to a MVTools-friendly SDR format
clip = core.resize.Bicubic(
    clip,
    format=vs.YUV420P8,
    matrix_s="709",
    transfer_s="709",
    primaries_s="709",
    range_s="limited"
)

# Ensure clip has valid FPS
if clip.fps_num == 0 or clip.fps_den == 0:
    clip = core.std.AssumeFPS(clip, fpsnum=24000, fpsden=1001)

log(f"Source FPS: {clip.fps_num}/{clip.fps_den}")

# Motion analysis
super = core.mv.Super(clip, pel=2)
backward = core.mv.Analyse(super, isb=True, blksize=16)
forward = core.mv.Analyse(super, isb=False, blksize=16)
log("Motion analysis complete")

# Interpolate to 60fps
clip = core.mv.FlowFPS(clip, super, backward, forward, num=60, den=1)
log(f"Interpolation complete - Output: {clip.fps_num}/{clip.fps_den}")

# 3️⃣ Reassert SDR metadata after MVTools
clip = core.std.SetFrameProps(
    clip,
    _Matrix=1,
    _Transfer=1,
    _Primaries=1,
    _ColorRange=1
)

clip.set_output()
