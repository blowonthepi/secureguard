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
    var delegate: MatrixScreenDelegate?
    
    var body: some View {
        NavigationStack {
            VStack {
                
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
        }
    }
}

struct MatrixScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatrixScreen(delegate: nil)
    }
}
