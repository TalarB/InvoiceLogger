//
//  InvoicesTableViewController.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

final class InvoicesTableViewController: UIViewController {
    var coordinator: MainCoordinator?
    private let contentView = InvoicesTableView()
    private let cellIdentifier = "InvoiceCell"
    private let viewModel: InvoicesTableViewModel
    private let refreshControl = UIRefreshControl()

    init(storageManager: StorageManager) {
        self.viewModel = InvoicesTableViewModel(storageManager: storageManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewInvoice))
        navigationItem.rightBarButtonItem?.tintColor = .blue.withAlphaComponent(0.5)
        title = "Invoices"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue.withAlphaComponent(0.5)]

        navigationItem.largeTitleDisplayMode = .never
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .blue.withAlphaComponent(0.5)
        contentView.tableView.addSubview(refreshControl)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.allowsSelection = true
        contentView.tableView.register(InvoiceCell.self, forCellReuseIdentifier: cellIdentifier)
        contentView.loadingIndicator.startAnimating()
        viewModel.delegate = self
        viewModel.getInvoices()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.getInvoices()
    }
    
    override func loadView() {
        view = contentView
    }

    @objc private func addNewInvoice() {
        coordinator?.addNewInvoice()
    }

    @objc private func refresh(_ sender: AnyObject) {
        viewModel.getInvoices()
    }
}

extension InvoicesTableViewController: InvoiceTableViewModelDelegate {
    func invoiceTableViewModel(_ viewModel: InvoicesTableViewModel, didLoad invoices: [Invoice]) {
        contentView.errorLabel.isHidden = true
        contentView.loadingIndicator.stopAnimating()
        contentView.loadingIndicator.removeFromSuperview()
        refreshControl.endRefreshing()
        contentView.tableView.reloadData()
    }
    
    func invoicesTableViewModel(_ viewModel: InvoicesTableViewModel, didFailLoading message: String) {
        contentView.loadingIndicator.stopAnimating()
        contentView.loadingIndicator.removeFromSuperview()
        contentView.errorLabel.text = message
    }
}


extension InvoicesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.invoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? InvoiceCell else {
            fatalError("Dequeueing should not fail")
        }
        let invoice = viewModel.invoices[indexPath.row]
        
        let viewModel = InvoiceCell.ViewModel(title: invoice.title, location: invoice.location, date: invoice.date, value: invoice.value, currency: invoice.currency, image: invoice.image)
        cell.update(with: viewModel)
        return cell
    }
}

extension InvoicesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let invoice = viewModel.invoices[indexPath.row]
        coordinator?.showInvoiceDetails(for: invoice)
    }
}

