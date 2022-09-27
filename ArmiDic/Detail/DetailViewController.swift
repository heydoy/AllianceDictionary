//
//  DetailViewController.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit
import Toast

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    @IBOutlet weak var pasteClipboardButton: UIButton!
    
    @IBOutlet weak var koreanLabel: UILabel!
    
    @IBOutlet weak var abbreviationLabel: UILabel!
    
    @IBOutlet weak var englishLabel: UILabel!
    
    var voca: ArmyJargon = ArmyJargon()
    
    var favoriteList: [Int] = FavoriteManger.shared.favorite
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureData(voca: voca)
        configureButton()
    }
    
    // MARK: - Actions
    
    func configureButton() {
        addFavoriteButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        
        if favoriteList.contains(voca.index) {
            addFavoriteButton.backgroundColor = .systemGray2
            
            addFavoriteButton.setTitle("즐겨찾기됨", for: .normal)
            
        } else {
            addFavoriteButton.backgroundColor = .systemRed
            addFavoriteButton.setTitle("즐겨찾기에 추가", for: .normal)
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("DetailViewClosed"), object: nil, userInfo: nil) 
        
        self.dismiss(animated: true)
    }
    
    @IBAction func addFavoriteButtonTapped(_ sender: UIButton) {
        
        if favoriteList.contains(voca.index) {
            
            
            if let index = favoriteList.firstIndex(of: voca.index) {
                
                let alert = UIAlertController(title: "즐겨찾기에서 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
                
                let remove = UIAlertAction(title: "삭제", style: .destructive) { _ in
                    self.favoriteList.remove(at: index)
                    FavoriteManger.shared.favorite = self.favoriteList
                    self.view.makeToast("🔖 즐겨찾기에서 해제되었습니다.", duration: 0.3, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                    self.configureButton()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                
                alert.addAction(remove)
                alert.addAction(cancel)
                
                present(alert, animated: true)
            }
            
        }
        else {
            self.view.makeToast("🔖 즐겨찾기에 추가되었습니다.", duration: 0.3, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            
            favoriteList.append(voca.index)
            
            FavoriteManger.shared.favorite = favoriteList
        }
        
        configureButton()
        
    }
    
    @IBAction func pasteToClipboardButtonTapped(_ sender: UIButton) {
        
        
        UIPasteboard.general.string =
        """
        🇰🇷 한국어 : \(voca.ko)\n
        ▷ 약어 : \(voca.abbr)\n
        🇺🇸 영어 : \(voca.en)
        """
        
        self.view.makeToast("클립보드에 복사되었습니다", duration: 0.3, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        
    }
    

    
    
    
    // MARK: - Helpers
    
    func configureData(voca: ArmyJargon) {
        koreanLabel.text = "🇰🇷 " + voca.ko
        abbreviationLabel.text = "▷ " + voca.abbr
        englishLabel.text = "🇺🇸 " + voca.en
    }
    
    func configureUI() {
        
        baseView.layer.cornerRadius = 12
        
        addFavoriteButton.layer.cornerRadius = 8
        
        pasteClipboardButton.layer.cornerRadius = 8
        
        
    }


}
