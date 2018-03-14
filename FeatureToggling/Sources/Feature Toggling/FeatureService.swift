//
//  FeatureService.swift
//  FeatureToggling
//
//  Created by Ilya Tsarev on 14.03.2018.
//  Copyright © 2018 Ilya Tsarev. All rights reserved.
//

import Foundation

class FeaturesService {
    
    /// Фильтры
    enum FeatureFilter {
        case enabled
        case disabled
        case all
    }
    
    fileprivate let storage = FeatureStorage()
    
    /// Загружает текущий список доступных для пользователя функций
    ///
    /// - Parameter completion: в completion ф-ии уже загружены
    public func getFeatures(_ completion: @escaping() -> Void) {
        storage.getFeatures(completion)
    }
    
    /// Возвращает, доступна ли данная функциональность для текущего пользователя
    ///
    /// - Parameter name: ключ функциональности из enum Feature
    /// - Returns: доступна ли данная функциональность для текущего пользователя
    public func enabled(_ name: Feature) -> Bool {
        let features = storage.features()
        
        return features[name] == true
    }
    
    /// Возвращает все функции, которые удовлетворяют условию фильтра
    ///
    /// - Parameter filter: значение из enum
    /// - Returns: функции, которые удовлетворяют условию фильтра
    public func features(_ filter: FeatureFilter) -> Set<Feature> {
        let allFeatures = storage.features()
        
        switch filter {
        case .enabled:
            let enabledFeatures = allFeatures.filter { $0.value == true }
            return Set(enabledFeatures.keys)
            
        case .disabled:
            let disabledFeatures = allFeatures.filter { $0.value == false }
            return Set(disabledFeatures.keys)
            
        case .all:
            return Set(allFeatures.keys)
        }
    }
    
    /// Очищает кеш
    public func deleteCache() {
        storage.deleteCache()
    }
    
    /// Возвращает все функции для текущего пользователя
    ///
    /// - Returns: [Feature : Bool]
    public func rawFeatures() -> [Feature : Bool] {
        return storage.features()
    }
}

extension FeaturesService {
    
    /// Обновляет состояние указанной функции для текущего пользователя
    ///
    /// - Parameters:
    ///   - name: ключ функциональности
    ///   - enabled: флаг включено или выключено
    ///   - updateCache: если true, то кеш будет обновлен
    public func updateFeature(_ name: Feature, enabled: Bool, updateCache: Bool = false) {
        storage.updateFeature(name, enabled: enabled, updateCache: updateCache)
    }
}
