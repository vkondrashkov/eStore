//
//  GoodsDescriptionView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsDescriptionViewImpl: UIViewController {
    var presenter: GoodsDescriptionPresenter!

}

// MARK: - GoodsDescriptionView implementation
extension GoodsDescriptionViewImpl: GoodsDescriptionView {
    
}

// MARK: - GoodsListShow implementation
extension GoodsDescriptionViewImpl: GoodsDescriptionShow {
    var rootViewController: UIViewController {
        return self
    }
}
