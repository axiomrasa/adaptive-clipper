// =============================================================================
// Adaptive Clipper DSP Core
// Architecture: Zero-Latency Dynamic Wave-Shaper / Nonlinear Processor
// Language: Faust DSP (64-bit Double Precision Compliant)
// =============================================================================

import("stdfaust.lib");

// --- USER INTERFACE & PARAMETER MAPPING ---
// ba.db2linear converts decibels to a linear gain coefficient.
// This prevents exponential volume spikes and ensures linear behavior during DAW automation.
manual_drive = hslider("Drive (dB)", 0, 0, 24, 0.1) : ba.db2linear;

// The target brickwall boundary that separates soft saturation from structural clamping.
threshold = hslider("Threshold", 0.7, 0.1, 1.0, 0.01);

// --- SIDECHAIN ANALYSIS NETWORK ---
// Time-domain envelope follower. abs(x) rectifies the bipolar signal into unipolar energy.
// si.smooth combined with ba.tau2pole(0.05) creates a 50ms low-pass filter time constant
// to track macroeconomic transient profiles without causing instantaneous signal distortion.
envelope(x) = abs(x) : si.smooth(ba.tau2pole(0.05));

// --- ADAPTIVE PROCESSING ENGINE ---
// select2 acts as a sample-accurate conditional switch controlled by the analysis path.
// It achieves dynamic morphing by bypassing parametric control lag found in standard modulators.
adaptive_shaper(x) = select2(envelope(x) > threshold, soft_clip(x), hard_clip(x))
with {
    // Soft-knee processing loop: Utilizes a transcendental hyperbolic tangent function 
    // to introduce warm, odd-harmonic analog-style saturation for low-to-mid energy signals.
    soft_clip(v) = ma.tanh(v * manual_drive);
    
    // Hard-clipping brickwall loop: Optimized using native min/max primitives to clamp 
    // high-energy structural transients exactly at the threshold ceiling without phase shifting.
    hard_clip(v) = max(-threshold, min(threshold, v * manual_drive));
};

// --- STEREO I/O CONFIGURATION ---
// Evaluates the adaptive_shaper expression twice in parallel. 
// This signals the compiler framework (JUCE/CoreAudio) to automatically allocate a 2-In/2-Out architecture.
process = adaptive_shaper, adaptive_shaper;