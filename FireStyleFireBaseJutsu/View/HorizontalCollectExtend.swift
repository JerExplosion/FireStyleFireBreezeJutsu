//
//  HorizontalCollectExtend.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/12/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit
import Firebase

extension AddiFeectivedViewController: CollecDelegateDatasourceCombination, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let celloc  = horizontalCollectV.dequeueReusableCell(withReuseIdentifier: GloballyApplied.horizontalCollectID, for: indexPath) as! HorizontalCollectionCell
        
        if indexPath.row == 0 {
            celloc.horizontalCollectImageView.image = nil
        }
        
        return celloc
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 65)
    }
}

 
