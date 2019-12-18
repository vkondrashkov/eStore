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
    final class ProductsListInteractorDummy: ProductsListInteractor {
        var currentUser: User?
        func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsListInteractorError>) -> Void) { }
        func deleteSmartphone(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) { }
        func fetchTVs(completion: @escaping (Result<[TV], ProductsListInteractorError>) -> Void) { }
        func deleteTV(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) { }
        func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsListInteractorError>) -> Void) { }
        func deleteLaptop(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) { }
        func addToCart(productId: Int, productTypeId: Int, completion: @escaping (ProductsListInteractorError?) -> Void) { }
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
        func showActivityIndicator() { }
        func hideActivityIndicator() { }
        func display(storeItemList: [StoreItem]) { }
        func display(rightBarButtonTitle: String) { }
        func update(theme: Theme, animated: Bool) { }
        func display(alert: Alert) { }
    }

    final class ProductsListViewSpy: ProductsListView {
        var hasInvokedDisplayRightBarButton = false
        var hasInvokedDisplayAlert = false
        var hasInvokedShowActivityIndicator = false
        var hasInvokedHideActivityIndicator = false
        var hasInvokedDisplayStoreItemList = false
        var hasInvokedUpdateTheme = false

        func display(rightBarButtonTitle: String) {
            hasInvokedDisplayRightBarButton = true
        }

        func display(alert: Alert) {
            hasInvokedDisplayAlert = true
        }

        func showActivityIndicator() {
            hasInvokedShowActivityIndicator = true
        }

        func hideActivityIndicator() {
            hasInvokedHideActivityIndicator = true
        }

        func display(storeItemList: [StoreItem]) {
            hasInvokedDisplayStoreItemList = true
        }

        func update(theme: Theme, animated: Bool) {
            hasInvokedUpdateTheme = true
        }
    }

    final class ProductsListRouterDummy: ProductsListRouter {
        func showSmartphoneEditor() { }
        func showLaptopEditor() { }
        func showTVEditor() { }
        func showProductDescription(for storeItem: StoreItem) { }
    }

    final class ProductsListRouterSpy: ProductsListRouter {
        var hasInvokedShowProductDescription = false
        var hasInvokedShowSmartphoneEditor = false
        var hasInvokedShowLaptopEditor = false
        var hasInvokedShowTVEditor = false

        func showProductDescription(for storeItem: StoreItem) {
            hasInvokedShowProductDescription = true
        }

        func showSmartphoneEditor() {
            hasInvokedShowSmartphoneEditor = true
        }

        func showLaptopEditor() {
            hasInvokedShowLaptopEditor = true
        }

        func showTVEditor() {
            hasInvokedShowTVEditor = true
        }
    }

    final class ThemeManagerDummy: ThemeManager {
        var currentTheme: Theme = LightTheme(tintColorType: .azraqBlue)
        func applyTheme(_ theme: Theme) { }
        func add(observer: ThemeObserver) { }
        func remove(observer: ThemeObserver) { }
    }

    override func spec() {
        let themeManagerDummy = ThemeManagerDummy()

        // MARK: - on handleLoadView()

        describe("on handleLoadView()") {
            let productsListRouterDummy = ProductsListRouterDummy()
            var productsListViewSpy: ProductsListViewSpy!
            var productsListInteractorSpy: ProductsListInteractorSpy!
            var productsListPresenter: ProductsListPresenter!

            beforeEach {
                productsListInteractorSpy = ProductsListInteractorSpy()
                productsListViewSpy = ProductsListViewSpy()
            }

            // MARK: - Network spy

            it("should call smartphone request when product type is Smartphone") {
                productsListPresenter = ProductsListPresenterImpl(
                    view: productsListViewSpy,
                    router: productsListRouterDummy,
                    interactor: productsListInteractorSpy,
                    productType: .smartphone,
                    themeManager: themeManagerDummy
                )
                productsListPresenter.handleLoadView()
                expect(productsListInteractorSpy.hasInvokedFetchSmartphones).to(beTrue())
            }

            it("should call laptop request when product type is Laptop") {
                productsListPresenter = ProductsListPresenterImpl(
                    view: productsListViewSpy,
                    router: productsListRouterDummy,
                    interactor: productsListInteractorSpy,
                    productType: .laptop,
                    themeManager: themeManagerDummy
                )
                productsListPresenter.handleLoadView()
                expect(productsListInteractorSpy.hasInvokedFetchLaptops).to(beTrue())
            }

            it("should call tv request when product type is TV") {
                productsListPresenter = ProductsListPresenterImpl(
                    view: productsListViewSpy,
                    router: productsListRouterDummy,
                    interactor: productsListInteractorSpy,
                    productType: .tv,
                    themeManager: themeManagerDummy
                )
                productsListPresenter.handleLoadView()
                expect(productsListInteractorSpy.hasInvokedFetchTVs).to(beTrue())
            }

            // MARK: - View spy

            context("when user is guest") {
                beforeEach {
                    productsListInteractorSpy.currentUser = User(
                        id: 1,
                        username: "guest",
                        email: "guest",
                        fullname: "guest",
                        role: .guest
                    )
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewSpy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .tv,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }

                it("shouldn't display additional buttons on handleLoadView(:)") {
                    expect(productsListViewSpy.hasInvokedDisplayRightBarButton).to(beFalse())
                }
            }

            context("when user is authorized user") {
                beforeEach {
                    productsListInteractorSpy.currentUser = User(
                        id: 1,
                        username: "authorized",
                        email: "authorized",
                        fullname: "authorized",
                        role: .authorized
                    )
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewSpy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .tv,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }

                it("shouldn't display additional buttons on handleLoadView(:)") {
                    expect(productsListViewSpy.hasInvokedDisplayRightBarButton).to(beFalse())
                }
            }

            context("when user is content maker") {
                beforeEach {
                    productsListInteractorSpy.currentUser = User(
                        id: 1,
                        username: "contentMaker",
                        email: "contentMaker",
                        fullname: "contentMaker",
                        role: .contentMaker
                    )
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewSpy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .tv,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }

                it("shouldn't display additional buttons on handleLoadView(:)") {
                    expect(productsListViewSpy.hasInvokedDisplayRightBarButton).to(beFalse())
                }
            }

            context("when user is moderator") {
                beforeEach {
                    productsListInteractorSpy.currentUser = User(
                        id: 1,
                        username: "moderator",
                        email: "moderator",
                        fullname: "moderator",
                        role: .moderator
                    )
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewSpy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .tv,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }

                it("should display additional buttons on handleLoadView(:)") {
                    expect(productsListViewSpy.hasInvokedDisplayRightBarButton).to(beTrue())
                }
            }

            context("when user is admin") {
                beforeEach {
                    productsListInteractorSpy.currentUser = User(
                        id: 1,
                        username: "admin",
                        email: "admin",
                        fullname: "admin",
                        role: .admin
                    )
                    productsListPresenter = ProductsListPresenterImpl(
                        view: productsListViewSpy,
                        router: productsListRouterDummy,
                        interactor: productsListInteractorSpy,
                        productType: .tv,
                        themeManager: themeManagerDummy
                    )
                    productsListPresenter.handleLoadView()
                }

                it("should display additional buttons on handleLoadView(:)") {
                    expect(productsListViewSpy.hasInvokedDisplayRightBarButton).to(beTrue())
                }
            }
        }

        // MARK: - on handleAddProductPress

        describe("on handleAddProductPress()") {
            var presenter: ProductsListPresenter!
            var productsListRouterSpy: ProductsListRouterSpy!
            let productsListViewDummy = ProductsListViewDummy()
            let productsListInteractorDummy = ProductsListInteractorDummy()

            beforeEach {
                productsListRouterSpy = ProductsListRouterSpy()
            }

            context("when product type is Smartphone") {
                beforeEach {
                    presenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterSpy,
                        interactor: productsListInteractorDummy,
                        productType: .smartphone,
                        themeManager: themeManagerDummy
                    )
                    presenter.handleAddProductPress()
                }

                it("should show smartphone editor") {
                    expect(productsListRouterSpy.hasInvokedShowSmartphoneEditor).to(beTrue())
                }
            }

            context("when product type is Laptop") {
                beforeEach {
                    presenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterSpy,
                        interactor: productsListInteractorDummy,
                        productType: .laptop,
                        themeManager: themeManagerDummy
                    )
                    presenter.handleAddProductPress()
                }

                it("should show laptop editor") {
                    expect(productsListRouterSpy.hasInvokedShowLaptopEditor).to(beTrue())
                }
            }

            context("when product type is TV") {
                beforeEach {
                    presenter = ProductsListPresenterImpl(
                        view: productsListViewDummy,
                        router: productsListRouterSpy,
                        interactor: productsListInteractorDummy,
                        productType: .tv,
                        themeManager: themeManagerDummy
                    )
                    presenter.handleAddProductPress()
                }

                it("should show tv editor") {
                    expect(productsListRouterSpy.hasInvokedShowTVEditor).to(beTrue())
                }
            }
        }
    }
}
