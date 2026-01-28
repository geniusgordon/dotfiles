import { execAsync, exec } from "ags/process"
import { createPoll } from "ags/time"

function getWorkspaceState() {
  try {
    const active = JSON.parse(exec("hyprctl activeworkspace -j"))
    const all = JSON.parse(exec("hyprctl workspaces -j"))
    return { activeId: active.id, occupied: all.map((w: any) => w.id) }
  } catch (e) {
    return { activeId: 1, occupied: [1] }
  }
}

export default function Workspaces() {
  const workspaceState = createPoll(getWorkspaceState(), 500, getWorkspaceState)

  return (
    <box spacing={6} class="workspaces">
      {[1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) => (
        <button
          class={workspaceState((state) => {
            const isActive = state.activeId === i
            const isOccupied = state.occupied.includes(i)
            return `workspace ${isActive ? "active" : ""} ${
              isOccupied ? "occupied" : "empty"
            }`
          })}
          onClicked={() => execAsync(`hyprctl dispatch workspace ${i}`)}
        >
          <label label={`${i}`} />
        </button>
      ))}
    </box>
  )
}
