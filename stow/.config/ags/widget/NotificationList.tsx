import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import AstalNotifd from "gi://AstalNotifd"
import {
  notificationService,
  getAppIcon,
  formatTime,
  truncate,
} from "../service/Notifications"
import { NotificationItem } from "./notification"

export default function NotificationList() {
  const allNotifications = createPoll([] as AstalNotifd.Notification[], 500, () => {
    const notifd = notificationService.getNotifd()
    return notifd.get_notifications()
  })

  return (
    <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
      <label
        label={allNotifications((notifs) => `${notifs.length} notification(s)`)}
        class="notification-count"
        halign={Gtk.Align.CENTER}
      />
      <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
        {Array.from({ length: 5 }, (_, i) => (
          <NotificationItem
            visible={allNotifications((notifs) => i < notifs.length)}
            appIcon={allNotifications((notifs) => {
              const n = notifs[i]
              return n ? getAppIcon(n.app_name || "", n.app_icon || "") : ""
            })}
            summary={allNotifications((notifs) => notifs[i]?.summary || "")}
            time={allNotifications((notifs) => {
              const n = notifs[i]
              return n ? formatTime(n.time) : ""
            })}
            body={allNotifications((notifs) => {
              const n = notifs[i]
              return n ? truncate(n.body || "", 100) : ""
            })}
            onDismiss={() => {
              const notifs = allNotifications()
              const n = notifs[i]
              if (n?.dismiss) n.dismiss()
            }}
            className="notification-card"
          />
        ))}
      </box>
    </box>
  )
}
