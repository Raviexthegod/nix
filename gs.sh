#!/usr/bin/env bash
set -xeuo pipefail

gamescopeArgs=(
    --adaptive-sync
    --hdr-enabled
    --mangoapp
    --rt
    --steam
)
steamArgs=(
    -pipewire-dmabuf
    -tenfoot
)
mangoConfig=(
    legacy_layout=false
    offset_x=5
    gpu_stats
    gpu_load_change
    vram
    gpu_temp
    gpu_fan
    gpu_power
    cpu_stats
    cpu_load_change
    cpu_mhz
    cpu_temp
    ram
    fps
    fps_color_change
    fsr
    hdr
    gpu_name
    refresh_rate
    resolution
    engine_short_names
    frame_timing
    media_player
    wine
    toggle_logging=Shift_L+F2
    toggle_hud_position=Shift_R+F11
    fps_limit_method=late
    toggle_fps_limit=Shift_L+F1
    fps_limit=0,30,60
    vsync=0
    gl_vsync=-1
    round_corners=7
    background_alpha=0.4
    position=top-left
    gpu_text=GPU
    gpu_color=2e9762
    cpu_text=CPU
    cpu_color=2e97cb
    fps_value=30,60
    fps_color=ff0000,fdfd09,ffffff
    gpu_load_value=30,60
    gpu_load_color=ffffff,ffaa7f,cc0000
    cpu_load_value=30,60
    cpu_load_color=ffffff,ffaa7f,cc0000
    background_color=000000
    frametime_color=00edff
    vram_color=ad64c1
    ram_color=c26693
    wine_color=eb4b4b
    engine_color=eb5b5b
    text_color=ffffff
    media_player_color=ffffff
    network_color=e07b85
    battery_color=92e79a
    media_player_format={title};{artist};{album}
)
mangoVars=(
    MANGOHUD=1
    MANGOHUD_CONFIG="$(IFS=,; echo "${mangoConfig[*]}")"
)

export "$(mangoVars[@])"
exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}"