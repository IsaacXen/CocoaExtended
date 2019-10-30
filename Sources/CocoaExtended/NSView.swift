import Cocoa

public extension NSView {
    
    /// Adds multiple constraints on the layout of the receiving view or its subviews.
    ///
    /// - Parameters:
    ///   - format: The format specification for the constraints. The keys of views must be the string values begin with a `v` and follow by number begin from 0.
    ///   - views: Views that appear in the visual format string. Begin from v0.
    @available(OSX 10.7, *)
    func addConstraints(withVisualFormat format: String, views: NSView...) {
        var viewDictionary = [String: NSView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewDictionary))
    }
    
    /// Adds a constraint on the layout of the receiving view or its subviews.
    ///
    /// - Parameters:
    ///   - view1：The view for the left side of the constraint.
    ///   - attribute1：The attribute of the view for the left side of the constraint.
    ///   - relation: The relationship between the left side of the constraint and the right side of the constraint.
    ///   - view2: The view for the right side of the constraint.
    ///   - attribute2: The attribute of the view for the right side of the constraint.
    ///   - constant: The constant added to the multiplied attribute value on the right side of the constraint to yield the final modified attribute. 0 by default.
    ///   - multiplier: The constant multiplied with the attribute on the right side of the constraint as part of getting the modified attribute. 1 by default.
    @available(OSX 10.7, *)
    func addConstraint(_ view1: NSView, _ attribute1: NSLayoutConstraint.Attribute, _ relation: NSLayoutConstraint.Relation, to view2: NSView?, _ attribute2: NSLayoutConstraint.Attribute, plus constant: CGFloat = 0, multiply multiplier: CGFloat = 1) {
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2?.translatesAutoresizingMaskIntoConstraints = false
        
        view1.addConstraint(NSLayoutConstraint(item: view1, attribute: attribute1, relatedBy: relation, toItem: view2, attribute: attribute2, multiplier: multiplier, constant: constant))
    }
    
}
