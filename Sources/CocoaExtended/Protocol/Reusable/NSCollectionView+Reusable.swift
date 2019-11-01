import Cocoa

public extension NSCollectionView {
    
    @available(OSX 10.11, *)
    func register<T>(cell cellClass: T.Type) where T: Reusable & NSCollectionViewElement {
        register(cellClass, forItemWithIdentifier: cellClass.reuseIdentifier)
    }
    
    @available(OSX 10.11, *)
    func register<T>(header cellClass: T.Type) where T: Reusable & NSCollectionViewElement {
        register(cellClass, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: cellClass.reuseIdentifier)
    }
    
    @available(OSX 10.11, *)
    func register<T>(footer cellClass: T.Type) where T: Reusable & NSCollectionViewElement {
        register(cellClass, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionFooter, withIdentifier: cellClass.reuseIdentifier)
    }
    
    @available(OSX 10.11, *)
    func register<T>(itemGapIndicator cellClass: T.Type) where T: Reusable & NSCollectionViewElement {
        register(cellClass, forSupplementaryViewOfKind: NSCollectionView.elementKindInterItemGapIndicator, withIdentifier: cellClass.reuseIdentifier)
    }
    
    @available(OSX 10.11, *)
    func dequeue<T>(cell cellClass: T.Type, for indexPath: IndexPath) -> T where T: Reusable & NSCollectionViewElement {
        return makeItem(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
    }
    
    @available(OSX 10.11, *)
    func dequeue<T>(header cellClass: T.Type, for indexPath: IndexPath) -> T where T: Reusable & NSCollectionViewElement {
        return makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
    }
    
    @available(OSX 10.11, *)
    func dequeue<T>(footer cellClass: T.Type, for indexPath: IndexPath) -> T where T: Reusable & NSCollectionViewElement {
        return makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionFooter, withIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
    }
    
    @available(OSX 10.11, *)
    func dequeue<T>(itemGapIndicator cellClass: T.Type, for indexPath: IndexPath) -> T where T: Reusable & NSCollectionViewElement {
        return makeSupplementaryView(ofKind: NSCollectionView.elementKindInterItemGapIndicator, withIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
    }
    
}
