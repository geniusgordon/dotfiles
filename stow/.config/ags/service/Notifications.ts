import AstalNotifd from "gi://AstalNotifd"

// Utility functions
export function getAppIcon(appName: string, appIcon: string): string {
  // Map common app names to nerd font icons
  const iconMap: Record<string, string> = {
    "firefox": "󰈹",
    "chrome": "󰊯",
    "chromium": "󰊯",
    "spotify": "󰓇",
    "discord": "󰙯",
    "telegram": "󰔊",
    "slack": "󰒱",
    "code": "󰨞",
    "nautilus": "󰉋",
    "thunderbird": "󰇰",
  }

  const lowerAppName = appName.toLowerCase()
  for (const [key, icon] of Object.entries(iconMap)) {
    if (lowerAppName.includes(key)) {
      return icon
    }
  }

  // Default notification icon
  return "󰂚"
}

export function formatTime(timestamp: number): string {
  const now = Date.now() / 1000
  const diff = now - timestamp

  if (diff < 60) return "now"
  if (diff < 3600) return `${Math.floor(diff / 60)}m`
  if (diff < 86400) return `${Math.floor(diff / 3600)}h`
  return `${Math.floor(diff / 86400)}d`
}

export function truncate(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text
  return text.substring(0, maxLength) + "..."
}

export interface NotificationGroup {
  appName: string
  appIcon: string
  notifications: AstalNotifd.Notification[]
}

class NotificationService {
  private notifd: AstalNotifd.Notifd

  constructor() {
    this.notifd = AstalNotifd.get_default()
  }

  getNotifd() {
    return this.notifd
  }

  clearAll() {
    const notifications = this.notifd.get_notifications()
    notifications.forEach((notification) => {
      notification.dismiss()
    })
  }

  dismiss(notification: AstalNotifd.Notification) {
    notification.dismiss()
  }

  getGrouped(): NotificationGroup[] {
    const notifications = this.notifd.get_notifications()
    const groupMap = new Map<string, NotificationGroup>()

    notifications.forEach((notif) => {
      const appName = notif.app_name || "Unknown"
      if (!groupMap.has(appName)) {
        groupMap.set(appName, {
          appName,
          appIcon: getAppIcon(appName, notif.app_icon || ""),
          notifications: [],
        })
      }
      groupMap.get(appName)!.notifications.push(notif)
    })

    return Array.from(groupMap.values())
  }
}

export const notificationService = new NotificationService()
