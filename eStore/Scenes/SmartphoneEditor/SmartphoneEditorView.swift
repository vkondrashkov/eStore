//
//  SmartphoneEditorView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SmartphoneEditorViewImpl: UIViewController, SmartphoneEditorCoordinatorProvidable {
    var presenter: SmartphoneEditorPresenter!
    var coordinator: SmartphoneEditorCoordinator!

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
    private let operatingSystemPickerView = UIPickerView()

    private let displayWidthLabel = UILabel()
    private let displayWidthTextField = UITextField()

    private let displayHeightLabel = UILabel()
    private let displayHeightTextField = UITextField()

    private let ramCapacityLabel = UILabel()
    private let ramCapacityTextField = UITextField()

    private let memoryCapacityLabel = UILabel()
    private let memoryCapacityTextField = UITextField()

    private let processorNameLabel = UILabel()
    private let processorNameTextField = UITextField()

    private let colorLabel = UILabel()
    private let colorTextField = UITextField()

    private let batteryCapacityLabel = UILabel()
    private let batteryCapacityTextField = UITextField()

    private let priceLabel = UILabel()
    private let priceTextField = UITextField()

    private let operatingSystemValues = ["iOS", "Android"]

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

        contentView.addSubview(ramCapacityLabel)
        ramCapacityLabel.snp.makeConstraints {
            $0.top.equalTo(displayHeightTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(contentView.snp.centerX).offset(-5)
        }

        contentView.addSubview(ramCapacityTextField)
        ramCapacityTextField.snp.makeConstraints {
            $0.top.equalTo(ramCapacityLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(contentView.snp.centerX).offset(-5)
        }

        contentView.addSubview(memoryCapacityLabel)
        memoryCapacityLabel.snp.makeConstraints {
            $0.top.equalTo(displayHeightTextField.snp.bottom).offset(20)
            $0.leading.equalTo(contentView.snp.centerX).offset(5)
            $0.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(memoryCapacityTextField)
        memoryCapacityTextField.snp.makeConstraints {
            $0.top.equalTo(memoryCapacityLabel.snp.bottom).offset(10)
            $0.leading.equalTo(contentView.snp.centerX).offset(5)
            $0.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(processorNameLabel)
        processorNameLabel.snp.makeConstraints {
            $0.top.equalTo(ramCapacityTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(processorNameTextField)
        processorNameTextField.snp.makeConstraints {
            $0.top.equalTo(processorNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(colorLabel)
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(processorNameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(colorTextField)
        colorTextField.snp.makeConstraints {
            $0.top.equalTo(colorLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(batteryCapacityLabel)
        batteryCapacityLabel.snp.makeConstraints {
            $0.top.equalTo(colorTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(batteryCapacityTextField)
        batteryCapacityTextField.snp.makeConstraints {
            $0.top.equalTo(batteryCapacityLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(batteryCapacityTextField.snp.bottom).offset(20)
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

//        let operatingSystemTapGesture = UITapGestureRecognizer(target: self, action: #selector(operatingSystemValueLabelDidTap))
//        operatingSystemValueLabel.addGestureRecognizer(operatingSystemTapGesture)
//        operatingSystemValueLabel.isUserInteractionEnabled = true
//        operatingSystemValueLabel.text = "Select"

        let toolBar = UIToolbar()
        toolBar.barStyle = .blackTranslucent
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.items = [UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonDidTap))]
//        view.addSubview(toolBar)

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

        ramCapacityLabel.text = "RAM:"
        ramCapacityLabel.font = .boldSystemFont(ofSize: 17)

        ramCapacityTextField.borderStyle = .roundedRect

        memoryCapacityLabel.text = "Memory:"
        memoryCapacityLabel.font = .boldSystemFont(ofSize: 17)

        memoryCapacityTextField.borderStyle = .roundedRect

        processorNameLabel.text = "Processor name:"
        processorNameLabel.font = .boldSystemFont(ofSize: 17)

        processorNameTextField.borderStyle = .roundedRect

        colorLabel.text = "Color:"
        colorLabel.font = .boldSystemFont(ofSize: 17)

        colorTextField.borderStyle = .roundedRect

        batteryCapacityLabel.text = "Battery capacity:"
        batteryCapacityLabel.font = .boldSystemFont(ofSize: 17)

        batteryCapacityTextField.borderStyle = .roundedRect

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
        presenter.handleDonePress(smartphoneForm: SmartphoneForm(
            imageUrl: imageUrlTextField.text,
            name: nameTextField.text ?? "",
            brandName: brandNameTextField.text ?? "",
            operatingSystem: currentOperatingSystem,
            display: Display(
                width: Int(displayWidthTextField.text ?? "") ?? 0,
                height: Int(displayHeightTextField.text ?? "") ?? 0
            ),
            ramCapacity: Int(ramCapacityTextField.text ?? "") ?? 0,
            memoryCapacity: Int(memoryCapacityTextField.text ?? "") ?? 0,
            processorName: processorNameTextField.text ?? "",
            color: colorTextField.text ?? "",
            batteryCapacity: Int(batteryCapacityTextField.text ?? "") ?? 0,
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
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
}

// MARK: - UIPickerViewDelegate implementation

extension SmartphoneEditorViewImpl: UIPickerViewDelegate {
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
        currentOperatingSystem = OperatingSystem(rawValue: row) ?? .unknown
        operatingSystemTextField.text = operatingSystemValues[row]
    }
}

// MARK:  - UIPickerViewDataSource implementation

extension SmartphoneEditorViewImpl: UIPickerViewDataSource { }

// MARK: - SmartphoneEditorView implementation

extension SmartphoneEditorViewImpl: SmartphoneEditorView {
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

    func display(ramCapacity: String) {
        ramCapacityTextField.text = ramCapacity
    }

    func display(memoryCapacity: String) {
        memoryCapacityTextField.text = memoryCapacity
    }

    func display(processorName: String) {
        processorNameTextField.text = processorName
    }

    func display(color: String) {
        colorTextField.text = color
    }

    func display(batteryCapacity: String) {
        batteryCapacityTextField.text = batteryCapacity
    }

    func display(price: String) {
        priceTextField.text = price
    }

    func update(theme: Theme, animated: Bool) {

    }

    func display(alert: Alert) {
        
    }
}
