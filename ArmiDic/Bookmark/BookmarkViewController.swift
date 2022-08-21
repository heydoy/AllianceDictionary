//
//  BookmarkViewController.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class BookmarkViewController: UIViewController {
    // MARK: - Properties
    
    var favoriteList: [Int] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let vocaList: [ArmyJargon] = ArmyJargonManager.shared.getStruct()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        favoriteList = FavoriteManger.shared.favorite
        
        NotificationCenter.default.addObserver(self, selector: #selector(detailViewCloseObserver), name: NSNotification.Name("DetailViewClosed"), object: nil)

    }
    

    @objc func detailViewCloseObserver(_ notification: NSNotification) {
        favoriteList = FavoriteManger.shared.favorite
    }
    
    // MARK: - Actions
    
    
    // MARK: - Helpers


}

extension BookmarkViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    /// 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count == 0 ? 1 : favoriteList.count
    }
    
    /// 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if favoriteList.count == 0 {
            // 단어가 없다고 보여주기
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyBookmarkCollectionViewCell.reuseIdentifier , for: indexPath) as? EmptyBookmarkCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.reuseIdentifier, for: indexPath) as? BookmarkCollectionViewCell else { return UICollectionViewCell() }
            cell.configureUI()
            cell.configureData(voca: vocaList[favoriteList[indexPath.item]])
            return cell
        }
    }
    
    /// 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = UIScreen.main.bounds.width
        let inset: CGFloat = 20
        
        let cellWidth: CGFloat = width - (inset * 2)
        
        if favoriteList.count == 0 {
            return CGSize(width: cellWidth, height: 220)
            
        } else {
            let margin: CGFloat = 8
            let cellSize: CGFloat = (cellWidth - margin ) / 2
            
            return CGSize(width: cellSize, height: cellSize)
        }
    }
    
    /// 셀 선택했을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        goDetail(index: favoriteList[indexPath.item])
    }
    
    /// 헤더
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BookmarkCollectionReusableView.reuseIdentifier, for: indexPath) as? BookmarkCollectionReusableView else { return UICollectionReusableView() }
        
        return header
        
    }
}

extension BookmarkViewController {
    func goDetail(index: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else {  return }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        
        // 데이터 전달하기
        vc.voca = vocaList[index]
        
        self.present(vc, animated: true)
        
        
    }
}
