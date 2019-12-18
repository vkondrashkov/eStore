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

    var laptop: Laptop?

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
    func handleLoadView() {
        if let laptop = laptop {
            view?.display(imageUrl: laptop.imageUrl ?? "")
            view?.display(name: laptop.name)
            view?.display(brandName: laptop.brandName)
            view?.display(operatingSystem: laptop.operatingSystem)
            view?.display(displayWidth: String(laptop.display.width))
            view?.display(displayHeight: String(laptop.display.height))
            view?.display(ramCapacity: String(laptop.ramCapacity))
            view?.display(memoryCapacity: String(laptop.memoryCapacity))
            view?.display(processorName: laptop.processorName)
            view?.display(graphicsAdapter: laptop.graphicsAdapter)
            view?.display(color: laptop.color)
            view?.display(batteryCapacity: String(laptop.batteryCapacity))
            view?.display(price: String(laptop.price))
        }
    }

    func handleDonePress(laptopForm: LaptopForm) {
        if let laptop = laptop {
            interactor.updateLaptop(
                laptopId: laptop.id,
                laptopForm: laptopForm,
                completion: { [weak self] _ in
                    self?.router?.terminate()
                }
            )
        } else {
            interactor.addLaptop(
                laptopForm: laptopForm,
                completion: { [weak self] _ in
                    self?.router?.terminate()
                }
            )
        }
    }
}
