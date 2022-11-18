//
//  SearchResultTableViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var koreanLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.clipsToBounds = true
        self.baseView.layer.cornerRadius = 12
        
    }
    
    func configureData(voca: ArmyJargon ) {
        let abbrReplacedString = voca.abbr.isEmpty ? "-" : voca.abbr
        koreanLabel.text = "🇰🇷 " + voca.ko
        abbreviationLabel.text = "▷ " + abbrReplacedString
        englishLabel.text = "🇺🇸 " + voca.en
        self.tag = voca.index
    }


}
