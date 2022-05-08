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
    func getSavedInvoices() throws -> [Invoice]
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

    func getSavedInvoices() throws -> [Invoice]  {
        let context = container.viewContext
        let request = InvoiceModel.createFetchRequest()
        var invoices = [Invoice]()
        request.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]

        do {
            let invoiceModels = try context.fetch(request)
            for invoice in invoiceModels {
                var image: UIImage? = nil
                if let imageData = invoice.image {
                    image = UIImage(data: imageData)
                }
                invoices.append(Invoice(title: invoice.title, location: invoice.location, date: invoice.date, image: image, value: invoice.value, currency: invoice.currency))
            }
            return invoices
        } catch {
            print("Fetch failed")
        }
        return[]
    }
}
