//
//  LoginViewModel.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import Foundation
import LocalAuthentication

class LoginViewModel : ObservableObject {
    
    func getBiometricTypeString() -> String {
        switch LAContext().biometricType {
        case .none:
            return "screen.login.incompatible".localized()
        case .faceID:
            return "screen.login.useFaceID".localized()
        case .touchID:
            return "screen.login.useTouchID".localized()
        }
    }
}
