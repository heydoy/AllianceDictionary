//
//  SearchCollectionReusableView.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class SearchCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var searchBar: UISearchBar!
    
    func configureUI () {
        searchBar.backgroundImage = UIImage()
    }
    
}
