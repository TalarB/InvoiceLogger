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
    
    func saveInvoice(title: String, location: String, value: String, currency: String, date: Date, image: UIImage?) {
        viewModel.saveInvoice(title: title, location: location, value: value, currency: currency, date: date, image: image)
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
