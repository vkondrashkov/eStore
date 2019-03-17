//
//  ProfileView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileViewImpl: UIViewController {
    var presenter: ProfilePresenter!

    private var profileTableViewDataSource = ProfileCategoryTableViewDataSource()
    private var profileTableView: UITableView!

    private let profileBackgroundColor = UIColor(red: 242.0 / 255.0, green: 241.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = profileBackgroundColor
        title = "Profile"
        navigationController?.navigationBar.tintColor = customTintColor

        setupProfileTableView()

        presenter.handleLoadView()
    }

    private func setupProfileTableView() {
        profileTableView = UITableView(frame: .zero, style: .grouped)
        profileTableView.tableFooterView = UIView() // Is needed to remove unnecessary separators
        profileTableView.backgroundColor = .clear
        profileTableView.register(ProfileRegularCategoryTableViewCell.self, forCellReuseIdentifier: ProfileRegularCategoryTableViewCell.reuseIdentifier)
        profileTableView.register(ProfileThumbnailCategoryTableViewCell.self, forCellReuseIdentifier: ProfileThumbnailCategoryTableViewCell.reuseIdentifier)
        profileTableView.register(ProfileWarningCategoryTableViewCell.self, forCellReuseIdentifier: ProfileWarningCategoryTableViewCell.reuseIdentifier)
        profileTableView.dataSource = profileTableViewDataSource
        profileTableView.delegate = self
        view.addSubview(profileTableView)
        activateProfileTableViewConstraints(view: profileTableView)
    }

    @objc private func rightBarButtonDidPressed() {
        presenter.handleRightBarButtonPress()
    }
}

// MARK: - ProfileView implementation
extension ProfileViewImpl: ProfileView {
    func display(rightBarButton: String) {
        let rightBarButtonItem = UIBarButtonItem(title: rightBarButton,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(rightBarButtonDidPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func display(sections: [ProfileSection]) {
        profileTableViewDataSource.items = sections
        profileTableView.reloadData()
    }

    func display(alert: Alert) {
        let alertController = AlertFactory().make(alert: alert)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - ProfileShow implementation
extension ProfileViewImpl: ProfileShow {
    var viewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension ProfileViewImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = profileTableViewDataSource.items[indexPath.section].categories[indexPath.row]
        category.action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Constraints
private extension ProfileViewImpl {
    func activateProfileTableViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }
}
