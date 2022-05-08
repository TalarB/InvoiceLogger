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
    private let viewModel = InvoicesTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewInvoice))
        navigationItem.rightBarButtonItem?.tintColor = .blue.withAlphaComponent(0.5)
        title = "Invoices"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue.withAlphaComponent(0.5)]


        navigationItem.largeTitleDisplayMode = .never
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.allowsSelection = true
        contentView.tableView.register(InvoiceCell.self, forCellReuseIdentifier: cellIdentifier)
        contentView.loadingIndicator.startAnimating()
        viewModel.delegate = self
        viewModel.getInvoices()
    }
    
    override func loadView() {
        view = contentView
    }

    func didSelectInvoice() {
        // open invoice details sheet
    }

    @objc func addNewInvoice() {
        coordinator?.addNewInvoice()
    }
}

extension InvoicesTableViewController: InvoiceTableViewModelDelegate {
    func invoiceTableViewModel(_ viewModel: InvoicesTableViewModel, didLoad invoices: [InvoiceModel]) {
        contentView.errorLabel.isHidden = true
        contentView.loadingIndicator.stopAnimating()
        contentView.loadingIndicator.removeFromSuperview()
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
        
        let invoiceImage: UIImage?
        if let imageData = invoice.image,
           let image = UIImage(data: imageData) {
            invoiceImage = image
        } else {
            invoiceImage = nil
        }
        
        let viewModel = InvoiceCell.ViewModel(title: invoice.title, location: invoice.location, timeAndDay: invoice.date, value: invoice.value, currency: invoice.currency, image: invoiceImage)
        cell.update(with: viewModel)
        return cell
    }
}

extension InvoicesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        coordinator?.showInvoiceDetails()
    }
}

