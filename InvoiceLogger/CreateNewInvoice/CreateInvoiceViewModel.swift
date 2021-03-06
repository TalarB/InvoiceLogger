//
//  CreateInvoiceViewModel.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 08/05/2022.
//

import UIKit

final class CreateInvoiceViewModel {
    private let storageManager: StorageManager
    let currencyPickerOptions: [String] = ["DKK", "EURO", "USD", "GBP", "LBP", "SEK"]

    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }

    func saveInvoice(title: String, location: String, value: String, currency: String, date: Date, image: UIImage?, completion: ((Bool) -> ())?) {
        let invoice = Invoice(title: title, location: location, date: date, image: image, value: value, currency: currency)
        storageManager.saveInvoice(invoice, completion: completion)
    }
}
