//
//  LaptopEditorPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class LaptopEditorPresenterImpl {
    private weak var view: LaptopEditorView?
    private weak var router: LaptopEditorRouter?
    private let interactor: LaptopEditorInteractor

    init(view: LaptopEditorView,
         router: LaptopEditorRouter,
         interactor: LaptopEditorInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - LaptopEditorPresenter implementation

extension LaptopEditorPresenterImpl: LaptopEditorPresenter {
    func handleLoadView() { }

    func handleDonePress(laptopForm: LaptopForm) {
        interactor.addLaptop(
            laptopForm: laptopForm,
            completion: { [weak self] _ in
                self?.router?.terminate()
            }
        )
    }
}
