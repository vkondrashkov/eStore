//
//  AlertFactory.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

enum AlertType {
    case singleAction
    case doubleAction
}

struct Alert {
    let title: String
    let message: String
    let alertType: AlertType
    let primaryCaption: String?
    let primaryAction: (() -> Void)?
    let secondaryCaption: String?
    let secondaryAction: (() -> Void)?
}

class AlertFactory {
    func make(alert: Alert) -> UIAlertController {
        let alertController = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert)
        if alert.alertType == .doubleAction {
            let secondaryAlertAction = UIAlertAction(title: alert.secondaryCaption, style: .default, handler: { _ in
                alert.secondaryAction?()
            })
            alertController.addAction(secondaryAlertAction)
        }
        let primaryAlertAction = UIAlertAction(title: alert.primaryCaption, style: .default, handler: { _ in
            alert.primaryAction?()
        })
        alertController.addAction(primaryAlertAction)

        return alertController
    }
}
