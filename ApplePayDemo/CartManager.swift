//
//  CartManager.swift
//  ApplePayDemo
//
//  Created by NJ Development on 17/01/24.
//

import Foundation

final class CartManager: ObservableObject {
    @Published private (set) var products: [Product] = []
    @Published private (set) var totalAmount: Int = 0
    
    func addToCart(_ product: Product) {
        products.append(product)
        totalAmount += product.price
    }
    
    func removeFromCart(_ product: Product) {
        products = products.filter { $0.id != product.id }
        totalAmount -= product.price
    }
}
