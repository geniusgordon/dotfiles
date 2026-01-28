import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widget/Bar"

app.start({
  css: style,
  main() {
    // Create bar for each monitor
    app.get_monitors().map(Bar)
  },
})
