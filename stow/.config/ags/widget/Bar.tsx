import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import ArchIcon from "./ArchIcon"
import Workspaces from "./Workspaces"
import ActiveWindow from "./ActiveWindow"
import Fcitx5 from "./Fcitx5"
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
        <box $type="center" halign={Gtk.Align.CENTER}>
          <ActiveWindow />
        </box>
        <box $type="end" spacing={8} halign={Gtk.Align.END}>
          <Fcitx5 />
          <Clock />
        </box>
      </centerbox>
    </window>
  )
}
