//
// Created by stringCode on 21/01/2021.
//

import UIKit

class SelfSizingFlowLayout: UICollectionViewFlowLayout {
    
    class Attributes: UICollectionViewLayoutAttributes {
     
        var maxCellWidth: CGFloat = 0

        override func copy() -> Any {
            let aCopy = super.copy()
            (aCopy as? Attributes)?.maxCellWidth = maxCellWidth
            return aCopy
        }
    }
    
    override var collectionViewContentSize: CGSize {
        let size = super.collectionViewContentSize
        print("collectionViewContentSize", size)
        return size
    }
    
    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?
            .filter { $0.representedElementCategory == .cell }
            .forEach { computeMaxCellWidth(for: $0 as? Attributes) }
        
        return attributes
    }

    override func layoutAttributesForItem(
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        computeMaxCellWidth(for: attributes as? Attributes)
        return attributes
    }
    
    override class var layoutAttributesClass: AnyClass {
        return Attributes.self
    }
}

private extension SelfSizingFlowLayout {
    
    func computeMaxCellWidth(for attributes: Attributes?) {
        guard let attributes = attributes else {
            return
        }
        
        guard let cv = collectionView else {
            return
        }
        
        let section = attributes.indexPath.section
        let insets = (cv.delegate as? UICollectionViewDelegateFlowLayout)?
            .collectionView?(cv, layout: self, insetForSectionAt: section) ??
            .zero
        attributes.maxCellWidth = cv.frame.width - (insets.left + insets.right)
    }
}
