//
//  LoadAllTextArrays.swift
//  MyFuelCalculator
//
//  Created by Slawomir Twardowski on 30/03/2020.
//  Copyright © 2020 Slawomir Twardowski. All rights reserved.
//

import Foundation
import UIKit

class LabelTextREPO: Codable{
    static let cars = ["-----", "AMR V12 Vantage GT3 (2013)", "AMR V8 Vantage GT3 (2019)", "Audi R8 LMS (2015)", "Audi R8 LMS Evo (2019)", "Bentley Continental GT3 (2015)", "Bentley Continental GT3 (2018)", "BMW M6 GT3 (2017)", "Emil Frey Jaguar G3 (2012)", "Ferrari 488 GT3 (2018)", "Honda NSX GT3 (2017)", "Honda NSX GT3 Evo (2019)", "Lamborghini Huracan GT3 (2015)", "Lamborghini Huracan GT3 Evo (2019)", "Lamborghini Huracan ST (2015)", "Lexus RC F GT3 (2016)", "McLaren 650S GT3 (2015)", "McLaren 720S GT3 (2019)", "Mercedes-AMG GT3 (2015)", "Nissan GT-R Nismo GT3 (2015)", "Nissan GT-R Nismo GT3 (2018)", "Porsche 991 GT3 R (2018)", "Porsche 991II GT3 R (2019)", "Porsche 991II GT3 Cup (2017)", "Reiter Engineering R-EX GT3"]
    static var selectedCar = "-----"
    
    static let tracks = ["-----","Barcelona", "Brands Hatch", "Hungaroring", "Kyalami", "Laguna Seca", "Misano", "Monza", "Mount Panorama", "Nurburgring", "Paul Ricard", "Silverstone", "Spa-Francorchamps", "Suzuka", "Zandvoort", "Zolder"]
    static var selectedTrack = "-----"
    
    static let hours = ["0","1","2","3","6","9","12","16","20","24"]
    static var selectedHours = "0"
    
    static let minutes = ["0","5","10","15","20","25","30","35","40","45","50","55","60","90"]
    static var selectedMinutes = "0"
    
    static let lapMin = ["0","1","2","3","4","5","6","7","8","9","10"]
    static var selectedLapMin = "0"
    
    static let lapSec = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    static var selectedLapSec = "0"
    
    static let fuelLap = ["-.-", "1.0","1.1","1.2","1.3","1.4","1.5","1.6","1.7","1.8","1.9","2.0","2.1","2.2","2.3","2.4","2.5","2.6","2.7","2.8","2.9","3.0","3.1","3.2","3.3","3.4","3.5","3.6","3.7","3.8","3.9","4.0","4.1","4.2","4.3","4.4","4.5","4.6","4.7","4.8","4.9","5.0","5.1","5.2","5.3","5.4","5.5","5.6","5.7","5.8","5.9","6.0","6.1","6.2","6.3","6.4","6.5","6.6","6.7","6.8","6.9","7.0","7.1","7.2","7.3","7.4","7.5","7.6","7.7","7.8","7.9","8.0","8.1","8.2","8.3","8.4","8.5","8.6","8.7","8.8","8.9","9.0","9.1","9.2","9.3","9.4","9.5","9.6","9.7","9.8","9.9"]
    static var selectedFuel = "0.0"
    
    static let carsTankCap: KeyValuePairs = ["AMR V12 Vantage GT3 (2013)": "132", "AMR V8 Vantage GT3 (2019)": "120", "Audi R8 LMS (2015)": "120", "Audi R8 LMS Evo (2019)": "120", "Bentley Continental GT3 (2015)": "132", "Bentley Continental GT3 (2018)": "132", "BMW M6 GT3 (2017)": "125", "Emil Frey Jaguar G3 (2012)": "119", "Ferrari 488 GT3 (2018)": "110", "Honda NSX GT3 (2017)": "120", "Honda NSX GT3 Evo (2019)": "120",  "Lamborghini Huracan GT3 (2015)": "120", "Lamborghini Huracan GT3 Evo (2019)": "120" , "Lamborghini Huracan ST (2015)": "120", "Lexus RC F GT3 (2016)": "120", "McLaren 650S GT3 (2015)": "125", "McLaren 720S GT3 (2019)": "125", "Mercedes-AMG GT3 (2015)": "120", "Nissan GT-R Nismo GT3 (2015)": "132", "Nissan GT-R Nismo GT3 (2018)": "132", "Porsche 991 GT3 R (2018)": "120", "Porsche 991II GT3 R (2019)": "120", "Porsche 991II GT3 Cup (2017)": "100", "Reiter Engineering R-EX GT3": "130"]
    
    static let trackUsage = ["-----": "-.-", "Barcelona": "-.-", "Brands Hatch": "-.-", "Hungaroring":"-.-", "Kyalami": "-.-", "Laguna Seca": "-.-", "Misano":"-.-", "Monza": "-.-", "Mount Panorama": "-.-", "Nurburgring": "-.-", "Paul Ricard": "-.-", "Silverstone": "-.-", "Spa-Francorchamps": "-.-", "Suzuka": "-.-", "Zandvoort": "-.-", "Zolder": "-.-"]
    
    static let carsImages: Dictionary = ["AMR V12 Vantage GT3 (2013)": UIImage(named: "AMRV12")!, "AMR V8 Vantage GT3 (2019)": UIImage(named: "AMRV8")!, "Audi R8 LMS (2015)": UIImage(named: "AUDIR8")!, "Audi R8 LMS Evo (2019)": UIImage(named: "AUDIR8EVO")!, "Bentley Continental GT3 (2015)": UIImage(named: "BENT2015")!, "Bentley Continental GT3 (2018)": UIImage(named: "BENT2018")!, "BMW M6 GT3 (2017)": UIImage(named: "BMW")!, "Emil Frey Jaguar G3 (2012)": UIImage(named: "JAGUAR")!, "Ferrari 488 GT3 (2018)": UIImage(named: "FERRARI")!, "Honda NSX GT3 (2017)": UIImage(named: "HONDA")!, "Honda NSX GT3 Evo (2019)": UIImage(named: "HONDAEVO")!,  "Lamborghini Huracan GT3 (2015)": UIImage(named: "HURACAN")!, "Lamborghini Huracan GT3 Evo (2019)": UIImage(named: "HURACANEVO")! , "Lamborghini Huracan ST (2015)": UIImage(named: "DEFAULT")!, "Lexus RC F GT3 (2016)": UIImage(named: "LEXUS")!, "McLaren 650S GT3 (2015)": UIImage(named: "MCLAREN650")!, "McLaren 720S GT3 (2019)": UIImage(named: "MCLAREN720")!, "Mercedes-AMG GT3 (2015)": UIImage(named: "AMG")!, "Nissan GT-R Nismo GT3 (2015)": UIImage(named: "NISSAN2015")!, "Nissan GT-R Nismo GT3 (2018)": UIImage(named: "NISSAN2018")!, "Porsche 991 GT3 R (2018)": UIImage(named: "PORSCHE2018")!, "Porsche 991II GT3 R (2019)": UIImage(named: "PORSCHE2019")!, "Porsche 991II GT3 Cup (2017)": UIImage(named: "DEFAULT")!, "Reiter Engineering R-EX GT3": UIImage(named: "GALLARDO")!] as [String : UIImage]
}

