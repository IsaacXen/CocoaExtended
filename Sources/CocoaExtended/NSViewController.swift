import Cocoa

public extension NSViewController {
    
    /// Add a view controller as reciver's child controller and add it's view to a container view.
    ///
    /// This function do the following things:
    ///
    /// - Add the content view of `childController` to `container`.
    /// - Disable constraints translation on the content view of `childController`.
    /// - Constraint the content view of `childController` to `container` view with no margin.
    /// - Add `childController` as a child view controller to the receiver.
    ///
    /// This is useful when separating view content to multiple part and managing these content in separated view controller.
    ///
    /// - Parameter childController: The view controller to be added as receiver's child controller.
    /// - Parameter container: The container view to host childController's content view. This container must be a view or subview managed by receiver.
    ///
    @available(OSX 10.10, *)
    func addChild(_ childController: NSViewController, container: NSView) {
        container.addSubview(childController.view)
        
        childController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(OSX 10.11, *) {
            childController.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            childController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            childController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            childController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        } else {
            container.addConstraints(withVisualFormat: "H:|-v0-|", views: childController.view)
            container.addConstraints(withVisualFormat: "V:|-v0-|", views: childController.view)
        }
        
        addChild(childController)
    }
    
}
