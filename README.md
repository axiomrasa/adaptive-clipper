# Adaptive Clipper
A high-performance, zero-latency dynamic clipper and saturator designed to boost loudness safely without destroying transients.

---

## 💾 DAW Compatibility
* **Windows (x64):** VST3 (Ableton Live, FL Studio, Cubase, Studio One, Reaper)
* **macOS (Intel / Apple Silicon):** VST3 & AU (Ableton Live, Logic Pro, Cubase)
* **Linux (x64):** VST3 (Bitwig, Reaper Linux)

---

## 📦 How to Install

1. Download the production bundle matching your operating system from the **builds/** folder or **GitHub Actions Artifacts**.
2. Extract the file and copy the plugin into your system's standard directory:

| Operating System | Format | Standard Plugin Installation Path |
| :--- | :--- | :--- |
| **Windows** | VST3 | `C:\Program Files\Common Files\VST3\` |
| **macOS** | VST3 | `/Library/Audio/Plug-Ins/VST3/` |
| **macOS** | AU (`.component`) | `/Library/Audio/Plug-Ins/Components/` |
| **Linux** | VST3 | `~/.vst3/` |

3. Restart your DAW and rescan plugins.

---

## 🍏 macOS Gatekeeper Fix
If your Mac flags an "unverified developer" warning when scanning the plugin inside your DAW, open Terminal and run this command:

```bash
sudo xattr -rd com.apple.quarantine /Library/Audio/Plug-Ins/VST3/AdaptiveClipper.vst3
📄 License
This project is open-source and available under the MIT License.
