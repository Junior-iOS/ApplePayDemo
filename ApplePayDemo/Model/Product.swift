//
//  Product.swift
//  ApplePayDemo
//
//  Created by NJ Development on 17/01/24.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var price: Int
}
