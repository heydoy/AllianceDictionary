//
//  String+Extension.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/10/31.
//

import Foundation

extension String {
    // 다국어대응 관련 프로퍼티와 메서드
    var localized: String {
           Bundle.main.localizedString(forKey: self, value: nil, table: nil)
       }
       
   func localized(arguments: CVarArg...) -> String{
       String(format: self.localized, arguments: arguments)
   }
}
