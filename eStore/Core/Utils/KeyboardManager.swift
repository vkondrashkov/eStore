//
//  KeyboardManager.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class KeyboardManager {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        viewController?.view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        viewController?.view.endEditing(true)
    }
}
