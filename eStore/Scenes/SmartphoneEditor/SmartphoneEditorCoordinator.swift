//
//  SmartphoneEditorCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SmartphoneEditorCoordinator {
    private let scene: SmartphoneEditorScene
    private weak var view: UIViewController?

    var onTerminate: (() -> Void)?

    init(scene: SmartphoneEditorScene,
         view: UIViewController?) {
        self.scene = scene
        self.view = view
    }

    func start() {
        guard let view = self.view else {
            assertionFailure("Cannot start \(String(describing: self)), `view` is not set.")
            return
        }
        self.scene.play(viewController: view)
    }

    func stop(completion: @escaping (() -> Void)) {
        self.scene.stop(completion: completion)
    }
}

// MARK: - SmartphoneEditorRouter implementation
extension SmartphoneEditorCoordinator: SmartphoneEditorRouter {
    func terminate() {
        onTerminate?()
    }
}
