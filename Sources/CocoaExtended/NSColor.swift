import Cocoa

public extension NSColor {
    
    /// Return the contrast ratio with another color.
    ///
    /// This method automatically convert both receiver and parameter colors to deviceRGB color space for comparison.
    ///
    /// The contrast ratio of two colors is represented using a value from `1` to `21`, where `1` means no contrast at all and `21` means maximium contrast. A contrast ratio above `7` is considered great contrast for visual discrimination and accessibility.
    ///
    /// - Parameter otherColor: The color to compare with.
    ///
    /// - Returns: Contrast ratio of both colors, or `nil` if any of both color failed to convert to deviceRGB color space.
    @available(OSX 10.4, *)
    func contrastRatio(with otherColor: NSColor) -> CGFloat? {
        guard
            let lhs = usingColorSpace(.deviceRGB)?.brightnessComponent,
            let rhs = otherColor.usingColorSpace(.deviceRGB)?.brightnessComponent
        else { return nil }
        
        return (max(lhs, rhs) + 0.05) / (min(lhs, rhs) + 0.05)
    }
    
    /// Return the brightness value receiver should have to meet the contrast ratio with other color.
    ///
    /// This method automatically convert both receiver and parameter colors to deviceRGB color space.
    ///
    /// The contrast ratio of two colors is represented using a value from `1` to `21`, where `1` means no contrast at all and `21` means maximium contrast. A contrast ratio above `7` is considered great contrast for visual discrimination and accessibility.
    ///
    /// - Parameter contrastRatio: The contrast ratio to meet. `7` by default.
    /// - Parameter otherColor: The color to compare with.
    ///
    /// - Returns: The brightness level for receiver to meet specific contrast ratio, or `nil` if any of both color failed to convert to deviceRGB color space.
    @available(OSX 10.4, *)
    func brightnessToMeetMinContrastRatio(_ contrastRatio: CGFloat = 7, with otherColor: NSColor) -> CGFloat? {
        guard
            let lhs = usingColorSpace(.deviceRGB)?.brightnessComponent,
            let rhs = otherColor.usingColorSpace(.deviceRGB)?.brightnessComponent
        else { return nil }
        
        let contrastRatio = max(1, min(contrastRatio, 21))
        
        return lhs > rhs ? contrastRatio * (rhs + 0.05) - 0.05
                         : (rhs + 0.05) / contrastRatio + 0.05
    }
        
    /// Create a new color object that has component values as the receiver, but the specified components.
    ///
    /// This method convert receiver color to deviceRGB color space for in order to retrive hsba components.
    ///
    /// It's not recommended to adjusting all four hsba components using this method, instead, use initilize method of `NSColor` to create a new color object directly.
    ///
    /// - Parameter hue: New hue component value, or `nil` to use original value.
    /// - Parameter saturation: New saturation component value, or `nil` to use original value.
    /// - Parameter brightness: New brightness component value, or `nil` to use original value.
    /// - Parameter alpha: New alpha component value, or `nil` to use original value.
    ///
    /// - Returns: A new adjusted color object, or original color object if failed to convert to deviceRGB color space.
    @available(OSX 10.4, *)
    func adjustedColor(withHue hue: CGFloat? = nil, saturation: CGFloat? = nil, brightness: CGFloat? = nil, alpha: CGFloat? = nil) -> NSColor {
        guard
            ![hue, saturation, brightness, alpha].filter({ $0 != nil }).isEmpty,
            let color = usingColorSpace(.deviceRGB)
        else { return self }
        
        let h = hue ?? color.hueComponent
        let s = saturation ?? color.saturationComponent
        let b = brightness ?? color.brightnessComponent
        let a = alpha ?? color.alphaComponent
        
        return NSColor(deviceHue: h, saturation: s, brightness: b, alpha: a)
    }
        
    /// Create a new color object with different brightness that has specific contrast ratio with given color.
    ///
    /// This method convert receiver color to deviceRGB color space for in order to retrive hsba components.
    ///
    /// The contrast ratio of two colors is represented using a value from `1` to `21`, where `1` means no contrast at all and `21` means maximium contrast. A contrast ratio above `7` is considered great contrast for visual discrimination and accessibility.
    ///
    /// - Parameter contrastRatio: The contrast ratio to meet. `7` by default.
    /// - Parameter otherColor: The color to compare with.
    ///
    /// - Returns: A new color object with different brightness that meet specific contrast ratio with given color, or `nil` if failed to convert to deviceRGB color space.
    @available(OSX 10.4, *)
    func adjustedColorToMeetContrastRatio(_ contrastRatio: CGFloat = 7, with otherColor: NSColor) -> NSColor? {
        guard
            let brightness = brightnessToMeetMinContrastRatio(contrastRatio, with: otherColor)
        else { return nil }
        
        return adjustedColor(brightness: brightness)
    }
    
}
