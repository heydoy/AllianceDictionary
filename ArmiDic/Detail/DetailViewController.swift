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
            
            addFavoriteButton.setTitle("RemoveFromFavorites".localized, for: .normal)
            
        } else {
            addFavoriteButton.backgroundColor = .systemRed
            addFavoriteButton.setTitle("AddToFavorites".localized, for: .normal)
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("DetailViewClosed"), object: nil, userInfo: nil) 
        
        self.dismiss(animated: true)
    }
    
    @IBAction func addFavoriteButtonTapped(_ sender: UIButton) {
        
        if favoriteList.contains(voca.index) {
            
            
            if let index = favoriteList.firstIndex(of: voca.index) {
                
                let alert = UIAlertController(title: "WantToRemoveFavorite".localized, message: nil, preferredStyle: .alert)
                
                let remove = UIAlertAction(title: "Remove".localized, style: .destructive) { _ in
                    self.favoriteList.remove(at: index)
                    FavoriteManger.shared.favorite = self.favoriteList
                    self.view.makeToast("🔖 "+"RemoveFavorite".localized, duration: 0.3, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                    self.configureButton()
                }
                let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel)
                
                alert.addAction(remove)
                alert.addAction(cancel)
                
                present(alert, animated: true)
            }
            
        }
        else {
            self.view.makeToast("🔖 "+"AddFavorite".localized, duration: 0.3, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            
            favoriteList.append(voca.index)
            
            FavoriteManger.shared.favorite = favoriteList
        }
        
        configureButton()
        
    }
    
    @IBAction func pasteToClipboardButtonTapped(_ sender: UIButton) {
        let abbrReplacedString = voca.abbr.isEmpty ? "-" : voca.abbr

        UIPasteboard.general.string = "PasteboardString".localized(arguments: voca.ko, abbrReplacedString, voca.en)
        
        self.view.makeToast("CopiedToClipboard".localized, duration: 0.4, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        
    }
    

    
    
    
    // MARK: - Helpers
    
    func configureData(voca: ArmyJargon) {
        let abbrReplacedString = voca.abbr.isEmpty ? "-" : voca.abbr
        koreanLabel.text = "🇰🇷 " + voca.ko
        abbreviationLabel.text = "▷ " + abbrReplacedString
        englishLabel.text = "🇺🇸 " + voca.en
    }
    
    func configureUI() {
        
        baseView.layer.cornerRadius = 12
        
        addFavoriteButton.layer.cornerRadius = 8
        
        pasteClipboardButton.layer.cornerRadius = 8
        
        
    }


}
