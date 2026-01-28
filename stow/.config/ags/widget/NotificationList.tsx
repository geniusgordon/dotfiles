import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import AstalNotifd from "gi://AstalNotifd"
import {
  notificationService,
  getAppIcon,
  formatTime,
  truncate,
} from "../service/Notifications"

export default function NotificationListSimple() {
  // Poll for all notifications
  const allNotifications = createPoll([] as any[], 500, () => {
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
      {[0, 1, 2, 3, 4].map((index) => (
        <box
          class="notification-card"
          spacing={10}
          visible={allNotifications((notifs) => index < notifs.length)}
        >
          <box class="notification-icon" valign={Gtk.Align.START}>
            <label
              label={allNotifications((notifs) => {
                const notif = notifs[index]
                return notif ? getAppIcon(notif.app_name || "", notif.app_icon || "") : ""
              })}
            />
          </box>
          <box orientation={Gtk.Orientation.VERTICAL} hexpand spacing={4}>
            <box spacing={8} halign={Gtk.Align.START}>
              <label
                label={allNotifications((notifs) => notifs[index]?.summary || "")}
                class="notification-title"
                hexpand
                halign={Gtk.Align.START}
                wrap
              />
              <label
                label={allNotifications((notifs) =>
                  notifs[index] ? formatTime(notifs[index].time) : ""
                )}
                class="notification-time"
                halign={Gtk.Align.END}
              />
            </box>
            <label
              label={allNotifications((notifs) =>
                notifs[index] ? truncate(notifs[index].body || "", 100) : ""
              )}
              class="notification-body"
              halign={Gtk.Align.START}
              wrap
            />
          </box>
          <button
            class="notification-dismiss"
            onClicked={() => {
              const notifs = allNotifications()
              const notif = notifs[index]
              if (notif && notif.dismiss) {
                notif.dismiss()
              }
            }}
            valign={Gtk.Align.START}
          >
            <label label="×" />
          </button>
        </box>
      ))}
    </box>
  )
}
