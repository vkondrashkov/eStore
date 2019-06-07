//
//  ProductDescriptionContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ProductDescriptionDependency: AnyObject {
    var navigation: UINavigationController { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol ProductDescriptionBuilder: AnyObject {
    func build(with storeItem: StoreItem) -> ProductDescriptionCoordinator
}

protocol ProductDescriptionScene: AnyObject {
    func play(productDescriptionShow: ProductDescriptionShow)
}

protocol ProductDescriptionShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol ProductDescriptionView: AnyObject, ThemeUpdatable, AlertDisplayable { }

protocol ProductDescriptionPresenter: AnyObject {
    func handleLoadView()
    func cartAddButtonDidPress()
}
