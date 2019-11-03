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
        guard let screen = NSScreen.screens.first else { return }
        let mouseLocation = NSEvent.mouseLocation
        let point = NSMakePoint(mouseLocation.x + dx, screen.frame.maxY - mouseLocation.y - dy)
        CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: point, mouseButton: .left)?.post(tap: .cghidEventTap)
    }
    
}
