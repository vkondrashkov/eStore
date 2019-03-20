//
//  ProductDescriptionPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class ProductDescriptionPresenterImpl {
    private unowned let view: ProductDescriptionView
    
    init(view: ProductDescriptionView) {
        self.view = view
    }
}

// MARK: - ProductDescriptionPresenter implementation
extension ProductDescriptionPresenterImpl: ProductDescriptionPresenter {
    func handleLoadView() {
        
    }
}
