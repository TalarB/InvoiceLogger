//
//  CreateInvoiceView.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

protocol CreateInvoiceViewDelegate: AnyObject {
    func goBack()
    func saveInvoice(title: String?, location: String?, value: String?, currency: String?, date: Date?, image: UIImage?)
    func addPhoto()
}

final class CreateInvoiceView: UIView {
    weak var delegate: CreateInvoiceViewDelegate?

    private let topBackgroundView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .blue.withAlphaComponent(0.2)
        return this
    }()
    private let backButton: UIButton = {
        let this = UIButton(type: .custom)
        this.setImage(UIImage(named: "back"), for: .normal)
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    private let newInvoiceLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "New Invoice"
        this.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        this.textColor = .blue.withAlphaComponent(0.5)
        return this
    }()
    private let scrollView: UIScrollView = {
        let this = UIScrollView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.showsVerticalScrollIndicator = false
        return this
    }()
    private let fieldsView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    private let titleTf: UITextField = {
        let this = UITextField()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.placeholder = "Title..."
        this.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return this
    }()
    private let locationTf: UITextField = {
        let this = UITextField()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.placeholder = "Location..."
        this.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return this
    }()
    private let valueLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Value"
        return this
    }()
    private let valueTf: UITextField = {
        let this = UITextField()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.placeholder = "100"
        this.keyboardType = .numberPad
        this.isUserInteractionEnabled = true
        return this
    }()
    private let currencyLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Currency"
        return this
    }()
    private let currencyTf: UITextField = {
        let this = UITextField()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.isUserInteractionEnabled = true
        this.autocapitalizationType = .allCharacters
        this.placeholder = "DKK"
        return this
    }()
    private let datePicker: UIDatePicker = {
        let this = UIDatePicker()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .blue.withAlphaComponent(0.5)
        this.tintColor = .white
        return this
    }()
    private let addPhotoButton: UIButton = {
        let this = UIButton(type: .system)
        this.setTitle("Add photo", for: .normal)
        this.tintColor = .blue.withAlphaComponent(0.5)
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    private let deletePhotoButton: UIButton = {
        let this = UIButton(type: .system)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setImage(UIImage(named: "delete"), for: .normal)
        this.tintColor = .blue.withAlphaComponent(0.3)
        this.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        return this
    }()
    let photoView: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .blue.withAlphaComponent(0.1)
        return this
    }()
    private let saveButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .blue.withAlphaComponent(0.5)
        this.setTitleColor(.white, for: .normal)
        this.setTitle("Save", for: .normal)
        return this
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        deletePhotoButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(tap)


        addSubview(topBackgroundView)
        topBackgroundView.addSubview(newInvoiceLabel)
        topBackgroundView.addSubview(backButton)
        addSubview(scrollView)
        scrollView.addSubview(fieldsView)
        fieldsView.addSubview(titleTf)
        fieldsView.addSubview(locationTf)
        fieldsView.addSubview(valueLabel)
        fieldsView.addSubview(valueTf)
        fieldsView.addSubview(currencyLabel)
        fieldsView.addSubview(currencyTf)
        fieldsView.addSubview(datePicker)
        scrollView.addSubview(addPhotoButton)
        scrollView.addSubview(deletePhotoButton)
        scrollView.addSubview(photoView)
        scrollView.addSubview(saveButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBackgroundView.heightAnchor.constraint(equalToConstant: 100),

            newInvoiceLabel.centerXAnchor.constraint(equalTo: topBackgroundView.centerXAnchor),
            newInvoiceLabel.bottomAnchor.constraint(equalTo: topBackgroundView.bottomAnchor, constant: -15),

            backButton.leadingAnchor.constraint(equalTo: topBackgroundView.leadingAnchor, constant: 15),
            backButton.centerYAnchor.constraint(equalTo: topBackgroundView.centerYAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            fieldsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            fieldsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            fieldsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            fieldsView.bottomAnchor.constraint(equalTo: addPhotoButton.topAnchor, constant: -25),
            
            titleTf.topAnchor.constraint(equalTo: fieldsView.topAnchor),
            titleTf.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            titleTf.heightAnchor.constraint(equalToConstant: 35),
            titleTf.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor),

            locationTf.topAnchor.constraint(equalTo: titleTf.bottomAnchor, constant: 15),
            locationTf.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            locationTf.heightAnchor.constraint(equalToConstant: 35),
            locationTf.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor),

            valueLabel.topAnchor.constraint(equalTo: locationTf.bottomAnchor, constant: 25),
            valueLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 30),

            valueTf.topAnchor.constraint(equalTo: valueLabel.topAnchor),
            valueTf.trailingAnchor.constraint(equalTo: datePicker.trailingAnchor),
            valueTf.heightAnchor.constraint(equalToConstant: 30),
            valueTf.widthAnchor.constraint(greaterThanOrEqualToConstant: 45),
            valueTf.leadingAnchor.constraint(greaterThanOrEqualTo: valueLabel.leadingAnchor, constant: 3),

            currencyLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 15),
            currencyLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            currencyLabel.heightAnchor.constraint(equalToConstant: 30),

            currencyTf.topAnchor.constraint(equalTo: currencyLabel.topAnchor),
            currencyTf.trailingAnchor.constraint(equalTo: datePicker.trailingAnchor),
            currencyTf.widthAnchor.constraint(greaterThanOrEqualToConstant: 45),
            currencyTf.heightAnchor.constraint(equalToConstant: 30),
            currencyTf.leadingAnchor.constraint(greaterThanOrEqualTo: currencyLabel.leadingAnchor, constant: 3),

            datePicker.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 15),
            datePicker.bottomAnchor.constraint(equalTo: fieldsView.bottomAnchor, constant: -10),
            datePicker.trailingAnchor.constraint(lessThanOrEqualTo: fieldsView.trailingAnchor),
            datePicker.widthAnchor.constraint(equalToConstant: 188),

            addPhotoButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 35),
            photoView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 8),
            photoView.heightAnchor.constraint(equalToConstant: 300),
            photoView.widthAnchor.constraint(equalToConstant: 188),
            photoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            deletePhotoButton.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 20),
            deletePhotoButton.centerYAnchor.constraint(equalTo: photoView.centerYAnchor),
            deletePhotoButton.heightAnchor.constraint(equalToConstant: 50),
            deletePhotoButton.widthAnchor.constraint(equalToConstant: 50),
            deletePhotoButton.trailingAnchor.constraint(lessThanOrEqualTo: fieldsView.trailingAnchor),

            saveButton.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 35),
            saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 188),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -20)
        ])
    }

    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        // TODO: Check if we will need this
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
    }

    @objc private func addPhotoButtonTapped(sender: UIButton) {
        delegate?.addPhoto()
    }

    @objc private func backButtonTapped(sender: UIButton) {
        delegate?.goBack()
    }

    @objc private func saveButtonTapped(sender: UIButton) {
        if let title = titleTf.text,
           let location = locationTf.text,
           let value = valueTf.text,
           let currency = currencyTf.text {
            delegate?.saveInvoice(title: title, location: location, value: value, currency: currency, date: datePicker.date, image: photoView.image)
        } else {
            let alertController = UIAlertController(title: "Incomplete info", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                alertController.dismiss(animated: true, completion: nil)})
            alertController.addAction(okAction)
            if titleTf.text == nil {
                alertController.message = "An invoice cannot be saved without a title."
            } else if locationTf.text == nil {
                alertController.message = "An invoice cannot be saved without a location."
            } else if valueTf.text == nil {
                alertController.message = "An invoice cannot be saved without specifying a value."
            } else if currencyTf.text == nil {
                alertController.message = "An invoice cannot be saved without specifying a currency."
            }
            
        }
    }

    @objc private func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        endEditing(true)
    }

    @objc func deleteButtonTapped() {
        photoView.image = nil
    }
}
