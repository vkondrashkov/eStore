//
//  SmartphoneEditorScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SmartphoneEditorSceneImpl {
    weak var navigation: UINavigationController?

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - SmartphoneEditorScene implementation
extension SmartphoneEditorSceneImpl: SmartphoneEditorScene {
    func play(viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true
        navigation?.pushViewController(viewController, animated: true)
    }

    func stop(completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigation?.popViewController(animated: true)
        CATransaction.commit()
    }
}
