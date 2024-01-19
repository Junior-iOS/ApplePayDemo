//
//  ContentView.swift
//  ApplePayDemo
//
//  Created by NJ Development on 17/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    let productList = [
        Product(image: "product1", name: "AirPods Max", price: 659),
        Product(image: "product2", name: "AirPods", price: 239),
        Product(image: "product3", name: "AirTag", price: 29),
        Product(image: "product4", name: "Apple Watch", price: 569),
        Product(image: "product5", name: "iPad", price: 899),
        Product(image: "product6", name: "iPhone", price: 999),
        Product(image: "product7", name: "Magic Keyboard", price: 439),
        Product(image: "product8", name: "MacBook", price: 1299)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Apple Products"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CardButton(numberOfProducts: cartManager.products.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
