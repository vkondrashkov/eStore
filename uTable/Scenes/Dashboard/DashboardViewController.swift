//
//  DashboardViewController.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    var presenter: DashboardPresenter?

    override func loadView() {
        view = UIView()
        view.backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - DashboardView implementation
extension DashboardViewController: DashboardView {
    func display(title: String) {
        // TODO: display(title:) method implementation
    }
}
