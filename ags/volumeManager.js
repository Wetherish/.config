const { getVolume, setVolume, toggleMute } = await Service.import("volume-control")
const WINDOW_NAME = "volumeManager"

/** @param {number} volume */
const VolumeSlider = volume => Widget.Scale({
    value: volume,
    on_value_changed: scale => setVolume(scale.value),
    draw_value: false,
    orientation: "horizontal",
    round_digits: 0,
    lower: 0,
    upper: 100,
    step_increment: 1,
    value_pos: "top",
    hexpand: true,
})

const MuteButton = ({ isMuted }) => Widget.Button({
    on_clicked: toggleMute,
    child: Widget.Icon({
        icon: isMuted ? "audio-volume-muted" : "audio-volume-high",
        size: 42,
    }),
})

const VolumeManager = ({ width = 500, height = 200, spacing = 12 }) => {
    let currentVolume = getVolume()
    let isMuted = currentVolume === 0

    const volumeSlider = VolumeSlider(currentVolume)
    const muteButton = MuteButton({ isMuted })

    function updateVolume() {
        currentVolume = getVolume()
        isMuted = currentVolume === 0
        volumeSlider.value = currentVolume
        muteButton.child.icon = isMuted ? "audio-volume-muted" : "audio-volume-high"
    }

    return Widget.Box({
        vertical: true,
        css: `margin: ${spacing * 2}px;`,
        children: [
            Widget.Label({
                class_name: "title",
                label: "Volume Manager",
                xalign: 0,
                vpack: "center",
                truncate: "end",
                css: `margin-bottom: ${spacing}px;`,
            }),
            Widget.Box({
                vertical: false,
                spacing,
                children: [
                    muteButton,
                    volumeSlider,
                ],
            }),
        ],
        setup: self => self.hook(App, (_, windowName, visible) => {
            if (windowName !== WINDOW_NAME)
                return

            if (visible) {
                updateVolume()
                volumeSlider.grab_focus()
            }
        }),
    })
}

// there needs to be only one instance
export const volumeManager = Widget.Window({
    name: WINDOW_NAME,
    setup: self => self.keybind("Escape", () => {
        App.closeWindow(WINDOW_NAME)
    }),
    visible: false,
    keymode: "exclusive",
    child: VolumeManager({
        width: 500,
        height: 200,
        spacing: 12,
    }),
})
