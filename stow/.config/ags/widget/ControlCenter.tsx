import { Gtk } from "ags/gtk4"
import { exec } from "ags/process"
import { createPoll } from "ags/time"

function QuickSettingButton({ icon, label, active = false, onClick }: any) {
  return (
    <button
      class={`quick-setting ${active ? "active" : ""}`}
      onClicked={onClick || (() => {})}
    >
      <box spacing={10} halign={Gtk.Align.START}>
        <box class="icon-circle" hexpand vexpand>
          <label
            label={icon}
            class="quick-setting-icon"
            halign={Gtk.Align.CENTER}
            valign={Gtk.Align.CENTER}
            hexpand
            vexpand
          />
        </box>
        <label label={label} class="quick-setting-label" />
      </box>
    </button>
  )
}

export default function ControlCenter() {
  const audioState = createPoll({ volume: 50, muted: false }, 200, () => {
    try {
      // wpctl outputs: "Volume: 0.50" or "Volume: 0.50 [MUTED]"
      const output = exec("wpctl get-volume @DEFAULT_AUDIO_SINK@")
      const volumeMatch = output.match(/Volume: ([0-9.]+)/)
      const muted = output.includes("[MUTED]")

      if (volumeMatch) {
        return {
          volume: Math.round(parseFloat(volumeMatch[1]) * 100),
          muted,
        }
      }
      return { volume: 50, muted: false }
    } catch (e) {
      return { volume: 50, muted: false }
    }
  })

  const volumeAdjustment = new Gtk.Adjustment({ lower: 0, upper: 100, value: 50 })
  let lastUserChange = 0

  // Update adjustment when volume changes
  setInterval(() => {
    const now = Date.now()
    // Only update if user hasn't interacted in the last 500ms
    if (now - lastUserChange > 500) {
      const state = audioState()
      volumeAdjustment.value = state.volume
    }
  }, 200)

  return (
    <box orientation={Gtk.Orientation.VERTICAL} spacing={12} class="control-center">
      {/* Quick Settings Grid */}
      <box orientation={Gtk.Orientation.VERTICAL} spacing={8} class="quick-settings">
        <box spacing={8} homogeneous>
          <QuickSettingButton
            icon=""
            label="Wi-Fi"
            onClick={() => exec("nm-connection-editor")}
          />
          <QuickSettingButton
            icon="󰂯"
            label="Bluetooth"
            onClick={() => exec("blueman-manager")}
          />
        </box>
      </box>

      {/* Volume Slider */}
      <box spacing={12} class="slider-row">
        <button
          class="volume-icon-button"
          onClicked={() => exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")}
        >
          <label
            label={audioState((state) => (state.muted ? "󰖁" : "󰕾"))}
            class="slider-icon"
          />
        </button>
        <Gtk.Scale
          hexpand
          orientation={Gtk.Orientation.HORIZONTAL}
          adjustment={volumeAdjustment}
          onChangeValue={(self) => {
            lastUserChange = Date.now()
            const value = Math.round(self.adjustment.value)
            const decimal = (value / 100).toFixed(2)
            exec(`wpctl set-volume @DEFAULT_AUDIO_SINK@ ${decimal}`)
            return false
          }}
        />
      </box>
    </box>
  )
}
