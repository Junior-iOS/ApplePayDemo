//
//  ProductCard.swift
//  ApplePayDemo
//
//  Created by NJ Development on 17/01/24.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                Image(product.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    Text(product.name)
                        .bold()
                    
                    Text("\(product.price)$")
                        .font(.caption)
                }
                .padding()
                .frame(width: 180, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            }
            .frame(width: 180, height: 250)
        .shadow(radius: 3)
            
            Button(action: {
                cartManager.addToCart(product)
            }, label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(50)
                    .padding()
            })
        }
    }
}

#Preview {
    ProductCard(product: Product(image: "product1", name: "AirPod Max", price: 659))
        .environmentObject(CartManager())
}
