//
//  ProductsListContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ProductsListDependency: AnyObject {
    var navigation: UINavigationController { get }
    var userRepository: UserRepository { get }
    var productsUseCase: ProductsUseCase { get }
    var cartRepository: CartRepository { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol ProductsListBuilder: AnyObject {
    func build(with productType: ProductType) -> ProductsListCoordinator
}

protocol ProductsListScene: AnyObject {
    func play(productsListShow: ProductsListShow)
}

protocol ProductsListShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol ProductsListRouter: AnyObject {
    func showProductDescription(for storeItem: StoreItem)
    func showSmartphoneEditor()
    func showLaptopEditor()
    func showTVEditor()
}

protocol ProductsListView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func showActivityIndicator()
    func hideActivityIndicator()
    func display(storeItemList: [StoreItem])
    func display(rightBarButtonTitle: String)
}

protocol ProductsListPresenter: AnyObject {
    func handleLoadView()
    func handleProductPress(storeItem: StoreItem)
    func configureEditActions(for indexPath: IndexPath) -> [(title: String, isDestructive: Bool, action: ((StoreItem) -> Void)?)]
    func handleAddProductPress()
}

enum ProductsListInteractorError: Error {
    case failed
    case notAuthorized
}

protocol ProductsListInteractor: AnyObject {
    var currentUser: User? { get }
    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsListInteractorError>) -> Void)
    func deleteSmartphone(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void)
    func fetchTVs(completion: @escaping (Result<[TV], ProductsListInteractorError>) -> Void)
    func deleteTV(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void)
    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsListInteractorError>) -> Void)
    func deleteLaptop(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void)
    func addToCart(productId: Int,
                   productTypeId: Int,
                   completion: @escaping (ProductsListInteractorError?) -> Void)
}
