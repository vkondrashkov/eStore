//
//  TVEditorCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class TVEditorCoordinator {
    private let scene: TVEditorScene
    private weak var view: UIViewController?

    var onTerminate: (() -> Void)?

    init(scene: TVEditorScene,
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

// MARK: - TVEditorRouter implementation

extension TVEditorCoordinator: TVEditorRouter {
    func terminate() {
        onTerminate?()
    }
}
