//
//  Result+Values.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

extension Result {
    var value: Success? {
        guard case .success(let value) = self else{
            return nil
        }
        return value
    }

    var error: Error? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }
}
