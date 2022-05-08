//
//  InvoiceModel+CoreDataProperties.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 08/05/2022.
//
//

import Foundation
import CoreData


extension InvoiceModel {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<InvoiceModel> {
        return NSFetchRequest<InvoiceModel>(entityName: "InvoiceModel")
    }

    @NSManaged public var title: String
    @NSManaged public var location: String
    @NSManaged public var value: String
    @NSManaged public var currency: String
    @NSManaged public var date: Date
    @NSManaged public var image: Data?

}

extension InvoiceModel : Identifiable {

}
