//
//  LocalStorageManager.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit
import CoreData

protocol StorageManager: AnyObject {
    func saveInvoice(_ invoice: Invoice)
    func getSavedInvoices() throws -> [InvoiceModel]
}

final class LocalStorageManager: StorageManager {
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

    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }

    func saveInvoice(_ invoice: Invoice) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let invoiceModel = InvoiceModel(context: strongSelf.container.viewContext)
            invoiceModel.title = invoice.title
            invoiceModel.location = invoice.location
            invoiceModel.value = invoice.value
            invoiceModel.currency = invoice.currency
            invoiceModel.image = invoice.image?.pngData()
            invoiceModel.date = invoice.date
            strongSelf.saveContext()
        }
    }

    func getSavedInvoices() throws -> [InvoiceModel]  {
        let context = container.viewContext
        var invoices = [InvoiceModel]()
        let request = InvoiceModel.createFetchRequest()
        request.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]

        do {
            invoices = try context.fetch(request)
            return invoices
        } catch {
            print("Fetch failed")
        }
        return[]
    }
}
