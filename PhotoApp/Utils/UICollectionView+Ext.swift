//
//  UICollectionView+Ext.swift
//  PhotoApp
//
//  Created by Nguyễn Việt on 19/08/2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionReusableView {
    static var resueIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(_ type: T.Type, _ kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.resueIdentifier)
    }

    func reuse<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func reuse<T: UICollectionReusableView>(_ type: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.resueIdentifier, for: indexPath) as! T
    }
    
}
