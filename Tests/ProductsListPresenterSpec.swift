//
//  ProductsListPresenterSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 11/3/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble

@testable import eStore

final class ProductsListPresenterSpec: QuickSpec {
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

    final class ProductsListInteractorSpy: ProductsListInteractor {
        var currentUser: User? = nil

        var hasInvokedFetchSmartphones = false
        var hasInvokedDeleteSmartphone = false
        var hasInvokedFetchTV = false
        var hasInvokedFetchTVs = false
        var hasInvokedDeleteTV = false
        var hasInvokedFetchLaptops = false
        var hasInvokedDeleteLaptop = false
        var hasInvokedAddToCart = false

        func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsListInteractorError>) -> Void) {
            hasInvokedFetchSmartphones = true
        }

        func deleteSmartphone(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) {
            hasInvokedDeleteSmartphone = true
        }

        func fetchTVs(completion: @escaping (Result<[TV], ProductsListInteractorError>) -> Void) {
            hasInvokedFetchTVs = true
        }

        func deleteTV(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) {
            hasInvokedDeleteTV = true
        }

        func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsListInteractorError>) -> Void) {
            hasInvokedFetchLaptops = true
        }

        func deleteLaptop(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) {
            hasInvokedDeleteLaptop = true
        }

        func addToCart(productId: Int, productTypeId: Int, completion: @escaping (ProductsListInteractorError?) -> Void) {
            hasInvokedAddToCart = true
        }
    }

    final class ProductsListViewDummy: ProductsListView {
        func display(rightBarButtonTitle: String) { }

        func display(alert: Alert) { }

        func showActivityIndicator() { }

        func hideActivityIndicator() { }

        func display(storeItemList: [StoreItem]) { }

        func update(theme: Theme, animated: Bool) { }
    }

    final class ProductsListRouterDummy: ProductsListRouter {
        func showSmartphoneEditor() { }

        func showLaptopEditor() { }

        func showTVEditor() { }

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
        var productsListInteractorSpy: ProductsListInteractorSpy!
        let themeManagerDummy = ThemeManagerDummy()

        describe("on handleLoadView()") {
            var productsListPresenter: ProductsListPresenter!

            beforeSuite {
                productsListInteractorSpy = ProductsListInteractorSpy()
            }

            context("with Smartphone product type") {
                beforeSuite {
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .smartphone,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }
                it("should call smartphone request") {
                    expect(productsListInteractorSpy.hasInvokedFetchSmartphones).to(beTrue())
                }
            }

            context("with Laptop product type") {
                beforeSuite {
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .laptop,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }
                it("should call laptop request") {
                    expect(productsListInteractorSpy.hasInvokedFetchLaptops).to(beTrue())
                }
            }

            context("with TV product type") {
                beforeSuite {
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .tv,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }
                it("should call tv request") {
                    expect(productsListInteractorSpy.hasInvokedFetchTVs).to(beTrue())
                }
            }
        }
    }
}
