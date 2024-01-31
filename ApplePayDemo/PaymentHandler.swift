//
//  PaymentHandler.swift
//  ApplePayDemo
//
//  Created by NJ Development on 30/01/24.
//

import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

final class PaymentHandler: NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    static let supportedNetworks: [PKPaymentNetwork] = [.visa, .masterCard]
    
    func shippingMethodCalculator() -> [PKShippingMethod] {
        let today = Date()
        let calendar = Calendar.current
        
        let shippingStartDate = calendar.date(byAdding: .day, value: 5, to: today)
        let shippingEndDate = calendar.date(byAdding: .day, value: 10, to: today)
        
        if let shippingStartDate, let shippingEndDate {
            let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStartDate)
            let endComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEndDate)
            
            let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDelivery.detail = "You're products were sent to your address"
            shippingDelivery.identifier = "DELIVERY"
            
            return [shippingDelivery]
        }
        return []
    }
    
    func startPayment(products: [Product], total: Int, completion: @escaping PaymentCompletionHandler) {
        completionHandler = completion
        paymentSummaryItems = []
        
        products.forEach { product in
            let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(string: "\(product.price).00"), type: .final)
            paymentSummaryItems.append(item)
            
            let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total).00"), type: .final)
            paymentSummaryItems.append(total)
            
            let paymentRequest = PKPaymentRequest()
            paymentRequest.paymentSummaryItems = paymentSummaryItems
            paymentRequest.merchantIdentifier = Bundle.main.merchantID
            paymentRequest.merchantCapabilities = .threeDSecure
            paymentRequest.countryCode = "US"
            paymentRequest.currencyCode = "USD"
            paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
            paymentRequest.shippingType = .delivery
            paymentRequest.shippingMethods = shippingMethodCalculator()
            paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
            
            paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
            paymentController?.delegate = self
            paymentController?.present(completion: { presented in
                if presented {
                    debugPrint("Presented Payment Controller")
                } else {
                    debugPrint("Failed to present Payment Controller")
                }
            })
        }
    }
}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                guard let completionHandler = self.completionHandler else { return }
                
                if self.paymentStatus == .success {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {

        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: paymentStatus, errors: errors))
    }
}
