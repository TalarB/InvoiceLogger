//
//  InvoicesTableView.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

final class InvoicesTableView: UIView {
    let loadingIndicator = UIActivityIndicatorView()

    let tableView: UITableView = {
        let this = UITableView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.alwaysBounceVertical = true
        this.allowsSelection = false
        this.separatorColor = .clear
        this.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 5, right: 0)
        this.rowHeight = UITableView.automaticDimension
        this.estimatedRowHeight = 200
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
        tableView.separatorColor = .blue.withAlphaComponent(0.4)
        addSubview(tableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
