//
//  Dictionary.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/20.
//

import Foundation




struct ArmyJargon: Codable {
    
    // 한글, 약어, 영어, 인덱스 
    var ko: String
    var abbr: String
    var en: String
    var index: Int

    init() {
        ko = String()
        abbr = String()
        en = String()
        index = Int()
    }
}
