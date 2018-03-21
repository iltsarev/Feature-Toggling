//
//  FeatureCache.swift
//  FeatureToggling
//
//  Created by Ilya Tsarev on 14.03.2018.
//  Copyright © 2018 Ilya Tsarev. All rights reserved.
//

import Foundation

typealias FeaturesWithState = [Feature : Bool]
typealias ArchivableFeaturesWithState = [String : Bool]

class FeatureCache {
    
    fileprivate var cacheFilepath: URL
    
    init(path: URL) {
        cacheFilepath = path
    }
    
    /// Сохраняет данные на диск
    ///
    /// - Parameter featuresWithState: [Feature : Bool]
    /// - Returns: true / false в зависимости от того, было ли сохранение успешным
    @discardableResult
    public func saveData(_ featuresWithState: FeaturesWithState) -> Bool {
        let featuresToSave = convertFeatures(featuresWithState)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: featuresToSave)
        
        do {
            try data.write(to: cacheFilepath)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    /// Загружает данные с диска
    ///
    /// - Returns: возвращает [Feature : Bool]
    public func loadData() -> FeaturesWithState? {
        guard let data = try? Data(contentsOf: cacheFilepath) else { return nil }
        
        guard let features = NSKeyedUnarchiver.unarchiveObject(with: data) as? ArchivableFeaturesWithState else {
            print("FeaturesCache: couldn't load data")
            return nil   
        }
        
        return convertFeatures(features)
    }
    
    ///  Удаляет данные с диска
    ///
    /// - Returns: успешность удаления данных
    @discardableResult
    public func clearData() -> Bool {
        let fileManager = FileManager()
        
        if (fileManager.fileExists(atPath: cacheFilepath.absoluteString) == false) {
            return true
        }
        
        do {
            try fileManager.removeItem(at: cacheFilepath)
            return true
        } catch {
            return false
        }
    }
}

extension FeatureCache {
    /// Приводит данные к виду, готовому к архивации [String : Bool]
    func convertFeatures(_ features: FeaturesWithState) -> ArchivableFeaturesWithState {
        return Dictionary(uniqueKeysWithValues: features.map { ($0.key.rawValue, $0.value) })
    }
    
    /// Приводит данные к виду [Feature : Bool]
    func convertFeatures(_ features: ArchivableFeaturesWithState) -> FeaturesWithState {
        let featureTuples = features.flatMap { (key, value) -> (Feature, Bool)? in
            guard let feature = Feature(rawValue: key) else { return nil }
            return (feature, value)
        }
        
        return Dictionary(uniqueKeysWithValues: featureTuples)
    }
}
