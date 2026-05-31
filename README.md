# Adaptive Clipper
**Developed by:** [axiomrasa](https://github.com/axiomrasa)  
**DSP Core:** Faust DSP (64-bit Double Precision)  
**Architecture:** Zero-Latency Smooth Hybrid Wave-Shaper  

---

## 🟢 Concept & System Architecture
Adaptive Clipper isolates dynamic, level-dependent nonlinear morphing logic into a zero-latency micro-utility. It prevents hard digital clipping artifacts by continuously evaluating the stereo-linked macroeconomic energy profile.

1. **Stereo-Linked Envelope:** Evaluates peak signal energy across discrete channels via `max(abs(x), abs(y))` to maintain a rock-solid center stereo image.
2. **Smooth Crossfader Engine:** Replaces hard binary switching with a 5ms linear interpolation window (`smooth_switch`) to prevent switching discontinuities and zipper noise.
3. **Soft-Knee Ceiling:** Morphs adaptively into a continuous hyperbolic tangent curve ($\tanh$) under threshold stress to maximize perceived loudness safely without parametric phase lag.

---

## 💾 Hardware & DAW Compatibility
* **Windows (x64):** VST3 Target (Ableton, Cubase, Studio One, Reaper, FL Studio)
* **Linux (x64):** VST3 Target (Bitwig, Reaper Linux)
* **macOS (Intel / Apple Silicon):** Universal Binary VST3 & AU (Ableton, Logic Pro, Cubase)

---

## 📊 Technical Specifications
* **Latency:** 0 samples
* **Precision:** 64-bit double-precision core calculations
* **CPU Budget:** Ultra-lightweight (< 0.4% per instance)
* **Channel Configuration:** 2-In / 2-Out Discrete Stereo

---

## 📦 Distribution & Installation Paths

Choose the download path corresponding to your operating system:

### 🍏 For macOS Users (Automated Universal Build)
Since macOS requires specific architecture code-signing, the binaries are generated automatically via cloud runners:
1. Navigate to the **Actions** tab at the top of this GitHub repository.
2. Click on the latest successful build workflow run.
3. Scroll down to the **Artifacts** section and download `AdaptiveClipper-macOS.zip`.
4. Extract the zip file and move the bundles to your global system directory:
   * **VST3 Path:** `/Library/Audio/Plug-Ins/VST3/`
   * **AU Path:** `/Library/Audio/Plug-Ins/Components/`
5. **Gatekeeper Bypass:** If your DAW flags an unverified developer warning, open Terminal and execute:
   ```bash
   sudo xattr -rd com.apple.quarantine /Library/Audio/Plug-Ins/VST3/AdaptiveClipper.vst3
🪟 / 🐧 For Windows & Linux Users (Direct Repository Download)
Navigate directly to the builds/ folder inside this repository.

Click on the production binary matching your OS (AdaptiveClipper.vst3, .dll, or .so).

Click the "Download raw file" button to download it.

Move the file to your system's default directory:

Windows VST3 Path: C:\Program Files\Common Files\VST3\

Linux VST3 Path: ~/.vst3/

📄 License
This project is open-source and available under the MIT License.