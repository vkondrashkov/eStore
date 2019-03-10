//
//  GoodsListPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class GoodsListPresenterImpl {
    private unowned let view: GoodsListView
    private unowned let router: GoodsListRouter

    init(view: GoodsListView, router: GoodsListRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - GoodsListPresenter implementation
extension GoodsListPresenterImpl: GoodsListPresenter {
    func handleLoadView() {
        // Temp
        view.showActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.view.hideActivityIndicator()
        })
    }

    func handleProductPress(storeItem: StoreItem) {
        router.showGoodsDescription(for: storeItem)
    }
}
