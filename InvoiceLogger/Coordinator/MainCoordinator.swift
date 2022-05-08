//
//  MainCoordinator.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let storageManager: StorageManager = LocalStorageManager.shared

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = InvoicesTableViewController(storageManager: storageManager)
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }

    func addNewInvoice() {
        let createInvoiceCoordinator = CreateInvoiceCoordinator(navigationController: navigationController,
                                                                storageManager: storageManager)
        childCoordinators.append(createInvoiceCoordinator)
        createInvoiceCoordinator.parentCoordinator = self
        createInvoiceCoordinator.start()
    }

    func createNewInvoiceCoordinatorDidClose() {
        navigationController.popViewController(animated: true)
    }

    func showInvoiceDetails(for invoice: Invoice) {
        let vc = InvoiceDetailsViewController(invoice: invoice)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
