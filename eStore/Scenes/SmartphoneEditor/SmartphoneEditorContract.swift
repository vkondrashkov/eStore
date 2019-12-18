//
//  SmartphoneEditorContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol SmartphoneEditorDependency: AnyObject {
    var smartphoneEditorScene: SmartphoneEditorScene { get }
    var userRepository: UserRepository { get }
    var productsUseCase: ProductsUseCase { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol SmartphoneEditorCoordinatorProvidable: AnyObject {
    var coordinator: SmartphoneEditorCoordinator! { get }
}

protocol SmartphoneEditorBuilder: AnyObject {
    func build(with smartphone: Smartphone?) -> SmartphoneEditorCoordinatorProvidable
}

protocol SmartphoneEditorScene: AnyObject {
    func play(viewController: UIViewController)
    func stop(completion: @escaping () -> Void)
}

protocol SmartphoneEditorRouter: AnyObject {
    func terminate()
}

protocol SmartphoneEditorView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func display(imageUrl: String)
    func display(name: String)
    func display(brandName: String)
    func display(operatingSystem: OperatingSystem)
    func display(displayWidth: String)
    func display(displayHeight: String)
    func display(ramCapacity: String)
    func display(memoryCapacity: String)
    func display(processorName: String)
    func display(color: String)
    func display(batteryCapacity: String)
    func display(price: String)
}

protocol SmartphoneEditorPresenter: AnyObject {
    func handleLoadView()
    func handleDonePress(smartphoneForm: SmartphoneForm)
}

enum SmartphoneEditorInteractorError: Error {
    case failed
    case notAuthorized
}

protocol SmartphoneEditorInteractor: AnyObject {
    var currentUser: User? { get }
    func addSmartphone(smartphoneForm: SmartphoneForm,
                       completion: @escaping (Result<Smartphone, SmartphoneEditorInteractorError>) -> Void)
    func updateSmartphone(smartphoneId: Int,
                          smartphoneForm: SmartphoneForm,
                          completion: @escaping (Result<Smartphone, SmartphoneEditorInteractorError>) -> Void)
}
