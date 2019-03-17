//
//  ProfileCategory.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol ProfileCategory {
    var name: String { get }
    var iconUrl: String? { get }
    func action()
}

class ProfileCategoryImpl {
    let name: String
    let iconUrl: String?
    let onTapAction: (() -> Void)?

    init(name: String, iconUrl: String?, onTapAction: (() -> Void)?) {
        self.name = name
        self.iconUrl = iconUrl
        self.onTapAction = onTapAction
    }
}

// MARK: - ProfileCategory implementation
extension ProfileCategoryImpl: ProfileCategory {
    func action() {
        onTapAction?()
    }
}
