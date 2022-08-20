//
//  ViewController.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/20.
//

import UIKit


class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    let pagination = 10
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers


}

// MARK: - Collection View Setup
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagination // 나중에 페이지네이션
    }
    
    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
                
        cell.configureUI()
        return cell
    }
    
    // 셀 사이즈
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let inset: CGFloat = 20
        let margin: CGFloat = 8
        let size: CGFloat = (deviceWidth - (inset * 2) - (margin * 2)) / 3
        
        return CGSize(width: size, height: size)
                             
    }
    
    // 헤더
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionReusableView.reuseIdentifier, for: indexPath) as? HomeCollectionReusableView else { return UICollectionReusableView() }
        
        header.configureUI()
        
        return header
    }
    
    
}
