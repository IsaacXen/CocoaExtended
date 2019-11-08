import Foundation

extension CGSize: Hashable {
    public static func == (lhs: NSSize, rhs: NSSize) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}
