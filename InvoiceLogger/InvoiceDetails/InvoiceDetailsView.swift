//
//  InvoiceDetailsView.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 08/05/2022.
//

import UIKit

protocol InvoiceDetailsViewDelegate: AnyObject {
    func goBack()
}

final class InvoiceDetailsView: UIView {
    weak var delegate: InvoiceDetailsViewDelegate?
    
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
        this.text = "Invoice Details"
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
        this.isUserInteractionEnabled = false
        this.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return this
    }()
    private let locationTf: UITextField = {
        let this = UITextField()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.isUserInteractionEnabled = false
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
        this.isUserInteractionEnabled = false
        this.keyboardType = .numberPad
        return this
    }()
    private let currencyTf: UITextField = {
        let this = UITextField()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.isUserInteractionEnabled = false
        this.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        return this
    }()
    private let dateLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    let photoView: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .blue.withAlphaComponent(0.1)
        return this
    }()
    private let dateFormatter: DateFormatter = {
        let this = DateFormatter()
        this.dateFormat = "MMM d YYYY, h:mm a"
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
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        addSubview(topBackgroundView)
        topBackgroundView.addSubview(newInvoiceLabel)
        topBackgroundView.addSubview(backButton)
        addSubview(scrollView)
        scrollView.addSubview(fieldsView)
        fieldsView.addSubview(titleTf)
        fieldsView.addSubview(locationTf)
        fieldsView.addSubview(valueLabel)
        fieldsView.addSubview(valueTf)
        fieldsView.addSubview(currencyTf)
        fieldsView.addSubview(dateLabel)
        scrollView.addSubview(photoView)
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
            
            titleTf.topAnchor.constraint(equalTo: fieldsView.topAnchor),
            titleTf.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            titleTf.heightAnchor.constraint(equalToConstant: 35),
            titleTf.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor),
            
            locationTf.topAnchor.constraint(equalTo: titleTf.bottomAnchor, constant: 8),
            locationTf.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            locationTf.heightAnchor.constraint(equalToConstant: 35),
            locationTf.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: locationTf.bottomAnchor, constant: 25),
            valueLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            valueTf.topAnchor.constraint(equalTo: valueLabel.topAnchor),
            valueTf.trailingAnchor.constraint(equalTo: currencyTf.leadingAnchor, constant: -5),
            valueTf.heightAnchor.constraint(equalToConstant: 30),
            valueTf.widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
            valueTf.leadingAnchor.constraint(greaterThanOrEqualTo: valueLabel.trailingAnchor, constant: 5),
            
            currencyTf.topAnchor.constraint(equalTo: valueLabel.topAnchor),
            currencyTf.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.trailingAnchor),
            currencyTf.widthAnchor.constraint(equalToConstant: 40),
            currencyTf.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 15),
            dateLabel.bottomAnchor.constraint(equalTo: fieldsView.bottomAnchor, constant: -10),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: fieldsView.trailingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 188),
            
            photoView.topAnchor.constraint(equalTo: fieldsView.bottomAnchor, constant: 15),
            photoView.heightAnchor.constraint(equalToConstant: 300),
            photoView.widthAnchor.constraint(equalToConstant: 188),
            photoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            photoView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -25)
        ])
    }
    
    @objc func backButtonTapped(sender: UIButton) {
        delegate?.goBack()
    }

    func updateWith(invoice: InvoiceModel) {
        titleTf.text = invoice.title
        locationTf.text = invoice.location
        valueTf.text = invoice.value
        currencyTf.text = invoice.currency
        dateLabel.text = dateFormatter.string(from: invoice.date)
        if let imageData = invoice.image,
           let image = UIImage(data: imageData) {
            photoView.image = image
        }
    }
}
