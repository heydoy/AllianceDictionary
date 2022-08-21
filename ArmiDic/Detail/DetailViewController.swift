//
//  DetailViewController.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    @IBOutlet weak var pasteClipboardButton: UIButton!
    
    @IBOutlet weak var koreanLabel: UILabel!
    
    @IBOutlet weak var abbreviationLabel: UILabel!
    
    @IBOutlet weak var englishLabel: UILabel!
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    // MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    
    // MARK: - Helpers
    func configureUI() {
        
        baseView.layer.cornerRadius = 12
        
        addFavoriteButton.layer.cornerRadius = 8
        
        pasteClipboardButton.layer.cornerRadius = 8
        
        
    }


}
