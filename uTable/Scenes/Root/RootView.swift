//
//  RootView.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootViewImpl: UIViewController {
    var presenter: RootPresenter!

    override func loadView() {
        view = UIView()
        view.backgroundColor = .purple // Temp
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.handleLoadView()
    }
}

// MARK: - RootView implementation
extension RootViewImpl: RootView { }

// MARK: - RootShow implementation
extension RootViewImpl: RootShow {
    var viewController: UIViewController {
        return self
    }
}
