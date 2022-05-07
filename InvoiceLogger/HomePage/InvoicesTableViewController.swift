//
//  InvoicesTableViewController.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

final class InvoicesTableViewController: UIViewController {
    var coordinator: MainCoordinator?
    var dummyData: [InvoiceCell.ViewModel] = []
    let contentView = InvoicesTableView()
    let cellIdentifier = "InvoiceCell"
    
    override func viewDidLoad() {
        dummyData = [InvoiceCell.ViewModel(location: "Allerod", timeAndDay: "11:15", value: "66,5", currency: "DKK", onSelect: { _ in self.didSelectInvoice() }),
                     InvoiceCell.ViewModel(location: "Hillerod", timeAndDay: "14:22", value: "500", currency: "DKK", onSelect: { _ in self.didSelectInvoice() }),
                     InvoiceCell.ViewModel(location: "Birkerod", timeAndDay: "21:30", value: "212", currency: "DKK", onSelect: { _ in self.didSelectInvoice() })]
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewInvoice))
        navigationItem.rightBarButtonItem?.tintColor = .blue.withAlphaComponent(0.5)
        title = "Invoices"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue.withAlphaComponent(0.5)]


        navigationItem.largeTitleDisplayMode = .never
        contentView.tableView.dataSource = self
        contentView.tableView.register(InvoiceCell.self, forCellReuseIdentifier: cellIdentifier)
//        contentView.tableView.sectionIndexColor = Asset.Colors.Regional.primary(theme: theme)
        contentView.tableView.reloadData()
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


extension InvoicesTableViewController: UITableViewDataSource {
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? InvoiceCell else {
            fatalError("Dequeueing should not fail")
        }
        let viewModel = dummyData[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }
}
