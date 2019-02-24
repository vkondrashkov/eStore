//
//  CatalogContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol CatalogDependency: AnyObject {
    var catalogNavigation: UINavigationController { get }
}

protocol CatalogBuilder: AnyObject {
    func build() -> CatalogCoordinator
}

protocol CatalogScene: AnyObject {
    func play(catalogShow: CatalogShow)
}

protocol CatalogShow: AnyObject {
    var viewController: UIViewController { get }
}

protocol CatalogRouter: AnyObject {

}

protocol CatalogView: AnyObject {

    func display(alert: Alert)
}

protocol CatalogPresenter: AnyObject {
    func handleLoadView()
}
