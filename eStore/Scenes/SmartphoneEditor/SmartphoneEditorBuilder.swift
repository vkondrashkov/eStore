//
//  SmartphoneEditorBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SmartphoneEditorBuilderImpl {
    private let dependency: SmartphoneEditorDependency

    init(dependency: SmartphoneEditorDependency) {
        self.dependency = dependency
    }
}

// MARK: - SmartphoneEditorBuilder implementation

extension SmartphoneEditorBuilderImpl: SmartphoneEditorBuilder {
    func build(with smartphone: Smartphone?) -> SmartphoneEditorCoordinatorProvidable {
        let view = SmartphoneEditorViewImpl()
        let coordinator = SmartphoneEditorCoordinator(
            scene: dependency.smartphoneEditorScene,
            view: view
        )
        let presenter = SmartphoneEditorPresenterImpl(
            view: view,
            router: coordinator,
            interactor: SmartphoneEditorInteractorImpl(
                userRepository: dependency.userRepository,
                productsUseCase: dependency.productsUseCase
            )
        )
        presenter.smartphone = smartphone
        view.coordinator = coordinator
        view.presenter = presenter
        return view
    }
}
