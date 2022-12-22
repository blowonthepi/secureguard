//
//  SecureGuardApp.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import SwiftUI
import LocalAuthentication

@main
struct SecureGuardApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouterView()
        }
    }
}
