import Foundation

public extension NotificationCenter {
    
    /// Removes all entries specifying a given observer from the notification center's dispatch table.
    func remove(observer: NSObjectProtocol?) {
        if let observer = observer {
            removeObserver(observer)
        }
    }
    
}
