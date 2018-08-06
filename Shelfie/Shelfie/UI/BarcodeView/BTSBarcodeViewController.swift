//
//  BTSBarcodeViewController.swift
//  Shelfie
//
//  Created by Connor Clancy on 8/6/18. BTSBarcodeViewController
//  Copyright © 2018 BookTrader. All rights reserved.
//

import UIKit
import BarcodeScanner


final class BTSBarcodeViewController: BTWhiteRevealViewController {
    @IBOutlet var presentScannerButton: UIButton!
    @IBOutlet var pushScannerButton: UIButton!
    
    @IBAction func handleScannerPresent(_ sender: Any, forEvent event: UIEvent) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handleScannerPush(_ sender: Any, forEvent event: UIEvent) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self as BarcodeScannerCodeDelegate
        viewController.errorDelegate = self as BarcodeScannerErrorDelegate
        viewController.dismissalDelegate = self as BarcodeScannerDismissalDelegate
        return viewController
    }
}

// MARK: - BarcodeScannerCodeDelegate

extension BTSBarcodeViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            controller.resetWithError()
        }
    }
}

// MARK: - BarcodeScannerErrorDelegate

extension BTSBarcodeViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - BarcodeScannerDismissalDelegate

extension BTSBarcodeViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
