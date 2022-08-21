//
//  UserDefaultsManager.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import Foundation

class LandscapeManager {
    static let shared = LandscapeManager()
    // 앱이 처음 열린건지 아닌지 체크하는 요소
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(!newValue, forKey: #function)
        }
    }
 
}

class FavoriteManger {
    static let shared = FavoriteManger()
    
    var favorite: [Int] {
        get {
            UserDefaults.standard.array(forKey: #function) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.removeObject(forKey: #function)
            
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
    
}

class SearchHistoryManger {
    static let shared = SearchHistoryManger()
    
    var searchHistory: [String] {
        get {
            UserDefaults.standard.array(forKey: #function) as? [String] ?? []
        }
        set {
            UserDefaults.standard.removeObject(forKey: #function)
            
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
    
}
