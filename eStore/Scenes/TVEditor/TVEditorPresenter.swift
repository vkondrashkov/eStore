//
//  TVEditorPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class TVEditorPresenterImpl {
    private weak var view: TVEditorView?
    private weak var router: TVEditorRouter?
    private let interactor: TVEditorInteractor

    init(view: TVEditorView,
         router: TVEditorRouter,
         interactor: TVEditorInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - LaptopEditorPresenter implementation

extension TVEditorPresenterImpl: TVEditorPresenter {
    func handleLoadView() { }

    func handleDonePress(tvForm: TVForm) {
        interactor.addTV(
            tvForm: tvForm,
            completion: { [weak self] _ in
                self?.router?.terminate()
            }
        )
    }
}
