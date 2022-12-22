//
//  MatrixViewModel.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import Foundation
import LocalAuthentication
import Security

class MatrixViewModel : ObservableObject {
    let bioManager = BiometricManager.shared
    
    @MainActor
    @Published var isSheetPresented: Bool = false
    
    init() {
        if doesMatrixExist() == false {
            DispatchQueue.main.async { [weak self] in
                self?.isSheetPresented = true
            }
        }
    }
    
    func getMatrix() -> [[String]] {
        return bioManager.getMatrix() ?? [[String]]()
    }
    
    func doesMatrixExist() -> Bool {
        return bioManager.doesMatrixExist()
    }
}
