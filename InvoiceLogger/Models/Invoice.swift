//
//  Invoice.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import Foundation
import UIKit

class Invoice {
    let title: String
    let location: String
    let date: Date
    let image: UIImage?
    let value: String
    let currency: String

    init(title: String, location: String, date: Date, image: UIImage?, value: String, currency: String) {
        self.title = title
        self.location = location
        self.date = date
        self.image = image
        self.value = value
        self.currency = currency
    }
}
