# Adaptive Clipper

An industry-standard, zero-latency dynamic waveshaper built using the Faust DSP language. It features an intelligent envelope-following sidechain that dynamically morphs the saturation characteristics based on the incoming signal's transient energy.

## 🔴 The Problem (Static Blindness)
Traditional digital waveshapers apply a fixed, static non-linear curve (such as `tanh`) across the entire dynamic range. This "blind" processing leads to severe transient degradation. When high-energy transients (e.g., sharp drum attacks) hit a static clipper, they lose their initial punch and structural impact, resulting in a muddy, flattened mix. Conversely, low-level signals suffer from unnecessary intermodulation distortion.

## 🟢 The Solution (Adaptive DSP)
This processor resolves the transient blindness problem by introducing an **Adaptive DSP Architecture**. The input signal is split into a time-domain analysis path and a processing path:

1. **Envelope Tracking:** A 50ms smoothed envelope follower continuously measures the absolute mathematical energy of the input signal.
2. **Dynamic Morphing:** - **Below Threshold:** The processor applies a pürüzsüz, analog-style saturation (`tanh`) to introduce warm, musical even/odd harmonics for lower-level signals.
   - **Above Threshold:** The processor instantly morphs into a hard-clipping ceiling using optimized `min`/`max` boundaries, preserving the structural transient peaks and punch without introducing parametric phase lag.

## 🎛️ Architecture & Signal Flow

### Mathematical Formulation
The core transformation function behaves contextually:

$$y(t) = \begin{cases} \tanh(x(t) \cdot \text{drive}), & \text{if } e(t) \le \text{threshold} \\ \max(-\text{threshold}, \min(\text{threshold}, x(t) \cdot \text{drive})), & \text{if } e(t) > \text{threshold} \end{cases}$$

Where $e(t)$ is the smoothed time-domain envelope estimation.

### DSP Diagram
![DSP Flow](docs/dsp_flow.png)

## 🎨 UI Preview
The plugin utilizes the native JUCE framework layout engine, optimized for stable rendering and automated DAW host parameters.

![UI Preview](docs/gui_preview.png)

## 📁 Project Directory Structure
```text
├── src/                  # Core Faust source code (.dsp)
├── docs/                 # Architectural assets and UI visual previews
└── builds/               # Pre-compiled binary deployment targets
    └── Mac-VST/          # Native macOS VST component for Ableton/FL Studio