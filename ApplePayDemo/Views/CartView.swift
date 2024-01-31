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
                VStack {
                    Image("dollar")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text("Thanks for your purchase!\nYour product will be with you soon...")
                        .multilineTextAlignment(.center)
                        .padding()
                }
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
                    VStack {
                        Image("empty-cart")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text("Your cart is empty")
                    }
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
