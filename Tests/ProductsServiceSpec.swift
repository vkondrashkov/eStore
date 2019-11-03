//
//  ProductsServiceSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 11/3/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble

@testable import eStore

final class ProductsServiceSpec: QuickSpec {
    final class ProductsServiceSpy: ProductsService {
        var didGetSmartphone = false
        var didGetLaptops = false
        var didGetTV = false

        func getSmartphone(completion: @escaping ([StoreItem]?) -> Void) {
            didGetSmartphone = true
        }

        func getLaptops(completion: @escaping ([StoreItem]?) -> Void) {
            didGetLaptops = true
        }

        func getTV(completion: @escaping ([StoreItem]?) -> Void) {
            didGetTV = true
        }
    }

    final class ProductsListViewDummy: ProductsListView {
        func showActivityIndicator() { }

        func hideActivityIndicator() { }

        func display(storeItemList: [StoreItem]) { }

        func update(theme: Theme, animated: Bool) { }
    }

    final class ProductsListRouterDummy: ProductsListRouter {
        func showProductDescription(for storeItem: StoreItem) { }
    }

    final class ThemeManagerDummy: ThemeManager {
        var currentTheme: Theme = LightTheme(tintColorType: .azraqBlue)

        func applyTheme(_ theme: Theme) { }

        func add(observer: ThemeObserver) { }

        func remove(observer: ThemeObserver) { }
    }

    override func spec() {
        let productsListViewDummy = ProductsListViewDummy()
        let productsListRouterDummy = ProductsListRouterDummy()
        var productsServiceSpy: ProductsServiceSpy!
        let themeManagerDummy = ThemeManagerDummy()

        describe("on handleLoadView()") {
            var productsListPresenter: ProductsListPresenter!

            beforeSuite {
                productsServiceSpy = ProductsServiceSpy()
            }

            context("with Smartphone product type") {
                beforeSuite {
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterDummy,
                        productsService: productsServiceSpy,
                        productType: .Smartphone,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }
                it("should call smartphone request") {
                    expect(productsServiceSpy.didGetSmartphone).to(beTrue())
                }
            }

            context("with Laptop product type") {
                beforeSuite {
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterDummy,
                        productsService: productsServiceSpy,
                        productType: .Laptop,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }
                it("should call laptop request") {
                    expect(productsServiceSpy.didGetLaptops).to(beTrue())
                }
            }

            context("with TV product type") {
                beforeSuite {
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterDummy,
                        productsService: productsServiceSpy,
                        productType: .TV,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }
                it("should call tv request") {
                    expect(productsServiceSpy.didGetTV).to(beTrue())
                }
            }
        }
    }
}
