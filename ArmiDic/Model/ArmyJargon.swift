//
//  Dictionary.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/20.
//

import Foundation


struct ArmyJargons: Codable {
    var list: [ArmyJargon]
}


struct ArmyJargon: Codable {
    
    // 한글, 약어, 영어
    var ko: String
    var abbr: String
    var en: String

}
