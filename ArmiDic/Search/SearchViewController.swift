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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var result: [ArmyJargon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var history: [String] = [] {
        didSet {
            if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SearchHistoryTableViewCell {
               cell.historyQueryCollectionView.reloadData()
            }
        }
    }
    let vocaList = ArmyJargonManager.shared.getStruct()
    var query: String = "" {
        didSet {
            searchBar.text = query
        }
    }
    
    
    

    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        history = SearchHistoryManger.shared.searchHistory
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        searchBar.delegate = self

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
            return result.count == 0 ? 1 : result.count
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
            if result.count == 0 {
                // 결과가 없을 때
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchEmptyTableViewCell.reuseIdentifier, for: indexPath) as? SearchEmptyTableViewCell else { return UITableViewCell() }
                
                if query.isEmpty {
                    cell.setLabel(query: "")
                }
                else {
                cell.setLabel(query: "\(query)에 대한 검색결과가 없습니다.")
                }
                
                return cell
                
            } else {
                // 결과가 1개 이상 있을 때
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath)  as? SearchResultTableViewCell else { return UITableViewCell() }
                
                cell.configureData(voca: result[indexPath.item])
                
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if history.count == 0 { return 44}
            else { return 88 }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        goDetail(index: indexPath.item)
    }
    
   
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return history.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryQueryCollectionViewCell.reuseIdentifier, for: indexPath) as? HistoryQueryCollectionViewCell else { return UICollectionViewCell() }
        
        if history.count >= indexPath.item {
            cell.configureLabel(query: "\(history[indexPath.item])")
            cell.removeQueryButton.tag = indexPath.item
            cell.removeQueryButton.addTarget(self, action: #selector(removeHistory), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 72,height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        query = history[indexPath.item]
        searchVoca()
    }
    
    @objc func removeHistory(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "\(history[sender.tag])을/를 검색기록에서 지우시겠습니까?", message: nil, preferredStyle: .alert)
        
        let remove = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.history.remove(at: sender.tag)
            SearchHistoryManger.shared.searchHistory = self.history
            self.history = SearchHistoryManger.shared.searchHistory
            
            self.view.makeToast("삭제완료")
            
            if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SearchHistoryTableViewCell {
               cell.historyQueryCollectionView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(remove)
        alert.addAction(cancel)
        
        if history.count > sender.tag {
            present(alert, animated: true)
            
        } else {
            view.makeToast("잘못된 요청입니다.")
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    private func dissmissKeyboard() {
            searchBar.resignFirstResponder()
        }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            // 검색어 저장
            history.append(text)
            SearchHistoryManger.shared.searchHistory = history
            history = SearchHistoryManger.shared.searchHistory
            

            // 검색결과 호출
            query = text
            searchVoca()


            dissmissKeyboard()

        }
    }

    func searchVoca() {
        result = []

        for item in vocaList{
            let ko = item.ko
            let abbr = item.abbr
            let en = item.en
            if ko.contains(query) || abbr.contains(query) ||
                en.contains(query) {
                result.append(item)
                tableView.reloadData()
            }
        }
        tableView.reloadData()
    }



}

extension SearchViewController {
    func goDetail(index: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else {  return }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        
        // 데이터 전달하기
        vc.voca = result[index]
        
        self.present(vc, animated: true)
    }
}

