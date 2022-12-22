//
//  IncompatibleScreen.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import SwiftUI

struct IncompatibleScreen: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text("screen.login.incompatible")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

struct IncompatibleScreen_Previews: PreviewProvider {
    static var previews: some View {
        IncompatibleScreen()
    }
}
