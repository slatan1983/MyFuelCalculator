//
//  CarREPO.swift
//  MyFuelCalculator
//
//  Created by Slawomir Twardowski on 31/03/2020.
//  Copyright © 2020 Slawomir Twardowski. All rights reserved.
//

import Foundation
import UIKit

class CarREPO: NSObject, NSCoding{
    
    //static let carRepo = CarREPO()
    
    var carsArray = Array<Car>()
    
    init(newCarsArray: Array<Car>){
        self.carsArray = newCarsArray
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let carsArray = aDecoder.decodeObject(forKey: "carsArray") as? Array<Car> else{
            return nil
        }
        self.init(newCarsArray: carsArray)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Array<Car>(), forKey: "carsArray")
    }

    
}
