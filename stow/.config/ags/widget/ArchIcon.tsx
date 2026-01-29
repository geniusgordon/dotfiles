import { execAsync } from "ags/process"

export default function ArchIcon() {
  return (
    <button onClicked={() => execAsync("vicinae toggle")} class="arch-icon">
      <label label="󰣇" />
    </button>
  )
}
