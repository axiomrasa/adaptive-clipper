import("stdfaust.lib");

manual_drive = hslider("Drive (dB)", 0, 0, 24, 0.1) : ba.db2linear;
threshold    = hslider("Threshold", 0.7, 0.1, 1.0, 0.01);

stereo_env(x, y) = max(abs(x), abs(y)) : si.smooth(ba.tau2pole(0.05));

soft_clip(v) = ma.tanh(v * manual_drive);
hard_clip(v) = threshold * ma.tanh((v * manual_drive) / threshold);

smooth_switch(cond, fallback, target) = (1.0 - k) * fallback + k * target
with {
    k = cond : si.smooth(ba.tau2pole(0.005));
};

process(l, r) = smooth_switch(gate, soft_clip(l), hard_clip(l)),
                smooth_switch(gate, soft_clip(r), hard_clip(r))
with {
    env  = stereo_env(l, r);
    gate = env > threshold;
};