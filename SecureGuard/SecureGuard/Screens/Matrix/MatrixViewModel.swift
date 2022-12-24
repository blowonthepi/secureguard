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
    
    @MainActor
    @Published var matrix: [[String]] = [[String]](repeating: [String](repeating: "", count: 7), count: 7)
    
    init() {
        if doesMatrixExist() == false {
            DispatchQueue.main.async { [weak self] in
                self?.isSheetPresented = true
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let matrix = self?.getMatrix() else { return }
                self?.matrix = matrix
            }
        }
    }
    
    func getMatrix() -> [[String]] {
        return bioManager.getMatrix() ?? [[String]](repeating: [String](repeating: "", count: 7), count: 7)
    }
    
    func doesMatrixExist() -> Bool {
        return bioManager.doesMatrixExist()
    }
    
    @MainActor
    func updateMatrix() {
        bioManager.changeMatrix(matrix: matrix)
    }
}
