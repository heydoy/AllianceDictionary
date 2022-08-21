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
    

    @IBOutlet weak var todayVocaDetailButton: UIButton!
    
    
    func configureUI() {
        vocaBackgroundView.layer.cornerRadius = 12
        
        
    }
}
