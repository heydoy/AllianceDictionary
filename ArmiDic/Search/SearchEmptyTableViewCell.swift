//
//  SearchEmptyTableViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class SearchEmptyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var guideLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setLabel(query: String ) {
        guideLabel.text = query
    }
}
