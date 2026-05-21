Adaptive Clipper
**Developed by:** [axiomrasa](https://github.com/axiomrasa)  
**DSP Core:** Faust DSP (64-bit Double Precision)  
**Architecture:** Zero-Latency Dynamic Wave-Shaper / Nonlinear Processor  

---

## 🧠 Context & Industry Inspiration
This project does not attempt to reinvent the wheel. Deep harmonic processors and dynamic clippers like **FabFilter Saturn 2**, **Sonnox Oxford Inflator**, or **Kazrog K-Clip** have long proven that dynamic, level-dependent nonlinear processing is mathematically superior to static distortion. 

The goal of **Adaptive Clipper** is to strip away multiband complexity and heavy lookahead latency, isolating this industry-proven dynamic morphing logic into its purest, most lightweight, **zero-latency open-source micro-utility** form.

---

## 🔴 The Problem: Static Blindness
Standard digital waveshapers apply a fixed mathematical curve (such as $\tanh$) across the entire dynamic timeline. This "blind" approach causes severe transient degradation on percussive signals (like drums). When a sharp attack hits a static curve, the initial transient is flattened, robbing the sound of its punch, destroying the dynamic range, and pushing the instrument back in the mix.

## 🟢 The Solution: Adaptive DSP
This micro-utility resolves transient flattening by decoupling the input signal into an asynchronous analysis sidechain and a sample-accurate processing path:

1. **Envelope Tracking:** A 50ms smoothed envelope follower (`si.smooth` combined with `ba.tau2pole`) continuously evaluates the absolute time-domain energy profile of the incoming audio.
2. **Dynamic Morphing (`select2`):**
   * **Below Threshold:** Applies a smooth hyperbolic tangent curve ($\tanh$) to introduce warm, cohesive analog-style even and odd harmonics to low-level signals.
   * **Above Threshold:** Instantly morphs into a hard-clipping brickwall ceiling using optimized native `min`/`max` primitives. This preserves the structural transient snap and bite without introducing parametric phase lag or group delay.

---

## 🎛️ Architecture & Mathematical Signal Flow

The core waveshaping block switches behaviors contextually based on the sidechain analysis input:

$$y(t) = \begin{cases} \tanh(x(t) \cdot \text{drive}), & \text{if } e(t) \le \text{threshold} \\ \max(-\text{threshold}, \min(\text{threshold}, x(t) \cdot \text{drive})), & \text{if } e(t) > \text{threshold} \end{cases}$$

Where $e(t)$ represents the smoothed macroeconomic envelope tracking estimation.

### DSP Routing Blueprint
![DSP Flow](docs/dsp_flow.png)

### Native UI Preview
![UI Preview](docs/gui_preview.png)

---

## 📁 Project Directory Structure
```text
├── src/                  # Core Faust source file (adaptive_clipper.dsp)
├── juce-project/         # Generated C++ sources and Projucer project (.jucer)
├── docs/                 # Technical flowcharts and interface previews
└── builds/               # Compiled binary deployment targets
    └── Mac-VST/          # macOS VST execution component for Ableton/FL Studio
💻 Hardware & DAW Compatibility MatrixThe pre-compiled binary provided in /builds/Mac-VST is packaged in a legacy VST2 container core. To understand how it runs on your specific workstation configuration, please refer to the deployment matrix below:Hardware ArchitectureOS VersionNative SupportExecution ModeIntel Core (x86_64 Legacy Mac)macOS Mojave to Monterey+Yes (100%)Plug-and-Play (Native)Apple Silicon (M1/M2/M3/M4 Architecture)macOS Big Sur to Sequoia+Via Compatibility LayerRequires Rosetta 2 DAW LaunchAny Hardware Platform / Cross-PlatformAny Modern OS via C++Source-Ready (Preferred)Compile /juce-project locally🛠️ Note for Apple Silicon Power Users: For absolute ARM64 hardware-native execution (Native VST3 or Audio Unit) without running wrappers, open the provided cross-platform C++ source project inside /juce-project using Xcode on your machine and run a local build target tailored to your processor.📊 Technical SpecificationsLatency: 0 samples (True zero-latency, production and live-tracking safe).Processing Precision: 64-bit double-precision floating-point core calculations.CPU Footprint: Ultra-lightweight (< 0.4% processing budget on modern architectures).Channel Configuration: 2-In / 2-Out Discrete Asynchronous Stereo.📄 LicenseThis project is open-source and available under the MIT License.