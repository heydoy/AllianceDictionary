//
//  HistorySearchCollectionViewCell.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class HistoryFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 8
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HistorySearchCollectionViewCell: UICollectionViewCell {
    // MARK: - Propertiess
    @IBOutlet weak var historyQueryCollectionView: UICollectionView!
    
    var numberOfHistory: Int = 4
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
       super.awakeFromNib()
        
        let layout = HistoryFlowLayout()
        
        historyQueryCollectionView.collectionViewLayout = layout
        
        historyQueryCollectionView.delegate = self
        historyQueryCollectionView.dataSource = self
        
        self.addSubview(historyQueryCollectionView)
        
        
    }
 
    
}

extension HistorySearchCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfHistory
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryQueryCollectionViewCell.reuseIdentifier, for: indexPath) as? HistoryQueryCollectionViewCell else { return UICollectionViewCell() }
        
        print("히스토리", #function)
        cell.configureQuery(query: "\(indexPath.item)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }
    
    
}
