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
            Text("Your cart is empty")
        }
        .navigationTitle(Text("My Cart"))
        .padding(.top)
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}
