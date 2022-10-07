//
//  QRCodeCameraDelegate.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 07.10.2022.
//

import Foundation
import AVFoundation

class QRCodeCameraDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    var scanInterval = 1.0
    var lastTime = Date(timeIntervalSince1970: 0)
    
    var onResult: (String) -> Void = { _ in }
    var mockData: String?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            self.foundBarcode(stringValue)
        }
    }
    
    func foundBarcode(_ stringValue: String) {
        let now = Date()
        if now.timeIntervalSince(lastTime) >= scanInterval {
            lastTime = now
            self.onResult(stringValue)
        }
    }
    
    @objc func onSimulateScanning() {
        foundBarcode(mockData ?? "Simulated QR-Code Result!")
    }
    
}
