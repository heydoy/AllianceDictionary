//
//  EmptySearchCollectionViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class EmptySearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    func configureLabel(query: String) {
        emptyLabel.text = "'\(query)'에 대한 검색결과가 없습니다."
    }
}
