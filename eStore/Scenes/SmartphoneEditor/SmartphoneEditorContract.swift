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
    func build() -> SmartphoneEditorCoordinatorProvidable
}

protocol SmartphoneEditorScene: AnyObject {
    func play(viewController: UIViewController)
    func stop(completion: @escaping () -> Void)
}

protocol SmartphoneEditorRouter: AnyObject {
    func terminate()
}

protocol SmartphoneEditorView: AnyObject, ThemeUpdatable, AlertDisplayable {
}

protocol SmartphoneEditorPresenter: AnyObject {
    func handleLoadView()
    func handleDonePress(smartphoneForm: SmartphoneForm)
}

//id = try map.value("id")
//imageUrl = try? map.value("imageUrl")
//name = try map.value("name")
//brandName = try map.value("brandName")
//operatingSystem = try OperatingSystem(rawValue: map.value("operatingSystemRawValue")) ?? .unknown
//display = Display(width: try map.value("resolutionWidth"), height: try map.value("resolutionHeight"))
//ramCapacity = try map.value("ramCapacity")
//memoryCapacity = try map.value("memoryCapacity")
//processorName = try map.value("processorName")
//color = try map.value("color")
//batteryCapacity = try map.value("batteryCapacity")
//price = try map.value("price")

enum SmartphoneEditorInteractorError: Error {
    case failed
    case notAuthorized
}

protocol SmartphoneEditorInteractor: AnyObject {
    var currentUser: User? { get }
    func addSmartphone(smartphoneForm: SmartphoneForm,
                       completion: @escaping (Result<Smartphone, SmartphoneEditorInteractorError>) -> Void) 
}
