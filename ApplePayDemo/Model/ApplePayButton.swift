//
//  ApplePayButton.swift
//  ApplePayDemo
//
//  Created by NJ Development on 30/01/24.
//

import SwiftUI
import PassKit

struct ApplePayButton: View {
    var action: () -> ()
    
    var body: some View {
        Representable(action: action)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    ApplePayButton(action: {})
}

extension ApplePayButton {
    struct Representable: UIViewRepresentable {
        var action: () -> ()
        
        func makeCoordinator() -> Coordinator {
            Coordinator(action: action)
        }
        
        func makeUIView(context: Context) -> some UIView {
            context.coordinator.button
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            context.coordinator.action = action
        }
    }
    
    class Coordinator: NSObject {
        var action: () -> ()
        var button = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)
        
        init(action: @escaping () -> Void) {
            self.action = action
            super.init()
            
            button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
        }
        
        @objc private func callback(_ sender: Any) {
            action()
        }
    }
}
