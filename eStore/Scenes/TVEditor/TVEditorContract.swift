//
//  LaptopEditorContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol TVEditorDependency: AnyObject {
    var tvEditorScene: TVEditorScene { get }
    var userRepository: UserRepository { get }
    var productsUseCase: ProductsUseCase { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol TVEditorCoordinatorProvidable: AnyObject {
    var coordinator: TVEditorCoordinator! { get }
}

protocol TVEditorBuilder: AnyObject {
    func build(with tv: TV?) -> TVEditorCoordinatorProvidable
}

protocol TVEditorScene: AnyObject {
    func play(viewController: UIViewController)
    func stop(completion: @escaping () -> Void)
}

protocol TVEditorRouter: AnyObject {
    func terminate()
}

protocol TVEditorView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func display(imageUrl: String)
    func display(name: String)
    func display(brandName: String)
    func display(operatingSystem: OperatingSystem)
    func display(displayWidth: String)
    func display(displayHeight: String)
    func display(price: String)
}

protocol TVEditorPresenter: AnyObject {
    func handleLoadView()
    func handleDonePress(tvForm: TVForm)
}

enum TVEditorInteractorError: Error {
    case failed
    case notAuthorized
}

protocol TVEditorInteractor: AnyObject {
    var currentUser: User? { get }
    func addTV(tvForm: TVForm,
               completion: @escaping (Result<TV, TVEditorInteractorError>) -> Void)
    func updateTV(tvId: Int,
                  tvForm: TVForm,
                  completion: @escaping (Result<TV, TVEditorInteractorError>) -> Void)
}
