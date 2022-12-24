//
//  BiometricManager.swift
//  SecureGuard
//
//  Created by Liam Edwards on 23/12/22.
//

import Foundation
import LocalAuthentication

class BiometricManager {
    static let shared = BiometricManager()
    
    let context = LAContext()
    
    private let access = createBiometricAccessControl()
    
    func changeMatrix(matrix: [[String]]) {
        if doesMatrixExist() == true {
            updateMatrix(matrix: matrix)
        } else {
            addMatrix(matrix: matrix)
        }
    }

    private func addMatrix(matrix: [[String]]) {
        guard doesMatrixExist() == false else { return }
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccessControl as String: access as Any,
                                    kSecUseAuthenticationContext as String: context,
                                    kSecAttrAccount as String: "SecureGuardMatrix",
                                    kSecAttrGeneric as String: matrixToJson(from: matrix)]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        print("Add status: \(status)")
    }
    
    private func updateMatrix(matrix: [[String]]) {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: "SecureGuardMatrix"]
        let attrs: [String: Any] = [kSecAttrGeneric as String: matrixToJson(from: matrix)]
        
        let status = SecItemUpdate(query as CFDictionary, attrs as CFDictionary)
        print("Update status: \(status)")
    }
}

// MARK: Get & Existance

extension BiometricManager {
    private var searchQuery: [String: Any] {
        get {
            return [kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: "SecureGuardMatrix",
                    kSecMatchLimit as String: kSecMatchLimitOne,
                    kSecReturnAttributes as String: true,
                    kSecUseAuthenticationContext as String: context,
                    kSecReturnData as String: true]
        }
    }
    
    func getMatrix() -> [[String]]? {
        var item: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &item)
        
        print("Retrieving Item Status: \(status)")
        
        guard let existingItem = item as? [String: Any],
              let matrix = existingItem[kSecAttrGeneric as String] as? String
        else {
            return [[String]]()
        }
        
        return jsonToMatrix(from: matrix)
    }
    
    func doesMatrixExist() -> Bool {
        var item: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &item)
        print("Does Exist Status: \(status)")
        
        return item != nil
    }
}

// MARK: Helpers

extension BiometricManager {
    private func matrixToJson(from matrix: [[String]]) -> String {
        guard let data = try? JSONEncoder().encode(matrix) else {
            return ""
        }
        
        return data.base64EncodedString()
    }
    
    private func jsonToMatrix(from json: String) -> [[String]]? {
        guard let data = Data(base64Encoded: json),
              let matrix = try? JSONDecoder().decode([[String]].self, from: data) else {
            return nil
        }
        
        return matrix
    }
}
