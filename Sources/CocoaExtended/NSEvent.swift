import Cocoa

public extension NSEvent {
    
    /// Remove the specified event monitor.
    ///
    /// If `eventMonitor` is not `nil`, this function will call `NSEvent.removeMonitor(_:)` with `eventMonitor` Unwrapped, then the
    /// `eventMonitor` is set to `nil`. If `eventMonitor` passed-in is already `nil`, this function do nothing.
    ///
    /// You must ensure that eventMonitor is removed only once. Removing the same eventMonitor instance multiple times results in an over-release condition, even in a Garbage Collected environment.
    ///
    /// - Parameter eventMonitor: The event handler object to remove.
    @available(OSX 10.6, *)
    class func remove(monitor eventMonitor: inout Any?) {
        if eventMonitor != nil {
            NSEvent.removeMonitor(eventMonitor!)
            eventMonitor = nil
        }
    }
    
}
