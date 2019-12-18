//
//  TVEditorView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class TVEditorViewImpl: UIViewController, TVEditorCoordinatorProvidable {
    var presenter: TVEditorPresenter!
    var coordinator: TVEditorCoordinator!

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let imageUrlLabel = UILabel()
    private let imageUrlTextField = UITextField()

    private let nameLabel = UILabel()
    private let nameTextField = UITextField()

    private let brandNameLabel = UILabel()
    private let brandNameTextField = UITextField()

    private let operatingSystemLabel = UILabel()
    private let operatingSystemTextField = UITextField()
    //private let operatingSystemValueLabel = UILabel()
    private let operatingSystemPickerView = UIPickerView()

    private let displayWidthLabel = UILabel()
    private let displayWidthTextField = UITextField()

    private let displayHeightLabel = UILabel()
    private let displayHeightTextField = UITextField()

    private let priceLabel = UILabel()
    private let priceTextField = UITextField()

    private let operatingSystemValues = ["WebOs", "unknown"]

    private var currentOperatingSystem: OperatingSystem = .unknown

    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }

        contentView.addSubview(imageUrlLabel)
        imageUrlLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(imageUrlTextField)
        imageUrlTextField.snp.makeConstraints {
            $0.top.equalTo(imageUrlLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageUrlTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(brandNameLabel)
        brandNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(brandNameTextField)
        brandNameTextField.snp.makeConstraints {
            $0.top.equalTo(brandNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(operatingSystemLabel)
        operatingSystemLabel.snp.makeConstraints {
            $0.top.equalTo(brandNameTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(contentView.snp.centerX).offset(-5)
        }

        contentView.addSubview(operatingSystemTextField)
        operatingSystemTextField.snp.makeConstraints {
            $0.top.equalTo(brandNameTextField.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(contentView.snp.centerX).offset(5)
        }

        contentView.addSubview(displayWidthLabel)
        displayWidthLabel.snp.makeConstraints {
            $0.top.equalTo(operatingSystemTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(contentView.snp.centerX).offset(-5)
        }

        contentView.addSubview(displayWidthTextField)
        displayWidthTextField.snp.makeConstraints {
            $0.top.equalTo(displayWidthLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(contentView.snp.centerX).offset(-5)
        }

        contentView.addSubview(displayHeightLabel)
        displayHeightLabel.snp.makeConstraints {
            $0.top.equalTo(operatingSystemTextField.snp.bottom).offset(20)
            $0.leading.equalTo(contentView.snp.centerX).offset(5)
            $0.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(displayHeightTextField)
        displayHeightTextField.snp.makeConstraints {
            $0.top.equalTo(displayHeightLabel.snp.bottom).offset(10)
            $0.leading.equalTo(contentView.snp.centerX).offset(5)
            $0.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(displayHeightTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(priceTextField)
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let outerAreaTapGesture = UITapGestureRecognizer(target: self, action: #selector(outerAreaDidTap))
        view.addGestureRecognizer(outerAreaTapGesture)
        view.backgroundColor = .white
        title = "Edit"

        imageUrlLabel.text = "Image Url:"
        imageUrlLabel.font = .boldSystemFont(ofSize: 17)

        imageUrlTextField.borderStyle = .roundedRect

        nameLabel.text = "Name:"
        nameLabel.font = .boldSystemFont(ofSize: 17)

        nameTextField.borderStyle = .roundedRect

        brandNameLabel.text = "Brand name:"
        brandNameLabel.font = .boldSystemFont(ofSize: 17)

        brandNameTextField.borderStyle = .roundedRect

        operatingSystemLabel.text = "Operating system:"
        operatingSystemLabel.font = .boldSystemFont(ofSize: 17)

        let toolBar = UIToolbar()
        toolBar.barStyle = .blackTranslucent
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.items = [UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonDidTap))]

        operatingSystemPickerView.delegate = self
        operatingSystemPickerView.dataSource = self

        operatingSystemTextField.borderStyle = .roundedRect
        operatingSystemTextField.inputAccessoryView = toolBar
        operatingSystemTextField.inputView = operatingSystemPickerView

        displayWidthLabel.text = "Resolution width:"
        displayWidthLabel.font = .boldSystemFont(ofSize: 17)

        displayWidthTextField.borderStyle = .roundedRect

        displayHeightLabel.text = "Resolution height:"
        displayHeightLabel.font = .boldSystemFont(ofSize: 17)

        displayHeightTextField.borderStyle = .roundedRect

        priceLabel.text = "Price (BYN):"
        priceLabel.font = .boldSystemFont(ofSize: 17)

        priceTextField.borderStyle = .roundedRect

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )

        let rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonDidPress)
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem

        presenter.handleLoadView()
    }

    @objc private func outerAreaDidTap() {
        view.endEditing(true)
    }

    @objc private func doneButtonDidTap() {
        operatingSystemTextField.resignFirstResponder()
    }

    @objc private func rightBarButtonDidPress() {
        presenter.handleDonePress(tvForm: TVForm(
            imageUrl: imageUrlTextField.text,
            name: nameTextField.text ?? "",
            brandName: brandNameTextField.text ?? "",
            operatingSystem: currentOperatingSystem,
            display: Display(
                width: Int(displayWidthTextField.text ?? "") ?? 0,
                height: Int(displayHeightTextField.text ?? "") ?? 0
            ),
            price: Int(priceTextField.text ?? "") ?? 0
        ))
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            } else {
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: endFrame?.size.height ?? 0, right: 0)
            }
            UIView.animate(
                withDuration: duration,
                delay: TimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil
            )
        }
    }
}

// MARK: - UIPickerViewDelegate implementation

extension TVEditorViewImpl: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return operatingSystemValues.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return operatingSystemValues[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentOperatingSystem = OperatingSystem(rawValue: row + OperatingSystem.WebOs.rawValue) ?? .unknown
        operatingSystemTextField.text = operatingSystemValues[row]
    }
}

// MARK:  - UIPickerViewDataSource implementation

extension TVEditorViewImpl: UIPickerViewDataSource { }

// MARK: - TVEditorView implementation

extension TVEditorViewImpl: TVEditorView {
    func display(imageUrl: String) {
        imageUrlTextField.text = imageUrl
    }

    func display(name: String) {
        nameTextField.text = name
    }

    func display(brandName: String) {
        brandNameTextField.text = brandName
    }

    func display(operatingSystem: OperatingSystem) {
        currentOperatingSystem = operatingSystem
        operatingSystemTextField.text = operatingSystem.title
    }

    func display(displayWidth: String) {
        displayWidthTextField.text = displayWidth
    }

    func display(displayHeight: String) {
        displayHeightTextField.text = displayHeight
    }

    func display(price: String) {
        priceTextField.text = price
    }

    func update(theme: Theme, animated: Bool) { }

    func display(alert: Alert) { }
}
