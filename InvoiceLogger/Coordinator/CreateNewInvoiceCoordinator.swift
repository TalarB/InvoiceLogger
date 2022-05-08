//
//  CreateNewInvoiceCoordinator.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

final class CreateInvoiceCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController

    weak var parentCoordinator: MainCoordinator?
    private let storageManager: StorageManager
    
    init(navigationController: UINavigationController, storageManager: StorageManager) {
        self.navigationController = navigationController
        self.storageManager = storageManager
    }

    func start() {
        let vc = CreateInvoiceViewController(storageManager: storageManager)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func close() {
        parentCoordinator?.createNewInvoiceCoordinatorDidClose()
    }

    func addPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        if let topVC = navigationController.topViewController as? CreateInvoiceViewController {
                vc.delegate = topVC
        }
        navigationController.present(vc, animated: true)
    }
}
