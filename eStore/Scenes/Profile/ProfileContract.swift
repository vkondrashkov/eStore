//
//  ProfileContract.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ProfileDependency: AnyObject {
    var parent: UINavigationController { get }
}

protocol ProfileBuilder: AnyObject {
    func build() -> ProfileCoordinator
}

protocol ProfileScene: AnyObject {
    func play(profileShow: ProfileShow)
}

protocol ProfileShow: AnyObject {
    var viewController: UIViewController { get }
}

protocol ProfileRouter: AnyObject {

}

protocol ProfileView: AnyObject { }

protocol ProfilePresenter: AnyObject {
    func handleViewAppear()
}
