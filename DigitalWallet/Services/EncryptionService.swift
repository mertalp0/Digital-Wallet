//
//  EncryptionService.swift
//  DigitalWallet
//
//  Created by mert alp on 19.07.2024.
//

import Foundation
import CryptoKit

class EncryptionService {
    private let key: SymmetricKey

    init(key: SymmetricKey) {
        self.key = key
    }

    func encrypt(plainText: String) -> String? {
        let data = plainText.data(using: .utf8)!
        let sealedBox = try! AES.GCM.seal(data, using: key)
        let encryptedData = sealedBox.combined
        return encryptedData?.base64EncodedString()
    }

  
    func decrypt(encryptedText: String) -> String? {
        guard let data = Data(base64Encoded: encryptedText),
              let sealedBox = try? AES.GCM.SealedBox(combined: data) else {
            return nil
        }
        
        let decryptedData = try? AES.GCM.open(sealedBox, using: key)
        return decryptedData.flatMap { String(data: $0, encoding: .utf8) }
    }
}
