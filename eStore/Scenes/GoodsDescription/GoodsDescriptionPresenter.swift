//
//  GoodsDescriptionPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class GoodsDescriptionPresenterImpl {
    private unowned let view: GoodsDescriptionView

    init(view: GoodsDescriptionView) {
        self.view = view
    }
}

// MARK: - GoodsDescriptionPresenter implementation
extension GoodsDescriptionPresenterImpl: GoodsDescriptionPresenter {
    func handleLoadView() {

    }
}
