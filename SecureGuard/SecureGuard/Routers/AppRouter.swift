//
//  AppRouter.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import SwiftUI
import LocalAuthentication

enum AppRouterScreen {
    case incompatible
    case login
    case matrix
}

class AppRouter : ObservableObject {
    @Published var screen: AppRouterScreen = .login
    
    init() {
        switch LAContext().biometricType {
        case .none:
            screen = .incompatible
            break
        default:
            break
        }
    }
    
    @ViewBuilder func rootView() -> some View {
        switch screen {
        case .incompatible:
            IncompatibleScreen()
        case .login:
            LoginScreen(delegate: self)
        case .matrix:
            MatrixScreen(delegate: self)
        }
    }
}

extension AppRouter : LoginScreenDelegate {
    func doLogin() {
        screen = .matrix
    }
}

extension AppRouter : MatrixScreenDelegate {
    func doLogout() {
        screen = .login
    }
}

struct AppRouterView: View {
    @StateObject var router = AppRouter()
    
    var body: some View {
        router.rootView()
    }
}
