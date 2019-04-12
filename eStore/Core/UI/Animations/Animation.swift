//
//  Animation.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/12/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

enum AnimationContextType {
    case window
    case view
}

protocol Animation {
    func prepare()
    func run(completion: @escaping () -> Void)
}
