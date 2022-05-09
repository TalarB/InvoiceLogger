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
                    let alertController = UIAlertController(title: AlertStrings.savingFailedTitle, message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: AlertStrings.okActionTitle, style: .default, handler: { _ in
                        alertController.dismiss(animated: true, completion: nil)})
                    alertController.addAction(okAction)
                    alertController.message = AlertStrings.savingFailedMessage
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            contentView.isUserInteractionEnabled = true
            contentView.activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: AlertStrings.incompleteInfoTitle, message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                alertController.dismiss(animated: true, completion: nil)})
            alertController.addAction(okAction)
            if title == "" {
                alertController.message = AlertStrings.missingTitleMessage
            } else if location == "" {
                alertController.message = AlertStrings.missingLocationMessage
            } else if value == "" {
                alertController.message = AlertStrings.missingValueMessage
            } else if date == nil {
                alertController.message = AlertStrings.missingDateMessage
            }
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func goBack() {
        coordinator?.close()
    }

    struct AlertStrings {
        static let incompleteInfoTitle = "Incomplete Info"
        static let savingFailedTitle = "Saving failed"
        static let savingFailedMessage = "Something went wrong while saving, please try again later."
        static let missingTitleMessage = "An invoice cannot be saved without a title."
        static let missingLocationMessage = "An invoice cannot be saved without a location."
        static let missingValueMessage = "An invoice cannot be saved without specifying a value."
        static let missingDateMessage = "An invoice cannot be saved without a date"
        static let okActionTitle = "Ok"
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
