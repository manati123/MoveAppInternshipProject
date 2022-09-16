//
//  NFCTagReader.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.09.2022.
//

import Foundation
import CoreNFC
import SwiftUI

class NFCTagReader: NSObject, NFCTagReaderSessionDelegate, ObservableObject {
    
    @Published var scannedData: Data?
    
    
    func scan() {
        // Look for ISO 14443 and ISO 15693 tags
        let session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693], delegate: self)
        session?.begin()
    }
    // Error handling again
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) { }
    
    // Additionally there's a function that's called when the session begins
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) { }
    
    // Note that an NFCTag array is passed into this function, not a [NFCNDEFMessage]
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        session.connect(to: tags.first!) { error in
            if error != nil {
                session.invalidate(errorMessage: "Connection error")
                return
            }
        }
        print("Connected to tag!")
        let nfcTag = tags.first
        
        switch nfcTag {
        case .miFare(let discoveredTag):
            print("Got a MiFare tag!", discoveredTag.identifier, discoveredTag.mifareFamily)
            scannedData = discoveredTag as! Data
        case .feliCa(let discoveredTag):
            scannedData = discoveredTag as! Data
            print("Got a FeliCa tag!", discoveredTag.currentSystemCode, discoveredTag.currentIDm)
        case .iso15693(let discoveredTag):
            discoveredTag.readSingleBlock(requestFlags: .highDataRate, blockNumber: 1) { result in
                self.scannedData = discoveredTag as! Data
                print(result)
            }
            print("Got a ISO 15693 tag!", discoveredTag.icManufacturerCode, discoveredTag.icSerialNumber, discoveredTag.identifier)
        case .iso7816(let discoveredTag):
            self.scannedData = discoveredTag as! Data
            print("Got a ISO 7816 tag!", discoveredTag.initialSelectedAID, discoveredTag.identifier)
        @unknown default:
            session.invalidate(errorMessage: "Unsupported tag!")
        }
        
    }
}


struct MyView: View {
    @ObservedObject var reader = NFCTagReader()
    
    var body: some View {
        VStack {
            Text(String(data: reader.scannedData!, encoding: .utf8)!)
            Button("Scan") {
                reader.scan()
            }
        }
    }
}
