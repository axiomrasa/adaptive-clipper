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
* **Windows (x64):** Plug-and-Play `.dll` target
* **Linux (x64):** Plug-and-Play `.so` target
* **macOS (Intel / Apple Silicon):** Universal Binary `.vst3` & `.component` (AU) via GitHub Actions CI/CD.

---

## 📊 Technical Specifications
* **Latency:** 0 samples
* **Precision:** 64-bit double-precision core calculations
* **CPU Budget:** Ultra-lightweight (< 0.4% per instance)
* **Channel Configuration:** 2-In / 2-Out Discrete Stereo

---

## 📄 License
This project is open-source and available under the MIT License.