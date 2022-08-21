//
//  SearchViewController.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

enum SearchCell: Int {
    case history = 0
    case result = 1
}

class SearchViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfResult: Int = 4
    var numberOfHistory: Int = 7
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        

    }
    

}

// MARK: - TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 검색기록 , 검색결과
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SearchCell.history.rawValue {
            return 1
        } else if section == SearchCell.result.rawValue {
            return numberOfResult == 0 ? 1 : numberOfResult
        } else {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == SearchCell.history.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.reuseIdentifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
            cell.historyQueryCollectionView.delegate = self
            cell.historyQueryCollectionView.dataSource = self
            
            return cell
            
        } else if indexPath.section == SearchCell.result.rawValue {
            if numberOfResult == 0 {
                // 결과가 없을 때
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchEmptyTableViewCell.reuseIdentifier, for: indexPath) as? SearchEmptyTableViewCell else { return UITableViewCell() }
                
                return cell
                
            } else {
                // 결과가 1개 이상 있을 때
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath)  as? SearchResultTableViewCell else { return UITableViewCell() }
                
                return cell
            }
        } else {
            return UITableViewCell()
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return nil }
        else { return "검색결과"}
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchHeaderView.reuseIdentifier) as? SearchHeaderView else { return nil }
            
            header.searchBar = searchBar
            return header
            
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 88
        } else {
            return 126
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }  else {
            return 20
        }
        
    }
    
   
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfHistory
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryQueryCollectionViewCell.reuseIdentifier, for: indexPath) as? HistoryQueryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureLabel(query: "검색어 \(indexPath)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72,height: 44)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}
