//
//  HistoryQueryCollectionViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class HistoryQueryCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 12
    }
    
    @IBOutlet weak var historyQueryLabel: UILabel!
    @IBOutlet weak var removeQueryButton: UIButton!
    
    func configureLabel(query: String) {
        historyQueryLabel.text = query
    }
    
}
