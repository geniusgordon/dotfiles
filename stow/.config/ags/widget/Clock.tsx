import { createPoll } from "ags/time"
import ControlCenter from "./ControlCenter"

export default function Clock() {
  const time = createPoll("", 1000, () => {
    const now = new Date()
    const formatter = new Intl.DateTimeFormat("en-US", {
      weekday: "short",
      month: "short",
      day: "numeric",
      hour: "numeric",
      minute: "2-digit",
      hour12: true,
    })
    return formatter.format(now)
  })

  return (
    <menubutton>
      <label label={time} />
      <popover>
        <ControlCenter />
      </popover>
    </menubutton>
  )
}
