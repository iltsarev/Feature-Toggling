//
//  FeatureStorage.swift
//  FeatureToggling
//
//  Created by Ilya Tsarev on 14.03.2018.
//  Copyright © 2018 Ilya Tsarev. All rights reserved.
//

import Foundation

class FeatureStorage {
    
    fileprivate lazy var cacheFilepath: URL = {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentsDirectory = paths[0]
        documentsDirectory.appendPathComponent("cachedFeatures.dat")
        return documentsDirectory
    }()
    
    fileprivate lazy var cache: FeatureCache = {
        return FeatureCache(path: self.cacheFilepath)
    }()
    
    fileprivate lazy var provider: FeatureProvider = {
        return FeatureProvider()
    }()
    
    fileprivate var featuresWithState: FeaturesWithState = [:]
    
    /// Возвращает текущий список функций для текущего пользователя
    ///
    /// - Returns: [Feature : Bool]
    public func features() -> FeaturesWithState {
        return featuresWithState
    }
    
    /// Обновляет текущий список функций для текущего пользователя
    ///
    /// - Parameters:
    ///   - features: словарь функциональностей
    ///   - updateCache: если true, то кэш будет обновлен
    public func setFeatures(_ features: FeaturesWithState, updateCache: Bool = false) {
        featuresWithState = features
        
        if updateCache == true {
            DispatchQueue.global(qos: .default).async {
                self.cache.saveData(self.featuresWithState)
            }
        }
    }
    
    /// Обновляет состояние указанной функции для текущего пользователя
    ///
    /// - Parameters:
    ///   - name: ключ функциональности
    ///   - enabled: флаг включено или выключено
    ///   - updateCache: если true, то кэш будет обновлен
    public func updateFeature(_ name: Feature, enabled: Bool, updateCache: Bool = false) {
        featuresWithState[name] = enabled
        
        if updateCache == true {
            DispatchQueue.global(qos: .default).async {
                self.cache.saveData(self.featuresWithState)
            }
        }
    }
    
    /// Загружает текущий список доступных для пользователя функций
    ///
    /// - Parameter completion: в completion ф-ии уже загружены
    public func getFeatures(_ completion: @escaping() -> Void) {
        provider.fetchEnabledFeatures({ (fetchedFeatures) in
            
            // Если загрузили данные с сервера, то значит они актуальные
            if let loadedFeatures = fetchedFeatures {
                for feature in Feature.allValues {
                    self.featuresWithState[feature] = loadedFeatures.contains(feature)
                }
                // обновляем данные в кэше
                DispatchQueue.global(qos: .default).async {
                    self.cache.saveData(self.featuresWithState)
                }
            } else {
                // пробуем загрузить из кэша
                if let loadedFeatures = self.cache.loadData() {
                    self.featuresWithState = loadedFeatures
                } else {
                    // в кэше нет -- берем стандартные
                    self.featuresWithState = self.getDefaultFeatures()
                }
            }
            completion()
        })
    }
    
    /// Очищает кэш
    public func deleteCache() {
        cache.clearData()
    }
    
    private func getDefaultFeatures() -> FeaturesWithState {
        return Dictionary(uniqueKeysWithValues: Feature.enabledByDefault.map { ($0, true)})            
    }
}

