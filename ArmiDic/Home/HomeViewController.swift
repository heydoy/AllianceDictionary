//
//  ViewController.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/20.
//

import UIKit
import SwiftyJSON


class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    var startPage = 0
    let displayPage = 30
    var totalCount = 0
    
    var vocaList: [ArmyJargon] = []
    var recommendVocaNo = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        getVoca()
        
    }
    
    // MARK: - Actions
    func getVoca() {
        let list: [ArmyJargon] = Array(ArmyJargonManager.shared.getStruct()[startPage...(displayPage + startPage)])
        
        vocaList.append(contentsOf: list)
        
        collectionView.reloadData()

    }
    
    
    // MARK: - Helpers


}

// MARK: - Collection View Setup
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vocaList.count // 나중에 페이지네이션
    }
    
    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
                
        cell.configureUI()
        
        cell.configureLabel(voca: vocaList[indexPath.item])
        
        return cell
    }
    
    // 셀 사이즈
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let inset: CGFloat = 20
        let margin: CGFloat = 8
        let size: CGFloat = (deviceWidth - (inset * 2) - (margin * 1)) / 2
        
        return CGSize(width: size, height: size)
                             
    }
    
    // 헤더
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionReusableView.reuseIdentifier, for: indexPath) as? HomeCollectionReusableView else { return UICollectionReusableView() }
        
        header.configureUI()
        
        if vocaList.count > 0 {
            let index = Int.random(in: 0..<vocaList.count)
            recommendVocaNo = index
            header.configureLabel(voca: vocaList[index])
            header.headerDidTapped = { [weak self] in
                self?.goDetail(index: index)
            }
        }

        return header
    }
    
    /// 셀 선택되었을 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        goDetail(index: indexPath.item)
    }
    
    
}

// MARK: - CollectionView Actions
extension HomeViewController {
    
    @objc func goDetail(index: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else {  return }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        
        // 데이터 전달하기
        vc.voca = vocaList[index]
        
        self.present(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSourcePrefetching {
    // 셀이 화면에 보이기 직전 필요한 리소스를 미리 다운받을 수 있는 기능이 주목적
       func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
           for indexPath in indexPaths {
               if vocaList.count - 1 == indexPath.item {
                   startPage += displayPage
                 
                   getVoca()
               }
           }
       }
       
       // 프리페칭을 취소하는 메서드
       func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
       }
}
