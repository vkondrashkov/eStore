//
//  AlertFactorySpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 11/3/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble

@testable import eStore

final class AlertFactorySpec: QuickSpec {
    override func spec() {
        var alertFactory: AlertFactory!

        beforeEach {
            alertFactory = AlertFactoryImpl()
        }

        describe("on make(:)") {
            it("should make UIAlertController with 2 actions when alert type is .doubleAction") {
                let alert = Alert(
                    title: "Foo",
                    message: "Bar",
                    alertType: .doubleAction,
                    primaryCaption: "foo",
                    primaryAction: nil,
                    secondaryCaption: "bar",
                    secondaryAction: nil
                )
                let alertController = alertFactory.make(alert: alert)
                expect(alertController.actions.count).to(be(2))
            }

            it("should make UIAlertController with 1 action when alert type is .singleAction") {
                let alert = Alert(
                    title: "Foo",
                    message: "Bar",
                    alertType: .singleAction,
                    primaryCaption: "foo",
                    primaryAction: nil,
                    secondaryCaption: "bar",
                    secondaryAction: nil
                )
                let alertController = alertFactory.make(alert: alert)
                expect(alertController.actions.count).to(be(1))
            }
        }
    }
}
