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
    private let invoice: InvoiceModel

    init(invoice: InvoiceModel) {
        self.invoice = invoice
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        contentView.updateWith(invoice: invoice)
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
