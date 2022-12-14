//
//  HomeCollectionViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var koreanLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    
    
    func configureUI() {
        self.layer.cornerRadius = 8
    }
    
    func configureLabel(voca: ArmyJargon) {
        
        koreanLabel.text = "π°π· " + voca.ko
        abbreviationLabel.text = "β· " + voca.abbr
        englishLabel.text = "πΊπΈ " + voca.en
        self.tag = voca.index
        
        
    }
    
}
