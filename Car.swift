//
//  Car.swift
//  MyFuelCalculator
//
//  Created by Slawomir Twardowski on 31/03/2020.
//  Copyright © 2020 Slawomir Twardowski. All rights reserved.
//

import Foundation
import UIKit

class Car: NSObject, NSCoding{
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(String(), forKey: "name")
        aCoder.encode(String(), forKey: "fuelCapacity")
        aCoder.encode(UIImage(), forKey: "picture")
        aCoder.encode(Array<String>(), forKey: "usagePerTrack")

    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let fuelCapacity = aDecoder.decodeObject(forKey: "fuelCapacity") as? String,
            let picture = aDecoder.decodeObject(forKey: "picture") as? UIImage,
            let newUsagePerTrack = aDecoder.decodeObject(forKey: "usagePerTrack") as? Array<String> else {return nil}
        
        self.init(newName: name, newFuelCap: fuelCapacity, newPicture: picture, usagePerTrack: newUsagePerTrack)
    }
    
    init(newName: String, newFuelCap: String, newPicture: UIImage, usagePerTrack: Array<String>){
        self.name = newName
        self.fuelCapacity = newFuelCap
        self.picture = newPicture
        self.usagePerTrack = ["empty","3.0", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-",  "-.-", "-.-", "-.-"]

    }
    let picture: UIImage
    let name: String
    let fuelCapacity: String
    var usagePerTrack: Array<String>

}
