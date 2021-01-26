//
// Created by stringCode on 21/01/2021.
//

import UIKit

class SelfSizingCell: UICollectionViewCell {

    weak var widthContraint: NSLayoutConstraint?
    weak var heightContraint: NSLayoutConstraint?
    
    var halfBox: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureUI() {
        // NOTE: Enable autolayout
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let randomHeight: CGFloat = 120
        
        let widthConstraint = contentView.widthAnchor.constraint(
            greaterThanOrEqualToConstant: UIScreen.main.bounds.width
        )

        let heightConstraint = contentView.heightAnchor.constraint(
            greaterThanOrEqualToConstant: randomHeight
        )
        
        widthConstraint.priority = .defaultHigh
        heightConstraint.priority = .defaultHigh
                
        self.widthContraint = widthConstraint
        self.heightContraint = heightConstraint
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            widthConstraint,
            heightConstraint
        ])

        backgroundColor = .systemRed
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        let adjusted = layoutAttributes.copy() as! UICollectionViewLayoutAttributes

        var targetSize = layoutAttributes.bounds.size
        
        if let attrs = adjusted as? SelfSizingFlowLayout.Attributes {
            targetSize.width = attrs.maxCellWidth
        }
        
        if halfBox {
            targetSize.width = floor((targetSize.width - 10) / 2)
        }
        
        widthContraint?.constant = targetSize.width
        
        let size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
                
        adjusted.bounds = CGRect(origin: .zero, size: size)
        return adjusted
    }
}
