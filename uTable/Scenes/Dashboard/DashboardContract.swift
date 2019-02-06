//
//  DashboardContract.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol DashboardRouter: AnyObject {
    func routeTimeTable()
    func routeProfile()
}

protocol DashboardViewControllable {
    func present(view: UIViewController)
    func replace(view: UIViewController)
    func dismiss()
}

protocol DashboardView: AnyObject {
    func display(title: String)
}

protocol DashboardPresenter {
    func viewDidLoad()
}
