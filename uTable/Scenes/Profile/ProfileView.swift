//
//  ProfileView.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileViewImpl: UIViewController {
    var presenter: ProfilePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// MARK: - RootView implementation
extension ProfileViewImpl: ProfileView { }

// MARK: - RootShow implementation
extension ProfileViewImpl: ProfileShow {
    var viewController: UIViewController {
        return self
    }
}
