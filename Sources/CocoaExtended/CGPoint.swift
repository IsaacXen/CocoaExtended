import Foundation

extension CGPoint: Hashable {
    public static func == (lhs: NSPoint, rhs: NSPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
