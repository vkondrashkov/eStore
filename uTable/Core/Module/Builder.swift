//
//  Builder.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

public class Builder<DependencyType> {
    public let dependency: DependencyType

    public init(dependency: DependencyType) {
        self.dependency = dependency
    }
}
