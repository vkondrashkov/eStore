//
//  LaptopEditorBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class LaptopEditorBuilderImpl {
    private let dependency: LaptopEditorDependency

    init(dependency: LaptopEditorDependency) {
        self.dependency = dependency
    }
}

// MARK: - LaptopEditorBuilder implementation

extension LaptopEditorBuilderImpl: LaptopEditorBuilder {
    func build(with laptop: Laptop?) -> LaptopEditorCoordinatorProvidable {
        let view = LaptopEditorViewImpl()
        let coordinator = LaptopEditorCoordinator(
            scene: dependency.laptopEditorScene,
            view: view
        )
        let presenter = LaptopEditorPresenterImpl(
            view: view,
            router: coordinator,
            interactor: LaptopEditorInteractorImpl(
                userRepository: dependency.userRepository,
                productsUseCase: dependency.productsUseCase
            )
        )
        presenter.laptop = laptop
        view.coordinator = coordinator
        view.presenter = presenter
        return view
    }
}
