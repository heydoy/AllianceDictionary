//
//  BookmarkCollectionViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class BookmarkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var koreanLabel: UILabel!
    
    @IBOutlet weak var abbreviationLabel: UILabel!
    
    @IBOutlet weak var englishLabel: UILabel!
    
    
    func configureUI() {
        self.layer.cornerRadius = 8 
    }
}
