import("stdfaust.lib");

manual_drive = hslider("Drive (dB)", 0, 0, 24, 0.1) : ba.db2linear;
threshold = hslider("Threshold", 0.7, 0.1, 1.0, 0.01);

envelope(x) = abs(x) : si.smooth(ba.tau2pole(0.05));

adaptive_shaper(x) = select2(envelope(x) > threshold, soft_clip(x), hard_clip(x))
with {
    soft_clip(v) = ma.tanh(v * manual_drive);
    hard_clip(v) = max(-threshold, min(threshold, v * manual_drive));
};

process = adaptive_shaper, adaptive_shaper;