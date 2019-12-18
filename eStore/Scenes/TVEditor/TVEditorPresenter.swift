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

    var tv: TV?

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
    func handleLoadView() {
        if let tv = tv {
            view?.display(imageUrl: tv.imageUrl ?? "")
            view?.display(name: tv.name)
            view?.display(brandName: tv.brandName)
            view?.display(operatingSystem: tv.operatingSystem)
            view?.display(displayWidth: String(tv.display.width))
            view?.display(displayHeight: String(tv.display.height))
            view?.display(price: String(tv.price))
        }
    }

    func handleDonePress(tvForm: TVForm) {
        if let tv = tv {
            interactor.updateTV(
                tvId: tv.id,
                tvForm: tvForm,
                completion: { [weak self] _ in
                    self?.router?.terminate()
                }
            )
        } else {
            interactor.addTV(
                tvForm: tvForm,
                completion: { [weak self] _ in
                    self?.router?.terminate()
                }
            )
        }
    }
}
