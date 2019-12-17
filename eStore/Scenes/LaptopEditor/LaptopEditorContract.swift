//
//  LaptopEditorContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol LaptopEditorDependency: AnyObject {
    var laptopEditorScene: LaptopEditorScene { get }
    var userRepository: UserRepository { get }
    var productsUseCase: ProductsUseCase { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol LaptopEditorCoordinatorProvidable: AnyObject {
    var coordinator: LaptopEditorCoordinator! { get }
}

protocol LaptopEditorBuilder: AnyObject {
    func build() -> LaptopEditorCoordinatorProvidable
}

protocol LaptopEditorScene: AnyObject {
    func play(viewController: UIViewController)
    func stop(completion: @escaping () -> Void)
}

protocol LaptopEditorRouter: AnyObject {
    func terminate()
}

protocol LaptopEditorView: AnyObject, ThemeUpdatable, AlertDisplayable {
}

protocol LaptopEditorPresenter: AnyObject {
    func handleLoadView()
    func handleDonePress(laptopForm: LaptopForm)
}

enum LaptopEditorInteractorError: Error {
    case failed
    case notAuthorized
}

protocol LaptopEditorInteractor: AnyObject {
    var currentUser: User? { get }
    func addLaptop(laptopForm: LaptopForm,
                   completion: @escaping (Result<Laptop, LaptopEditorInteractorError>) -> Void) 
}
