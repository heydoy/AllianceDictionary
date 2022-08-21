//
//  SearchHistoryTableViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var historyQueryCollectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
