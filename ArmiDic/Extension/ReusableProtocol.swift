//
//  ReusableProtocol.swift
//  ArmiDic
//
//  Created by Doy Kim on 2022/08/21.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

//extension UICollectionViewCell: ReusableViewProtocol {
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}

extension UICollectionReusableView: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
