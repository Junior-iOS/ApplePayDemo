//
//  Bundle+Extensions.swift
//  ApplePayDemo
//
//  Created by NJ Development on 30/01/24.
//

import Foundation

extension Bundle {
    var merchantID: String {
        self.object(forInfoDictionaryKey: "MERCHANT_ID") as? String ?? ""
    }
}
