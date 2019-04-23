//
//  UICollectionView+Generic.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/22/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReuseIdentifiable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UICollectionViewCell>(_: T.Type) where T: ReuseIdentifiable, T: NibLoadable {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReuseIdentifiable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier) at indexPath: \(indexPath)")
        }
        return cell
    }
}
