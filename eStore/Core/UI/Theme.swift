//
//  Theme.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class Theme: NSObject, NSCoding {
    var barColor: UIColor
    var backgroundColor: UIColor
    var foregroundColor: UIColor
    var borderColor: UIColor
    var textColor: UIColor
    var tintColor: UIColor

    func encode(with aCoder: NSCoder) {
        aCoder.encode(barColor, forKey: "barColor")
        aCoder.encode(backgroundColor, forKey: "backgroundColor")
        aCoder.encode(foregroundColor, forKey: "foregroundColor")
        aCoder.encode(borderColor, forKey: "borderColor")
        aCoder.encode(textColor, forKey: "textColor")
        aCoder.encode(tintColor, forKey: "tintColor")
    }

    init(barColor: UIColor,
         backgroundColor: UIColor,
         foregroundColor: UIColor,
         borderColor: UIColor,
         textColor: UIColor,
         tintColor: UIColor) {

        self.barColor = barColor
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.textColor = textColor
        self.tintColor = tintColor
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        guard let barColor = aDecoder.decodeObject(forKey: "barColor") as? UIColor,
            let backgroundColor = aDecoder.decodeObject(forKey: "backgroundColor") as? UIColor,
            let foregroundColor = aDecoder.decodeObject(forKey: "foregroundColor") as? UIColor,
            let borderColor = aDecoder.decodeObject(forKey: "borderColor") as? UIColor,
            let textColor = aDecoder.decodeObject(forKey: "textColor") as? UIColor,
            let tintColor = aDecoder.decodeObject(forKey: "tintColor") as? UIColor else {
                return nil
        }
        self.barColor = barColor
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.textColor = textColor
        self.tintColor = tintColor
    }
}
