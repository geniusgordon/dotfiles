import { Gtk } from "ags/gtk4"
import type { NotificationItemProps } from "./types"

export default function NotificationItem({
  appIcon,
  summary,
  time,
  body,
  visible,
  onDismiss,
  className = "notification-item",
}: NotificationItemProps) {
  return (
    <box visible={visible} >
      <box spacing={10} halign={Gtk.Align.START} class={className}>
        <box class="notification-icon" hexpand vexpand>
          <label
            label={appIcon}
            halign={Gtk.Align.CENTER}
            valign={Gtk.Align.CENTER}
            hexpand
            vexpand
          />
        </box>
        <box orientation={Gtk.Orientation.VERTICAL} hexpand spacing={4}>
          <box spacing={8} halign={Gtk.Align.START}>
            <label
              label={summary}
              class="notification-title"
              hexpand
              halign={Gtk.Align.START}
              wrap
            />
            <label label={time} class="notification-time" halign={Gtk.Align.END} />
          </box>
          <label label={body} class="notification-body" halign={Gtk.Align.START} wrap />
        </box>
        <button class="notification-dismiss" onClicked={onDismiss} valign={Gtk.Align.START}>
          <label label="×" />
        </button>
      </box>
    </box>
  )
}
