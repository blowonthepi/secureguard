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
            Spacer()
            
            MatrixView(isEditable: false,
                       matrix: .constant(viewModel.matrix))
            
            Spacer()
            
            Button {
                viewModel.isSheetPresented = true
            } label: {
                Text("screen.matrix.updateButton")
            }
            .primaryButton()
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
            VStack {
                Text("screen.matrix.updateTitle")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                MatrixView(isEditable: true,
                           matrix: $viewModel.matrix)
                
                Spacer()
            }
            .padding()
            
            Button {
                viewModel.updateMatrix()
                viewModel.isSheetPresented = false
            } label: {
                Text("screen.matrix.updateButton")
            }
            .primaryButton()
        }
    }
}

struct MatrixScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatrixScreen(delegate: nil)
    }
}
