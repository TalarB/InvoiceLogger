//
//  CreateInvoiceViewController.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 07/05/2022.
//

import UIKit

final class CreateInvoiceViewController: UIViewController, UINavigationControllerDelegate {
    weak var coordinator: CreateInvoiceCoordinator?
    private let contentView = CreateInvoiceView()
    private let viewModel: CreateInvoiceViewModel

    init(storageManager: StorageManager) {
        self.viewModel = CreateInvoiceViewModel(storageManager: storageManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.currencyPickerOptions = viewModel.currencyPickerOptions
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
    
    func saveInvoice(title: String?, location: String?, value: String?, currency: String?, date: Date?, image: UIImage?, completion: ((Bool) -> ())?) {
        contentView.activityIndicator.startAnimating()
        contentView.isUserInteractionEnabled = false
        if let title = title, title != "",
           let location = location, location != "",
           let value = value, value != "",
           let currency = currency, currency != "",
           let date = date {
            viewModel.saveInvoice(title: title, location: location, value: value, currency: currency, date: date, image: image) { [weak self] didSucceed in
                if didSucceed {
                    self?.coordinator?.close()
                    self?.contentView.activityIndicator.stopAnimating()
                } else {
                    self?.contentView.isUserInteractionEnabled = true
                    self?.contentView.activityIndicator.stopAnimating()
                    let alertController = UIAlertController(title: "Saving failed", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        alertController.dismiss(animated: true, completion: nil)})
                    alertController.addAction(okAction)
                    alertController.message = "Something went wrong while saving, please try again later."
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            contentView.isUserInteractionEnabled = true
            contentView.activityIndicator.stopAnimating()
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
