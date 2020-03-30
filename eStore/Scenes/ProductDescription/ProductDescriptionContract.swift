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
    var userRepository: UserRepository { get }
    var cartRepository: CartRepository { get }
    var productsUseCase: ProductsUseCase { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol ProductDescriptionBuilder: AnyObject {
    func build(with storeItem: StoreItem) -> ProductDescriptionCoordinator
}

protocol ProductDescriptionScene: AnyObject {
    func play(productDescriptionShow: ProductDescriptionShow)
}

protocol ProductDescriptionRouter: AnyObject {
    func showSmartphoneEditor(smartphone: Smartphone)
    func showLaptopEditor(laptop: Laptop)
    func showTVEditor(tv: TV)
}

protocol ProductDescriptionShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol ProductDescriptionView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func update(storeItem: StoreItem)
    func hideActivityIndicator()
    func display(rightBarButtonTitle: String)
}

protocol ProductDescriptionPresenter: AnyObject {
    func handleLoadView()
    func handleRefresh(storeItem: StoreItem)
    func handleEditPress(storeItem: StoreItem)
    func cartAddButtonDidPress(id: Int, productTypeId: Int)
}

enum ProductDescriptionInteractorError: Error {
    case failed
    case notAuthorized
}

protocol ProductDescriptionInteractor {
    var currentUser: User? { get }
    func addToCart(productId: Int, productTypeId: Int, completion: @escaping (ProductDescriptionInteractorError?) -> Void)
    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductDescriptionInteractorError>) -> Void)
    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductDescriptionInteractorError>) -> Void)
    func fetchTV(id: String, completion: @escaping (Result<TV, ProductDescriptionInteractorError>) -> Void)
}
