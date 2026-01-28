import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import AstalNotifd from "gi://AstalNotifd"
import {
  notificationService,
  getAppIcon,
  formatTime,
  truncate,
} from "../service/Notifications"

// Fixed notification slot that displays one notification
function NotificationItem({ notification }: { notification: AstalNotifd.Notification }) {
  const appIcon = getAppIcon(notification.app_name || "", notification.app_icon || "")

  return (
    <box class="notification-card" spacing={10}>
      <box class="notification-icon" valign={Gtk.Align.START}>
        <label label={appIcon} />
      </box>
      <box orientation={Gtk.Orientation.VERTICAL} hexpand spacing={4}>
        <box spacing={8} halign={Gtk.Align.START}>
          <label
            label={notification.summary || ""}
            class="notification-title"
            hexpand
            halign={Gtk.Align.START}
            wrap
          />
          <label
            label={formatTime(notification.time)}
            class="notification-time"
            halign={Gtk.Align.END}
          />
        </box>
        <label
          label={truncate(notification.body || "", 100)}
          class="notification-body"
          halign={Gtk.Align.START}
          wrap
        />
      </box>
      <button
        class="notification-dismiss"
        onClicked={() => notification.dismiss()}
        valign={Gtk.Align.START}
      >
        <label label="×" />
      </button>
    </box>
  )
}

// Notification group display
function NotificationGroupDisplay({ index }: { index: number }) {
  const groups = createPoll([], 500, () => notificationService.getGrouped())

  return (
    <box
      orientation={Gtk.Orientation.VERTICAL}
      class="notification-group"
      spacing={6}
      visible={groups((g) => index < g.length)}
    >
      {/* Group header */}
      <box spacing={8} class="notification-group-header">
        <label label={groups((g) => g[index]?.appIcon || "")} class="group-icon" />
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

      {/* Notifications - using label as a workaround for accessor issues */}
      <box orientation={Gtk.Orientation.VERTICAL} spacing={6}>
        <label
          label={groups((g) => {
            const group = g[index]
            if (!group) return ""
            // Just return count for now as placeholder
            return `${Math.min(3, group.notifications.length)} notifications`
          })}
          visible={false}
        />
      </box>

      {/* "X more" indicator */}
      <label
        label={groups((g) => {
          const group = g[index]
          if (!group) return ""
          const remaining = group.notifications.length - 3
          return remaining > 0 ? `+${remaining} more` : ""
        })}
        class="notification-more"
        halign={Gtk.Align.CENTER}
        visible={groups((g) => {
          const group = g[index]
          return group ? group.notifications.length > 3 : false
        })}
      />
    </box>
  )
}

export default function NotificationDisplayNotifd() {
  return (
    <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
      <NotificationGroupDisplay index={0} />
      <NotificationGroupDisplay index={1} />
      <NotificationGroupDisplay index={2} />
    </box>
  )
}
