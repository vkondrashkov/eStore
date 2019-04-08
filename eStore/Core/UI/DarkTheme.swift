//
//  DarkTheme.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DarkTheme: Theme {
    convenience init() {
        self.init(
            barColor: Color.nero,
            backgroundColor: Color.black,
            foregroundColor: Color.nightRider,
            borderColor: Color.codGrey,
            textColor: Color.white,
            tintColor: Color.shamrock
        )
    }

    override init(barColor: UIColor,
                  backgroundColor: UIColor,
                  foregroundColor: UIColor,
                  borderColor: UIColor,
                  textColor: UIColor,
                  tintColor: UIColor) {
        super.init(
            barColor: barColor,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            borderColor: borderColor,
            textColor: textColor,
            tintColor: tintColor
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
