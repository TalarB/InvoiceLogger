//
//  InvoiceCell.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

class InvoiceCell: UITableViewCell {
    struct ViewModel {
        let title: String
        let location: String
        let date: Date
        let value: String
        let currency: String
        let image: UIImage?
    }

    private var viewModel: ViewModel?
    private let roundedView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        let randomBool = Bool.random()
        this.backgroundColor = .blue.withAlphaComponent(0.35)
        this.layer.cornerRadius = 30
        return this
    }()
    private let letterLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.systemFont(ofSize: 18)
        this.textColor = .blue.withAlphaComponent(0.5)
        return this
    }()
    private let locationAndTimeStackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.distribution = .fill
        this.alignment = .leading
        this.spacing = 15
        return this
    }()
    private let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .center
        this.font = UIFont.systemFont(ofSize: 15)
        return this
    }()
    private let dateLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .center
        this.font = UIFont.systemFont(ofSize: 15)
        return this
    }()
    private let valueLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .center
        this.font = UIFont.systemFont(ofSize: 15)
        return this
    }()
    private let currencyLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .center
        this.font = UIFont.systemFont(ofSize: 15)
        return this
    }()
    private let dateFormatter: DateFormatter = {
        let this = DateFormatter()
        this.dateFormat = "MMM d YYYY, h:mm a"
        return this
    }()

    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var onSelectInvoice: ((InvoiceCell.ViewModel) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with viewModel: InvoiceCell.ViewModel) {
        self.viewModel = viewModel
        letterLabel.text = viewModel.location.prefix(1).capitalized
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        currencyLabel.text = viewModel.currency
        dateLabel.text = dateFormatter.string(from: viewModel.date)
    }
    
    private func setupView() {
        contentView.backgroundColor = .blue.withAlphaComponent(0.3)
        contentView.addSubview(roundedView)
        roundedView.addSubview(letterLabel)
        contentView.addSubview(locationAndTimeStackView)
        locationAndTimeStackView.addArrangedSubview(titleLabel)
        locationAndTimeStackView.addArrangedSubview(dateLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(currencyLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            roundedView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            roundedView.heightAnchor.constraint(equalToConstant: 60),
            roundedView.widthAnchor.constraint(equalToConstant: 60),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            roundedView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 15),
            roundedView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15),

            letterLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            letterLabel.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            
            locationAndTimeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            locationAndTimeStackView.leadingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: 10),

            
            currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            valueLabel.trailingAnchor.constraint(equalTo: currencyLabel.leadingAnchor, constant: -7)
            ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        currencyLabel.text = nil
        valueLabel.text = nil
    }
}


