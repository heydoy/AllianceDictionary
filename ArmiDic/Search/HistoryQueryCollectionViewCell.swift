//
//  HistoryQueryCollectionViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class HistoryQueryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var queryLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        configureUI()
    }
    
    func configureUI() {
        self.layer.cornerRadius = 22
    }
    
    func configureQuery(query: String ) {
        queryLabel.text = query
    }
}
