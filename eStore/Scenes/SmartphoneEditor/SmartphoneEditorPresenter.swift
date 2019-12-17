//
//  SmartphoneEditorPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SmartphoneEditorPresenterImpl {
    private weak var view: SmartphoneEditorView?
    private weak var router: SmartphoneEditorRouter?
    private let interactor: SmartphoneEditorInteractor

    init(view: SmartphoneEditorView,
         router: SmartphoneEditorRouter,
         interactor: SmartphoneEditorInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SmartphoneEditorPresenter implementation

extension SmartphoneEditorPresenterImpl: SmartphoneEditorPresenter {
    func handleLoadView() { }

    func handleDonePress(smartphoneForm: SmartphoneForm) {
        interactor.addSmartphone(
            smartphoneForm: smartphoneForm,
            completion: { [weak self] _ in
                self?.router?.terminate()
            }
        )
    }
}
