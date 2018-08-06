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
    var have = false;
    var want = false;
    var isbn = "";
    
    @IBOutlet var presentScannerButton: UIButton!
    @IBOutlet var pushScannerButton: UIButton!
    

    
    @IBAction func handleAddPresent(_ sender: Any, forEvent event: UIEvent) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        self.have = true
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handleRequestPresent(_ sender: Any, forEvent event: UIEvent) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        self.want = true
        present(viewController, animated: true, completion: nil)
    }
    
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self as BarcodeScannerCodeDelegate
        viewController.errorDelegate = self as BarcodeScannerErrorDelegate
        viewController.dismissalDelegate = self as BarcodeScannerDismissalDelegate
        return viewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! BTAddBookViewController
        destinationViewController.isbn = self.isbn
        destinationViewController.have = self.have
        destinationViewController.want = self.want
    }
}

// MARK: - BarcodeScannerCodeDelegate

extension BTSBarcodeViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        self.isbn = code
        controller.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async() {
            [unowned self] in
            self.performSegue(withIdentifier: "addRequestToPublishSegue", sender: nil)
        }
        controller.reset()
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

// MARK: - didCaptureCode
