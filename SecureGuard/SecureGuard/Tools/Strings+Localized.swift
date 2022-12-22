//
//  Strings+Localized.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
