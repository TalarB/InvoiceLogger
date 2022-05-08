//
//  LocalStorageManager.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit
import CoreData

final class LocalStorageManager {
    static let shared = LocalStorageManager()

    private var container: NSPersistentContainer!

    init() {
        container = NSPersistentContainer(name: "Model")

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }

    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }

    func saveInvoice(_ invoice: Invoice) {
        let invoiceModel = InvoiceModel(context: container.viewContext)
        invoiceModel.title = invoice.title
        invoiceModel.location = invoice.location
        invoiceModel.value = invoice.value
        invoiceModel.currency = invoice.currency
        invoiceModel.image = nil
        invoiceModel.date = invoice.date
        DispatchQueue.main.async { [weak self] in
            self?.saveContext()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.loadSavedInvoices()
        }
    }

    func loadSavedInvoices() {
        var invoices = [InvoiceModel]()
        let request = InvoiceModel.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]

        do {
            invoices = try container.viewContext.fetch(request)
            print("Got \(invoices.count) invoices")
            // let the home page viewModel know
        } catch {
            print("Fetch failed")
        }
    }

    func getInvoices(completion: (() -> ()?)) -> [Invoice] {
        return []
    }
}
