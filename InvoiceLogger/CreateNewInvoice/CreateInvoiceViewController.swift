//
//  CreateInvoiceViewController.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

final class CreateInvoiceViewController: UIViewController, UINavigationControllerDelegate {
    weak var coordinator: CreateInvoiceCoordinator?
    let contentView = CreateInvoiceView()
    let viewModel = CreateInvoiceViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        view = contentView
        contentView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension CreateInvoiceViewController: CreateInvoiceViewDelegate {
    func addPhoto() {
        coordinator?.addPhoto()
    }
    
    func saveInvoice(title: String?, location: String?, value: String?, currency: String?, date: Date?, image: UIImage?, completion: (() -> ())?) {
        if let title = title, title != "",
           let location = location, location != "",
           let value = value, value != "",
           let currency = currency, currency != "",
           let date = date {
            viewModel.saveInvoice(title: title, location: location, value: value, currency: currency, date: date, image: image)
            completion?()
        } else {
            let alertController = UIAlertController(title: "Incomplete info", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                alertController.dismiss(animated: true, completion: nil)})
            alertController.addAction(okAction)
            if title == "" {
                alertController.message = "An invoice cannot be saved without a title."
            } else if location == "" {
                alertController.message = "An invoice cannot be saved without a location."
            } else if value == "" {
                alertController.message = "An invoice cannot be saved without specifying a value."
            } else if currency == "" {
                alertController.message = "An invoice cannot be saved without specifying a currency."
            } else if date == nil {
                alertController.message = "An invoice cannot be saved without a date"
            }
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func goBack() {
        coordinator?.close()
    }
}

extension CreateInvoiceViewController: UIImagePickerControllerDelegate, UINavigationBarDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            return
        }

        contentView.photoView.image = image
    }
}
