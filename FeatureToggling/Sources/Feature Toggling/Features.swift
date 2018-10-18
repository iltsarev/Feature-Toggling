//
//  Features.swift
//  FeatureToggling
//
//  Created by Ilya Tsarev on 14.03.2018.
//  Copyright © 2018 Ilya Tsarev. All rights reserved.
//

import Foundation

/// Все фичи приложения
enum Feature: String, CaseIterable {
    
    // Delivery
    case enableDelivery
    case droneDelivery
    case fastDelivery
    
    // Payment
    case firstOrderDiscount
    case cashPayment
    case newFeeAlgorithm
    case applePay
    case payViaTransfer
    
    // Menu
    case sushi
    
    // UI
    case curvedButtons
    case iOS6Design
    
    static let enabledByDefault: [Feature] = [
        .cashPayment, .firstOrderDiscount
    ]
}
