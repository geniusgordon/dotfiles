import { exec } from "ags/process"
import { createPoll } from "ags/time"

function getActiveWindow() {
  try {
    const activeWindow = JSON.parse(exec("hyprctl activewindow -j"))
    const title = activeWindow.title || ""
    const className = activeWindow.class || ""

    // Truncate long titles
    const maxLength = 50
    const displayTitle = title.length > maxLength ? title.slice(0, maxLength) + "..." : title

    return { title: displayTitle, className }
  } catch (e) {
    return { title: "", className: "" }
  }
}

export default function ActiveWindow() {
  const activeWindow = createPoll(getActiveWindow(), 500, getActiveWindow)

  return (
    <box class="active-window">
      <label label={activeWindow((win) => win.title || "Desktop")} />
    </box>
  )
}
