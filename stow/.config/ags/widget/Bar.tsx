import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import ArchIcon from "./ArchIcon"
import Workspaces from "./Workspaces"
import Clock from "./Clock"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="centerbox">
        <box $type="start" spacing={12} halign={Gtk.Align.START}>
          <ArchIcon />
          <Workspaces />
        </box>
        <box $type="center" />
        <box $type="end" halign={Gtk.Align.END}>
          <Clock />
        </box>
      </centerbox>
    </window>
  )
}
