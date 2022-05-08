//
//  InvoiceDetailsViewController.swift
//  InvoiceLogger
//
//  Created by Talar Boyadjian on 08/05/2022.
//

import UIKit

final class InvoiceDetailsViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    private let contentView = InvoiceDetailsView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }

    override func loadView() {
        super.loadView()
        view = contentView
    }
}

extension InvoiceDetailsViewController: InvoiceDetailsViewDelegate {
    func goBack() {
        coordinator?.goBack()
    }
}
