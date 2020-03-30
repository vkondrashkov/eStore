//
//  TVEditorBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class TVEditorBuilderImpl {
    private let dependency: TVEditorDependency

    init(dependency: TVEditorDependency) {
        self.dependency = dependency
    }
}

// MARK: - TVEditorBuilder implementation

extension TVEditorBuilderImpl: TVEditorBuilder {
    func build(with tv: TV?) -> TVEditorCoordinatorProvidable {
        let view = TVEditorViewImpl()
        let coordinator = TVEditorCoordinator(
            scene: dependency.tvEditorScene,
            view: view
        )
        let presenter = TVEditorPresenterImpl(
            view: view,
            router: coordinator,
            interactor: TVEditorInteractorImpl(
                userRepository: dependency.userRepository,
                productsUseCase: dependency.productsUseCase
            )
        )
        presenter.tv = tv
        view.coordinator = coordinator
        view.presenter = presenter
        return view
    }
}
