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
    
    func configureData(voca: ArmyJargon) {
        
        koreanLabel.text = "🇰🇷 " + voca.ko
        abbreviationLabel.text = "▷ " + voca.abbr
        englishLabel.text = "🇺🇸 " + voca.en
        self.tag = voca.index
    }
}
