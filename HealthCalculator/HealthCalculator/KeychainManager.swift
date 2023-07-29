//
//  KeychainManager.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 08.06.2023.
//

import Foundation
import Security

final class KeychainManager {
    private static let service = "HelthCalculator"
    
    static func registerUser(login: String, password: String, firstName: String, lastName: String) -> Bool {
        let passwordData = password.data(using: .utf8)
        
        let query: [NSString: AnyObject] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login as AnyObject,
            kSecAttrService: service as AnyObject,
            kSecValueData: passwordData as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    static func logInUser(login: String, password: String) -> Bool {
        let query: [NSString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login as AnyObject,
            kSecAttrService: service as AnyObject,
            kSecReturnData: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess,
           let data = result as? Data {
            let savedPassword = String(data: data, encoding: .utf8)
            
            return password == savedPassword
        } else {
            debugPrint("Error for getting password from Keychan")
            return false
        }
    }
    
    static func deleteUser(login: String) {
        let query: [NSString: AnyObject] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login as AnyObject
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { return }
    }
}
