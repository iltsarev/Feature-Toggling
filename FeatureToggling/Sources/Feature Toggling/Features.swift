//
//  Features.swift
//  FeatureToggling
//
//  Created by Ilya Tsarev on 14.03.2018.
//  Copyright © 2018 Ilya Tsarev. All rights reserved.
//

import Foundation

/// Все фичи приложения
enum Feature: String, EnumCollection {
    
    case droneDelivery
    case cashPayment
    case firstOrderDiscount
    
    static let enabledByDefault: [Feature] = [
        .cashPayment, .firstOrderDiscount
    ]
}
