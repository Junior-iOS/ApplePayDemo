//
//  CartView.swift
//  ApplePayDemo
//
//  Created by NJ Development on 17/01/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ScrollView {
            if cartManager.paymentSuccess {
                Text("Thanks for your purchase!")
                    .padding()
            } else {
                if cartManager.products.count > 0 {
                    ForEach(cartManager.products, id: \.id) { product in
                        ProductRow(product: product)
                    }
                    
                    HStack {
                        Spacer()
                        Text("Total: ")
                        Text("$\(cartManager.totalAmount)")
                            .bold()
                    }
                    .padding()
                    
                    ApplePayButton(action: cartManager.pay)
                        .padding()
                } else {
                    Text("Your cart is empty")
                }
            }
        }
        .navigationTitle(Text("My Cart"))
        .padding(.top)
        .onDisappear {
            if cartManager.paymentSuccess {
                cartManager.paymentSuccess = false
            }
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}
