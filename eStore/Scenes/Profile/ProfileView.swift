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

    override func loadView() {
        view = UIView()

        profileTableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(profileTableView)
        profileTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        title = "Profile"
        navigationController?.navigationBar.tintColor = Color.shamrock
        navigationController?.navigationBar.barTintColor = Color.navigationBar
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.text]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Color.text]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = Themes.value(from: [.light: .default, .dark: .black])

        profileTableView.tableFooterView = UIView() // Is needed to remove unnecessary separators
        profileTableView.backgroundColor = .clear
        profileTableView.separatorColor = Color.border
        profileTableView.register(ProfileRegularCategoryTableViewCell.self, forCellReuseIdentifier: ProfileRegularCategoryTableViewCell.reuseIdentifier)
        profileTableView.register(ProfileThumbnailCategoryTableViewCell.self, forCellReuseIdentifier: ProfileThumbnailCategoryTableViewCell.reuseIdentifier)
        profileTableView.register(ProfileWarningCategoryTableViewCell.self, forCellReuseIdentifier: ProfileWarningCategoryTableViewCell.reuseIdentifier)
        profileTableView.dataSource = profileTableViewDataSource
        profileTableView.delegate = self

        presenter.handleLoadView()
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
