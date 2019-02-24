//
//  GoodsListView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsListViewImpl: UIViewController {
    var presenter: GoodsListPresenter!
}

// MARK: - GoodsListView implementation
extension GoodsListViewImpl: GoodsListView {
    
}

// MARK: - GoodsListShow implementation
extension GoodsListViewImpl: GoodsListShow {
    var rootViewController: UIViewController {
        return self
    }
}
