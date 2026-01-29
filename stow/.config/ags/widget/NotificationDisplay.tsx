import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import {
  notificationService,
  type NotificationGroup,
  getAppIcon,
  formatTime,
  truncate,
} from "../service/Notifications"
import { NotificationItem } from "./notification"

const MAX_GROUPS = 3
const MAX_PER_GROUP = 3

function NotificationGroupDisplay({ index }: { index: number }) {
  const groups = createPoll([] as NotificationGroup[], 500, () => notificationService.getGrouped())

  return (
    <box
      orientation={Gtk.Orientation.VERTICAL}
      class="notification-group"
      spacing={6}
      visible={groups((g) => index < g.length)}
    >
      {/* Group header */}
      <box spacing={8} class="notification-group-header">
        <box class="group-icon" hexpand vexpand>
          <label
            label={groups((g) => g[index]?.appIcon || "")}
            halign={Gtk.Align.CENTER}
            valign={Gtk.Align.CENTER}
            hexpand
            vexpand
          />
        </box>
        <label
          label={groups((g) => g[index]?.appName || "")}
          class="group-name"
          hexpand
          halign={Gtk.Align.START}
        />
        <label
          label={groups((g) => (g[index] ? `${g[index].notifications.length}` : ""))}
          class="group-count"
          halign={Gtk.Align.END}
        />
      </box>

      {/* Notification slots */}
      <box orientation={Gtk.Orientation.VERTICAL} spacing={6}>
        {Array.from({ length: MAX_PER_GROUP }, (_, i) => (
          <NotificationItem
            visible={groups((g) => {
              const group = g[index]
              return group ? i < group.notifications.length : false
            })}
            appIcon={groups((g) => {
              const n = g[index]?.notifications[i]
              return n ? getAppIcon(n.app_name || "", n.app_icon || "") : ""
            })}
            summary={groups((g) => g[index]?.notifications[i]?.summary || "")}
            time={groups((g) => {
              const n = g[index]?.notifications[i]
              return n ? formatTime(n.time) : ""
            })}
            body={groups((g) => {
              const n = g[index]?.notifications[i]
              return n ? truncate(n.body || "", 100) : ""
            })}
            onDismiss={() => {
              const g = groups()
              const n = g[index]?.notifications[i]
              if (n) n.dismiss()
            }}
            className="notification-group-item"
          />
        ))}
      </box>

      {/* "X more" indicator */}
      <label
        label={groups((g) => {
          const group = g[index]
          if (!group) return ""
          const remaining = group.notifications.length - MAX_PER_GROUP
          return remaining > 0 ? `+${remaining} more` : ""
        })}
        class="notification-more"
        halign={Gtk.Align.CENTER}
        visible={groups((g) => {
          const group = g[index]
          return group ? group.notifications.length > MAX_PER_GROUP : false
        })}
      />
    </box>
  )
}

export default function NotificationDisplay() {
  return (
    <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
      {Array.from({ length: MAX_GROUPS }, (_, i) => (
        <NotificationGroupDisplay index={i} />
      ))}
    </box>
  )
}
