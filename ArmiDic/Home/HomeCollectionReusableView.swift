//
//  HomeCollectionReusableView.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var vocaBackgroundView: UIView!
    
    @IBOutlet weak var koreanVocaLabel: UILabel!
    
    @IBOutlet weak var abbrVocaLabel: UILabel!
    
    @IBOutlet weak var englishVocaLabel: UILabel!
    
    var headerDidTapped: (()->())?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGuesture))
                addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions, Helpers
    func configureUI() {
        vocaBackgroundView.layer.cornerRadius = 12
    }
    
    func configureLabel(voca: ArmyJargon) {

        self.tag = voca.index
        let abbrReplacedString = voca.abbr.isEmpty ? "-" : voca.abbr
        koreanVocaLabel.text = "🇰🇷 " + voca.ko
        abbrVocaLabel.text = "▷ " + abbrReplacedString
        englishVocaLabel.text = "🇺🇸 " + voca.en
        
    }
    @objc func handleTapGuesture() {
        headerDidTapped?()
    }
}
