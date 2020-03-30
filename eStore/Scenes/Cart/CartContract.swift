//
//  CartContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol CartDependency: AnyObject {
    var cartNavigation: UINavigationController { get }
    var userRepository: UserRepository { get }
    var cartRepository: CartRepository { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol CartBuilder: AnyObject {
    func build() -> CartCoordinator
}

protocol CartScene: AnyObject {
    func play(cartShow: CartShow)
}

protocol CartShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol CartRouter: AnyObject {
    func showProductDescription(for storeItem: StoreItem)
}

protocol CartView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func showActivityIndicator()
    func hideActivityIndicator()
    func display(storeItemList: [StoreItem])
}

protocol CartPresenter: AnyObject {
    func handleLoadView()
    func shouldViewAppear()
    func handleRefresh()
    func handleProductPress(storeItem: StoreItem)
    func handleProductDelete(storeItem: StoreItem)
}

enum CartInteractorError: Error {
    case failed
    case invalidData
    case notAuthorized
}

protocol CartInteractor: AnyObject {
    func fetch(completion: @escaping (Result<[CartItem], CartInteractorError>) -> Void)
    func delete(storeItemId: Int, completion: @escaping (CartInteractorError?) -> Void)
}
