//
//  MatrixScreen.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import SwiftUI

protocol MatrixScreenDelegate {
    func doLogout()
}

struct MatrixScreen: View {
    @StateObject var viewModel = MatrixViewModel()
    var delegate: MatrixScreenDelegate?
    
    var body: some View {
        VStack {
            MatrixView(matrix: viewModel.getMatrix())
        }
        .navigationTitle("appName")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    delegate?.doLogout()
                } label: {
                    Text("lockButton")
                }
            }
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
            updateSheet()
        }
    }
    
    @ViewBuilder func updateSheet() -> some View {
        VStack(alignment: .center) {
            Text("screen.matrix.updateTitle")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Spacer()
            
            MatrixView(matrix: [[String]]())
            
            Spacer()
        }
        .padding()
    }
}

struct MatrixScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatrixScreen(delegate: nil)
    }
}
