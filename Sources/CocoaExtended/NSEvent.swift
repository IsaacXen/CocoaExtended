import Cocoa

public extension NSEvent {
    
    /// Remove the specified event monitor.
    ///
    /// If `eventMonitor` is not `nil`, this function will call `NSEvent.removeMonitor(_:)` with `eventMonitor` Unwrapped, then the `eventMonitor` is set to
    /// `nil`. If `eventMonitor` passed-in is already `nil`, this function do nothing.
    ///
    /// You must ensure that eventMonitor is removed only once. Removing the same eventMonitor instance multiple times results in an over-release condition,
    /// even in a Garbage Collected environment.
    ///
    /// - Parameter eventMonitor: The event handler object to remove.
    @available(OSX 10.6, *)
    class func remove(monitor eventMonitor: inout Any?) {
        if eventMonitor != nil {
            NSEvent.removeMonitor(eventMonitor!)
            eventMonitor = nil
        }
    }
    
    /// Post a mouse move event to HID Event by offseting current mouse location.
    ///
    /// This function simulate a mouse move event by create a `CGEvent` and post it.
    ///
    /// - Parameter dx: The cursor offset in x axis, in point. A positive value cause the cursor to move right, a negitive value cause the cursor to move left.
    /// - Parameter dy: The cursor offset in y axis, in point. A positive value cause the cursor to move up, a negitive value cause the cursor to move down.
    @available(OSX 10.4, *)
    class func postMouseMovedEvent(dx: CGFloat, dy: CGFloat) {
        let fromPoint = NSEvent.mouseLocation
        guard
            let screen = NSScreen.screens.first,
            let fromScreen = NSScreen.screens.first(where: { NSMouseInRect(mouseLocation, $0.frame, false) })
        else { return }
        
        var toPoint = NSMakePoint(fromPoint.x + dx, fromPoint.y + dy)
        
        if !NSScreen.screens.contains(where: { NSMouseInRect(toPoint, $0.frame, false) }) {
            print(toPoint, fromScreen.frame)
            toPoint.x = max(fromScreen.frame.minX, min(toPoint.x, fromScreen.frame.maxX - 0.01953125))
            toPoint.y = max(fromScreen.frame.minY, min(toPoint.y, fromScreen.frame.maxY - 0.01953125))
            print(toPoint)
        }
        
        let flippedToPoint = NSMakePoint(toPoint.x, screen.frame.maxY - toPoint.y)
        
        CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: flippedToPoint, mouseButton: .left)?.post(tap: .cghidEventTap)
    }
    
}
