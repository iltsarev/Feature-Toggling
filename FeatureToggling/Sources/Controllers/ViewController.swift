//
//  ViewController.swift
//  FeatureToggling
//
//  Created by Ilya Tsarev on 14.03.2018.
//  Copyright © 2018 Ilya Tsarev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let featureService = FeaturesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFeatures()
        printDroneDeliveryStatus()
    }
    
    func getFeatures() {
        // В данном примере вызов синхронный
        featureService.getFeatures {
            print("Features are loaded")
        }
    }
    
    func printDroneDeliveryStatus() {
        if (featureService.enabled(.droneDelivery)) {
            print("Drone delivery is enabled")
        } else {
            print("Drone delivery is disabled")
        }
    }
}
