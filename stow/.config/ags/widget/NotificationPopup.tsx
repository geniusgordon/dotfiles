import { Astal, Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import { notificationService, getAppIcon } from "../service/Notifications"
import { NotificationItem } from "./notification"

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
        {notifd.get_notifications().map((notif: any) => (
          <NotificationItem
            appIcon={getAppIcon(notif.app_name || "", notif.app_icon || "")}
            summary={notif.summary || ""}
            time=""
            body={notif.body || ""}
            onDismiss={() => notif.dismiss()}
            className="popup-content"
          />
        ))}
      </box>
    </window>
  )
}
