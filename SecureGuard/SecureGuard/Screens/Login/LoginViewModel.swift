//
//  LoginViewModel.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import Foundation
import LocalAuthentication

class LoginViewModel : ObservableObject {
    private let context = BiometricManager.shared.context
    
    @MainActor
    func requestBiometricVerification(successAction: @escaping () -> Void,
                                      failAction: @escaping () -> Void) {
        Task {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                                   localizedReason: "screen.login.biometricReason")
                successAction()
            } catch let error {
                print(error.localizedDescription)
                failAction()
            }
        }
    }
    
    func getBiometricTypeString() -> String {
        switch context.biometricType {
        case .none, .off:
            return "screen.login.incompatible".localized()
        case .faceID:
            return "screen.login.useFaceID".localized()
        case .touchID:
            return "screen.login.useTouchID".localized()
        }
    }
}
