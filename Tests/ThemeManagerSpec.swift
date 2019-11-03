//
//  ThemeManagerSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 11/3/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble

@testable import eStore

final class ThemeManagerSpec: QuickSpec {
    final class ThemeObserverSpy: ThemeObserver {
        var didChangedTheme = false

        func didChangedTheme(_ theme: Theme) {
            didChangedTheme = true
        }
    }

    override func spec() {
        var themeManager: ThemeManager!
        var themeObserver: ThemeObserverSpy!

        beforeEach {
            themeManager = ThemeManagerImpl()
            themeObserver = ThemeObserverSpy()
            themeManager.add(observer: themeObserver)
        }

        describe("on applyTheme(:)") {
            it("should notify observer") {
                themeManager.applyTheme(LightTheme(tintColorType: .azraqBlue))

                expect(themeObserver.didChangedTheme).to(beTrue())
            }
        }
    }
}
