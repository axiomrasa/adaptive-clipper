// ==============================================================================
// PUNCHBOX CUSTOM UI LOOK AND FEEL
// ==============================================================================
#pragma once
#include <JuceHeader.h>

class PunchBoxLookAndFeel : public juce::LookAndFeel_V4
{
public:
    PunchBoxLookAndFeel()
    {
        // Main background (Dark Gray/Black)
        setColour(juce::ResizableWindow::backgroundColourId, juce::Colour(0xff121212));
        
        // Rotary Slider (Knob) colors - Neon Orange & Dark Metal
        setColour(juce::Slider::rotarySliderFillColourId, juce::Colour(0xffff5500));
        setColour(juce::Slider::rotarySliderOutlineColourId, juce::Colour(0xff2a2a2a));
        setColour(juce::Slider::thumbColourId, juce::Colour(0xffffffff));
        
        // Text colors
        setColour(juce::Slider::textBoxTextColourId, juce::Colour(0xffa0a0a0));
        setColour(juce::Slider::textBoxOutlineColourId, juce::Colours::transparentBlack);
    }

    // Minimalist flat rotary slider drawing engine
    void drawRotarySlider(juce::Graphics& g, int x, int y, int width, int height,
                          float sliderPos, float rotaryStartAngle, float rotaryEndAngle,
                          juce::Slider& slider) override
    {
        auto radius = (float)juce::jmin(width / 2, height / 2) - 4.0f;
        auto centreX = (float)x + (float)width  * 0.5f;
        auto centreY = (float)y + (float)height * 0.5f;
        auto rx = centreX - radius;
        auto ry = centreY - radius;
        auto rw = radius * 2.0f;
        auto angle = rotaryStartAngle + sliderPos * (rotaryEndAngle - rotaryStartAngle);

        // Background track
        g.setColour(findColour(juce::Slider::rotarySliderOutlineColourId));
        g.fillEllipse(rx, ry, rw, rw);

        // Fill track (Neon)
        g.setColour(findColour(juce::Slider::rotarySliderFillColourId));
        juce::Path p;
        p.addPieSegment(rx, ry, rw, rw, rotaryStartAngle, angle, 0.0f);
        g.fillPath(p);

        // Indicator line
        g.setColour(findColour(juce::Slider::thumbColourId));
        juce::Path p2;
        p2.addRectangle(-2.0f, -radius, 4.0f, radius * 0.5f);
        p2.applyTransform(juce::AffineTransform::rotation(angle).translated(centreX, centreY));
        g.fillPath(p2);
    }
};