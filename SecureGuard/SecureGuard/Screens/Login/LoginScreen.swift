//
//  LoginScreen.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import SwiftUI

protocol LoginScreenDelegate {
    func doLogin()
}

struct LoginScreen: View {
    @StateObject var viewModel = LoginViewModel()
    let delegate: LoginScreenDelegate?
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text("screen.login.welcomeMessage")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Spacer()
            
            useFaceIDButton()
        }
    }
    
    @ViewBuilder func useFaceIDButton() -> some View {
        Button {
            viewModel.requestBiometricVerification {
                delegate?.doLogin()
            } failAction: {
                // handle fail
            }

        } label: {
            VStack {
                Image(systemName: "faceid")
                    .resizable()
                    .aspectRatio(1/1, contentMode: .fit)
                    .frame(width: 40)
                Text(viewModel.getBiometricTypeString())
            }
        }
        .foregroundColor(Color("ForegroundText"))
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(delegate: nil)
    }
}
