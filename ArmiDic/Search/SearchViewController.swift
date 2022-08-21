//
//  SearchViewController.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit
import Toast

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var query = "" {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var numberOfResult = 0
    var numberOfHistory = 3
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        
        return searchBar
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.placeholder = "찾으려는 단어를 입력해주세요"
        
    }
    // MARK: - Actions
    
    // MARK: - Helpers
    
    
}

// MARK: - Collection View


extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    /// 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfResult == 0 ? 1 : numberOfResult
        
    }
    
    /// 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if query.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistorySearchCollectionViewCell.reuseIdentifier, for: indexPath) as? HistorySearchCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
        } else if numberOfResult == 0 {
            // 빈 검색결과 셀 보여주기
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptySearchCollectionViewCell.reuseIdentifier, for: indexPath) as? EmptySearchCollectionViewCell else { return UICollectionViewCell() }
            cell.configureLabel(query: self.query)
            return cell
            
        } else {
            //검색결과 세팅하기
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
            
        }
        
        
    }
    
    /// 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let inset: CGFloat = 20
        
        let cellWidth: CGFloat = width - (inset * 2)
        
        
        
        if numberOfResult == 0 {
            // 검색결과 없을 시 셀 크기
            
            return CGSize(width: cellWidth, height: 250)
            
        } else {
            // 검색결과 셀 크기
            return CGSize(width: cellWidth, height: 102)
        }
        
        
        
    }
    
    /// 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchCollectionReusableView.reuseIdentifier, for: indexPath) as? SearchCollectionReusableView else { return UICollectionReusableView() }
        
        
        header.searchBar = self.searchBar
        
        return header
        
        
    }
}


// MARK: - 검색바 Delegate
extension SearchViewController: UISearchBarDelegate {

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        print("취소버튼 클릭")
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
        print("검색")

        
    }
    
    func keyboardDismiss() {
        searchBar.resignFirstResponder()
    }
}
