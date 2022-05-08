//
//  InvoicesTableViewModel.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 08/05/2022.
//

import Foundation

protocol InvoiceTableViewModelDelegate: AnyObject {
    func invoiceTableViewModel(_ viewModel: InvoicesTableViewModel, didLoad invoices: [Invoice])
    func invoicesTableViewModel(_ viewModel: InvoicesTableViewModel, didFailLoading message: String)
}

final class InvoicesTableViewModel {
    var invoices = [Invoice]()
    weak var delegate: InvoiceTableViewModelDelegate?
    private let storageManager: StorageManager

    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }

    func getInvoices() {
        do {
            try invoices = storageManager.getSavedInvoices()
            delegate?.invoiceTableViewModel(self, didLoad: invoices)
        } catch {
            delegate?.invoicesTableViewModel(self, didFailLoading: "The loading operation failed")
        }
    }
}
