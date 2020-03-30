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

    var smartphone: Smartphone?

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
    func handleLoadView() {
        if let smartphone = smartphone {
            view?.display(imageUrl: smartphone.imageUrl ?? "")
            view?.display(name: smartphone.name)
            view?.display(brandName: smartphone.brandName)
            view?.display(operatingSystem: smartphone.operatingSystem)
            view?.display(displayWidth: String(smartphone.display.width))
            view?.display(displayHeight: String(smartphone.display.height))
            view?.display(ramCapacity: String(smartphone.ramCapacity))
            view?.display(memoryCapacity: String(smartphone.memoryCapacity))
            view?.display(processorName: smartphone.processorName)
            view?.display(color: smartphone.color)
            view?.display(batteryCapacity: String(smartphone.batteryCapacity))
            view?.display(price: String(smartphone.price))
        }
    }

    func handleDonePress(smartphoneForm: SmartphoneForm) {
        if let smartphone = smartphone {
            interactor.updateSmartphone(
                smartphoneId: smartphone.id,
                smartphoneForm: smartphoneForm,
                completion: { [weak self] _ in
                    self?.router?.terminate()
                }
            )
        } else {
            interactor.addSmartphone(
                smartphoneForm: smartphoneForm,
                completion: { [weak self] result in
                    guard result.error == nil else {
                        self?.view?.display(alert: Alert(
                            title: "Already exists!",
                            message: "Such product already exists in database",
                            alertType: .singleAction,
                            primaryCaption: "OK",
                            primaryAction: nil,
                            secondaryCaption: nil,
                            secondaryAction: nil
                        ))
                        return
                    }
                    self?.router?.terminate()
                }
            )
        }
    }
}
