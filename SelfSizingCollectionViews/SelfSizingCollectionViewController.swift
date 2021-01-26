//
// Created by stringCode on 21/01/2021.
//

import UIKit

class SelfSizingCollectionViewController: UICollectionViewController,
                                          UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            SelfSizingCell.self,
            forCellWithReuseIdentifier: "\(SelfSizingCell.self)"
        )
        
        let layout = collectionViewLayout as? SelfSizingFlowLayout
        
        layout?.estimatedItemSize = CGSize(
            width: view.bounds.width - 20,
            height: 50
        )
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 5
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "\(SelfSizingCell.self)",
            for: indexPath
        )
        
        (cell as? SelfSizingCell)?.halfBox = indexPath.section == 1
        
        cell.backgroundColor = indexPath.section == 1 ? .systemGreen : .systemRed
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
       return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
