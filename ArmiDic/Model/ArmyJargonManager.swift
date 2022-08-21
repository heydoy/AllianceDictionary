//
//  HomeViewModel.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit
import SwiftyJSON

class ArmyJargonManager {
    
    private init() {}
    
    static let shared = ArmyJargonManager()
    
    func getStruct() -> [ArmyJargon] {
        var list: [ArmyJargon] = []
        let fileNm: String = "armyvoca"
        // 2. 불러올 파일의 확장자명
        let extensionType = "json"
        
        // 3. 파일 위치
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return list }
        
        
        do {
            // 4. 해당 위치의 파일을 Data로 초기화하기
            let data = try Data(contentsOf: fileLocation)
            let decodedSentences = try JSONDecoder().decode([ArmyJargon].self, from: data)
            list = decodedSentences
            return list
            
            
        } catch {
            // 5. 잘못된 위치나 불가능한 파일 처리 (오늘은 따로 안하기)
            return list
        }
    }
    

    
    
    
}
