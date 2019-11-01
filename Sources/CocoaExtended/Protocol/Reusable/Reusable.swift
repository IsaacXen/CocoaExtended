import AppKit

@available(OSX 10.11, *)
public protocol Reusable: class {
    static var reuseIdentifier: NSUserInterfaceItemIdentifier { get }
}
