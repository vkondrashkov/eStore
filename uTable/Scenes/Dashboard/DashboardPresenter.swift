//
//  DashboardPresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

class DashboardPresenterImpl {
    private weak var view: DashboardView?
    weak var router: DashboardRouter?

    init(view: DashboardView) {
        self.view = view
    }
}

// DashboardPresenter implementation
extension DashboardPresenterImpl: DashboardPresenter {
    func viewDidLoad() {
        // TODO: viewDidLoad() method implementation
    }
}
