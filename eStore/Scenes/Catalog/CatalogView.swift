//
//  CatalogView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CatalogViewImpl: UIViewController {
    var presenter: CatalogPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

// MARK: - CatalogView implementation
extension CatalogViewImpl: CatalogView {
    func display(alert: Alert) {
        
    }
}

// MARK: - CatalogShow implementation
extension CatalogViewImpl: CatalogShow {
    var viewController: UIViewController {
        return self
    }
}
