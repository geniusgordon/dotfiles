import { Astal, Gtk } from "ags/gtk4"
import AstalNotifd from "gi://AstalNotifd"
import app from "ags/gtk4/app"
import { notificationService, getAppIcon } from "../service/Notifications"

function NotificationPopupItem({ notification }: { notification: AstalNotifd.Notification }) {
  const appIcon = getAppIcon(notification.app_name || "", notification.app_icon || "")

  return (
    <box class="popup-content" spacing={12}>
      <box class="popup-icon" valign={Gtk.Align.START}>
        <label label={appIcon} />
      </box>
      <box orientation={Gtk.Orientation.VERTICAL} spacing={4} hexpand valign={Gtk.Align.START}>
        <label
          label={notification.summary || ""}
          class="popup-title"
          halign={Gtk.Align.START}
          wrap
        />
        <label label={notification.body || ""} class="popup-body" halign={Gtk.Align.START} wrap />
      </box>
      <button class="popup-close" onClicked={() => notification.dismiss()}>
        <label label="×" />
      </button>
    </box>
  )
}

export default function NotificationPopup() {
  const notifd = notificationService.getNotifd()

  return (
    <window
      name="notification-popup"
      class="notification-popup"
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      layer={Astal.Layer.OVERLAY}
      exclusivity={Astal.Exclusivity.NORMAL}
      application={app}
      visible={false}
    >
      <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
        {notifd.get_notifications().map((notif) => (
          <NotificationPopupItem notification={notif} />
        ))}
      </box>
    </window>
  )
}
