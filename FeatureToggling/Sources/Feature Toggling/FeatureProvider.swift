//
//  FeatureProvider.swift
//  FeatureToggling
//
//  Created by Ilya Tsarev on 14.03.2018.
//  Copyright © 2018 Ilya Tsarev. All rights reserved.
//

import Foundation

class FeatureProvider {

    /// Загружает список включенных функций для текущего пользователя
    ///
    /// - Parameters:
    ///   - completion: массив Feature, которые включены для текущего пользователя
    ///   - onError: ошибка
    public func fetchEnabledFeatures(_ completion: @escaping([Feature]?) -> Void) {
        
        // Здесь должен быть запрос к API. Для примера – сразу вернем данные
        let features: [Feature] = [.cashPayment, .firstOrderDiscount, .droneDelivery]
        completion(features)
    }
}
