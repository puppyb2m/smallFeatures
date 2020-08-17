//
//  ViewController.swift
//  FeaturesLib
//
//  Created by Shun Zhang on 2020/08/17.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//

import UIKit
import CoreNFC

// apple offcial demo
// https://developer.apple.com/documentation/corenfc/creating_nfc_tags_from_your_iphone

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onNFCClick(_ sender: Any) {
        guard NFCReaderSession.readingAvailable else {
            return
        }
        
        // 1
        let session = NFCNDEFReaderSession(
            delegate: self,
            queue: nil,
            invalidateAfterFirstRead: true
        )

        // 2
        session.alertMessage = "Hold your device near a tag to scan it."

        // 3
        session.begin()
    }
    
}

extension ViewController: NFCNDEFReaderSessionDelegate {
    
    // 1
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("Started scanning for tags")
    }

    // 2
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        print("Detected tags with \(messages.count) messages")
        
        for messageIndex in 0 ..< messages.count {
            
            let message = messages[messageIndex]
            print("\tMessage \(messageIndex) with length \(message.length)")
            
            for recordIndex in 0 ..< message.records.count {
                
                let record = message.records[recordIndex]
                print("\t\tRecord \(recordIndex)")
                print("\t\t\tidentifier: \(String(data: record.identifier, encoding: .utf8))")
                print("\t\t\ttype: \(String(data: record.type, encoding: .utf8))")
                print("\t\t\tpayload: \(String(data: record.payload, encoding: .utf8))")
            }
        }
    }
    
    // 3
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session did invalidate with error: \(error)")
    }
}

