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
    
    let isEditable: Bool
    @Binding var matrix: [[String]]
    
    var body: some View {
        Grid() {
            GridRow {
                ForEach(0...matrixSize, id: \.self) { letter in
                    Cell(letter == 0 ? "" : "\(letters[letter - 1])", bordered: false)
                }
            }
            ForEach(1...matrixSize, id: \.self) { rowIndex in
                GridRow {
                    Cell("\(rowIndex)", bordered: false)
                    ForEach(1...matrixSize, id: \.self) { cellIndex in
                        if isEditable {
                            Cell(safeGetMatrixBoundValue(rowIndex - 1, cellIndex - 1))
                        } else {
                            Cell(safeGetMatrixValue(rowIndex - 1, cellIndex - 1))
                        }
                    }
                }
            }
        }
    }
    
    func safeGetMatrixBoundValue(_ x: Int, _ y: Int) -> Binding<String> {
        guard matrix.count > x,
              matrix[x].count > y else {
            return .constant("")
        }
        
        return $matrix[x][y]
    }
    
    func safeGetMatrixValue(_ x: Int, _ y: Int) -> String {
        guard matrix.count > x,
              matrix[x].count > y else {
            return ""
        }
        
        return matrix[x][y]
    }
}

struct Cell: View {
    @Binding var text: String
    var isEditable: Bool
    var bordered: Bool
    
    init(_ value: Binding<String>) {
        self._text = value
        self.isEditable = true
        self.bordered = true
    }
    
    init(_ value: String, bordered: Bool = true) {
        self._text = .constant(value)
        self.isEditable = false
        self.bordered = bordered
    }
    
    var body: some View {
        if isEditable {
            editableCell($text)
        } else {
            cell(text, bordered: bordered)
        }
    }
    
    @ViewBuilder func cell(_ value: String, bordered: Bool = true) -> some View {
        Text(value)
            .frame(minWidth: bordered ? 25 : 0)
            .aspectRatio(1, contentMode: .fit)
            .padding(.all, 8)
            .border(.primary.opacity(value == "" ? 0 : bordered ? 1 : 0))
    }
    
    @ViewBuilder func editableCell(_ value: Binding<String>) -> some View {
        TextField("", text: value)
            .frame(minWidth: 25)
            .aspectRatio(1, contentMode: .fit)
            .padding(.all, 8)
            .border(.primary)
            .multilineTextAlignment(.center)
    }
}

struct MatrixView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixView(isEditable: false,
                   matrix: .constant([[String]]()))
    }
}
