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
    
    @Published var paymentSuccess = false
    let paymentHandler = PaymentHandler()
    
    func addToCart(_ product: Product) {
        products.append(product)
        totalAmount += product.price
    }
    
    func removeFromCart(_ product: Product) {
        products = products.filter { $0.id != product.id }
        totalAmount -= product.price
    }
    
    func pay() {
        paymentHandler.startPayment(products: products, total: totalAmount) { success in
            self.paymentSuccess = success
            self.products = []
            self.totalAmount = 0
        }
    }
}
