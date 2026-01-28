import { Gtk } from "ags/gtk4"
import { exec } from "ags/process"
import { createPoll } from "ags/time"

function getSystemStatus() {
  try {
    // Get battery info
    const battery = exec("cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 100").trim()

    // Get volume
    const volume = exec("pamixer --get-volume 2>/dev/null || echo 50").trim()

    // Get brightness
    const brightness = exec("brightnessctl g 2>/dev/null || echo 50").trim()
    const maxBrightness = exec("brightnessctl m 2>/dev/null || echo 100").trim()
    const brightnessPercent = Math.round((parseInt(brightness) / parseInt(maxBrightness)) * 100)

    return { battery, volume: parseInt(volume), brightness: brightnessPercent }
  } catch (e) {
    return { battery: "100", volume: 50, brightness: 50 }
  }
}

function QuickSettingButton({ icon, label, active = false, onClick }: any) {
  return (
    <button
      class={`quick-setting ${active ? "active" : ""}`}
      onClicked={onClick || (() => {})}
    >
      <box spacing={10} halign={Gtk.Align.START}>
        <label label={icon} class="quick-setting-icon" />
        <label label={label} class="quick-setting-label" />
      </box>
    </button>
  )
}

export default function ControlCenter() {
  return (
    <box orientation={Gtk.Orientation.VERTICAL} spacing={12} class="control-center">
      {/* Quick Settings Grid */}
      <box orientation={Gtk.Orientation.VERTICAL} spacing={8} class="quick-settings">
        <box spacing={8} homogeneous>
          <QuickSettingButton
            icon="󰖩"
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
        <label label="󰕾" class="slider-icon" />
        <Gtk.Scale
          hexpand
          orientation={Gtk.Orientation.HORIZONTAL}
          adjustment={new Gtk.Adjustment({ lower: 0, upper: 100, value: 50 })}
        />
      </box>
    </box>
  )
}
