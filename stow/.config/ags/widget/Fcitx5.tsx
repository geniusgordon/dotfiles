import { exec } from "ags/process"
import { createPoll } from "ags/time"

function getFcitx5State() {
  try {
    // Get current input method
    const im = exec("fcitx5-remote -n").trim()

    // Map common input methods to display names
    const displayNames: Record<string, string> = {
      "keyboard-us": "EN",
      "keyboard-cn": "CN",
      "rime": "中",
      "pinyin": "拼",
      "mozc": "あ",
      "hangul": "한",
    }

    // Get display name or use first 2 chars of IM name
    let display = displayNames[im] || im.slice(0, 2).toUpperCase()

    return { display, raw: im }
  } catch (e) {
    return { display: "EN", raw: "keyboard-us" }
  }
}

export default function Fcitx5() {
  const fcitx5State = createPoll(getFcitx5State(), 500, getFcitx5State)

  return (
    <button
      onClicked={() => {
        try {
          exec("fcitx5-remote -t")
        } catch (e) {
          console.error("Failed to toggle fcitx5:", e)
        }
      }}
    >
      <label label={fcitx5State((state) => state.display)} />
    </button>
  )
}
