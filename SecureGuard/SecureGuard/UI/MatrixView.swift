//
//  MatrixView.swift
//  SecureGuard
//
//  Created by Liam Edwards on 23/12/22.
//

import SwiftUI

struct MatrixView: View {
    private let matrixSize = 7
    private let letters = ["A", "B", "C", "D", "E", "F", "G"]
    
    let matrix: [[String]]
    
    var body: some View {
        Grid() {
            GridRow {
                ForEach(0...matrixSize, id: \.self) { letter in
                    cell(letter == 0 ? "" : "\(letters[letter - 1])", bordered: false)
                }
            }
            ForEach(1...matrixSize, id: \.self) { rowIndex in
                GridRow {
                    cell("\(rowIndex)", bordered: false)
                    ForEach(1...matrixSize, id: \.self) { cellIndex in
                        cell(safeGetMatrixValue(rowIndex, cellIndex))
                    }
                }
            }
        }
    }
    
    func safeGetMatrixValue(_ x: Int, _ y: Int) -> String {
        guard matrix.count <= x,
              matrix[x].count <= y else {
            return ""
        }
        
        return matrix[x][y]
    }
    
    @ViewBuilder func cell(_ value: String, bordered: Bool = true) -> some View {
        Text(value)
            .frame(minWidth: 25)
            .aspectRatio(1, contentMode: .fit)
            .padding(.all, 8)
            .border(.primary.opacity(value == "" ? 0 : bordered ? 1 : 0))
    }
}

struct MatrixView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixView(matrix: [[String]]())
    }
}
