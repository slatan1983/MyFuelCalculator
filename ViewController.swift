//
//  ViewController.swift
//  MyFuelCalculator
//
//  Created by Slawomir Twardowski on 26/03/2020.
//  Copyright © 2020 Slawomir Twardowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var carArray: Array<Car> = []
    var carRepo = CarREPO(newCarsArray: Array<Car>())

    var trackIndex = 0
    var trackPicker: UIPickerView?
    var carPicker: UIPickerView?
    var hoursPicker: UIPickerView?
    var minutesPicker: UIPickerView?
    var lapMinPicker: UIPickerView?
    var lapSecPicker: UIPickerView?
    var fuelLapPicker: UIPickerView?
    var ECUimage: UIImage?//(named: "DEFAULT")
    
    @IBOutlet weak var CarText: UITextField!
    @IBOutlet weak var TrackText: UITextField!
    @IBOutlet weak var raceHtext: UITextField!
    @IBOutlet weak var raceMtext: UITextField!
    @IBOutlet weak var lapMtext: UITextField!
    @IBOutlet weak var lapStext: UITextField!
    @IBOutlet weak var fuelPLtext: UITextField!
    @IBOutlet weak var calcFuelLabel: UILabel!
    @IBOutlet weak var calcLapsLabel: UILabel!
    
    @IBOutlet weak var ECUimageView: UIImageView!
    
    @IBAction func ECUMap(_ sender: Any) {
        
        if LabelTextREPO.selectedCar == "-----"{
            ECUimage = UIImage(named: "DEFAULT")
        }
        ECUimageView.image = ECUimage
        ECUimageView.isHidden = !ECUimageView.isHidden
    }

    @IBAction func touchECUaway(_ sender: UITapGestureRecognizer) {
        guard sender.view != nil else { return }
        if sender.state == .ended {
            ECUimageView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ECUimageView.isHidden = true
        carRepo = CarREPO(newCarsArray: createCars())
        createTrackPicker()
        createCarPicker()
        createHoursPicker()
        createMinutesPicker()
        createFuelLapPicker()
        createLaptimeMinPicker()
        createLaptimeSecPicker()
        createDoneToolbar()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector(("imageTapped:")))
    }
    
    func createCars() -> Array<Car>{
        var arrayWithCars = Array<Car>()
        var usagePerTrack = ["empty","3.0", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-", "-.-",  "-.-", "-.-", "-.-"]
        for (car, tank) in LabelTextREPO.carsTankCap{
            let newName = car
            let newCap = tank
            for (carPic, picture) in LabelTextREPO.carsImages{
                if newName == carPic{
                    var newCar = Car(newName: newName, newFuelCap: newCap, newPicture: picture, usagePerTrack: usagePerTrack)
                    arrayWithCars.append(newCar)
                }
            }
            
        }
        return arrayWithCars
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView{
            case trackPicker:
                return LabelTextREPO.tracks.count
            case carPicker:
                return LabelTextREPO.cars.count
            case hoursPicker:
                return LabelTextREPO.hours.count
            case minutesPicker:
                return LabelTextREPO.minutes.count
            case lapMinPicker:
                return LabelTextREPO.lapMin.count
            case lapSecPicker:
                return LabelTextREPO.lapSec.count
            case fuelLapPicker:
                return LabelTextREPO.fuelLap.count
            default:
                return 10
        }
     
    }
    
    func calculate(selectedHours: String, selectedMinutes: String, selectedLaptimeMin: String, selectedLaptimeSec: String, selectedFuelPerLap: String) -> (fuel: Double, laps: Double){
        let hRaceDouble = (selectedHours as NSString).doubleValue
        let mRaceDouble = (selectedMinutes as NSString).doubleValue
        let mLaptimeDouble = (selectedLaptimeMin as NSString).doubleValue
        let sLaptimeDouble = (selectedLaptimeSec as NSString).doubleValue
        let fuelPerLapDouble = (selectedFuelPerLap as NSString).doubleValue
        
        let totalRaceDurationSec = (hRaceDouble * 60 * 60) + (mRaceDouble * 60)
        let totalLaptimeSec = (mLaptimeDouble * 60) + sLaptimeDouble
        let raceLaps = ceil(totalRaceDurationSec / totalLaptimeSec) + 1
        let raceFuel = raceLaps * fuelPerLapDouble
        
        return (fuel: raceFuel, laps: raceLaps)
    }
    
    func createDoneToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        toolbar.barTintColor = UIColor.black
        toolbar.tintColor = UIColor.white
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        TrackText.inputAccessoryView = toolbar
        CarText.inputAccessoryView = toolbar
        raceHtext.inputAccessoryView = toolbar
        raceMtext.inputAccessoryView = toolbar
        lapMtext.inputAccessoryView = toolbar
        lapStext.inputAccessoryView = toolbar
        fuelPLtext.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
     
        let results = calculate(selectedHours: LabelTextREPO.selectedHours, selectedMinutes: LabelTextREPO.selectedMinutes, selectedLaptimeMin: LabelTextREPO.selectedLapMin, selectedLaptimeSec: LabelTextREPO.selectedLapSec, selectedFuelPerLap: LabelTextREPO.selectedFuel)
        let printFuelResult = String(format: "%.2f", results.fuel)
        let printLapsResult = String(format: "%.0f", results.laps)
        if results.fuel > 0 && results.laps > 0 {
            self.calcFuelLabel.text = printFuelResult
            self.calcLapsLabel.text = printLapsResult
        }
        //let fileManager = NSFileProviderManager.default
        //let documentDirectory = try fileManager.documentStorageURL
        //let saveFile = documentDirectory.baseURL
        //let saving = try? NSKeyedArchiver.archivedData(withRootObject: carArray, requiringSecureCoding: false)
        view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView{
            case trackPicker:
                return LabelTextREPO.tracks[row]
            case carPicker:
                return LabelTextREPO.cars[row]
            case hoursPicker:
                return LabelTextREPO.hours[row]
            case minutesPicker:
                return LabelTextREPO.minutes[row]
            case lapMinPicker:
                return LabelTextREPO.lapMin[row]
            case lapSecPicker:
                return LabelTextREPO.lapSec[row]
            case fuelLapPicker:
                return LabelTextREPO.fuelLap[row]
            default:
                return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch pickerView{
            case trackPicker:
                LabelTextREPO.selectedTrack = LabelTextREPO.tracks[row]
                TrackText.text = LabelTextREPO.selectedTrack
                trackIndex = LabelTextREPO.tracks.firstIndex(of: LabelTextREPO.selectedTrack)!
                if LabelTextREPO.selectedTrack != "-----"{
                    for (car) in carRepo.carsArray{
                        if car.name == LabelTextREPO.selectedCar{
                            LabelTextREPO.selectedFuel = car.usagePerTrack[trackIndex]
                            fuelPLtext.text = LabelTextREPO.selectedFuel
                        }
                    }
                }
                        
            case carPicker:
                LabelTextREPO.selectedCar = LabelTextREPO.cars[row]
                CarText.text = LabelTextREPO.selectedCar
                for (car) in carRepo.carsArray{
                    if car.name == LabelTextREPO.selectedCar{
                        ECUimage = car.picture
                    }
                }
                if LabelTextREPO.selectedTrack != "-----"{
                    for (car) in carRepo.carsArray{
                        if car.name == LabelTextREPO.selectedCar{
                            LabelTextREPO.selectedFuel = car.usagePerTrack[trackIndex]
                            fuelPLtext.text = LabelTextREPO.selectedFuel
                        }
                    }
                }
            case hoursPicker:
                LabelTextREPO.selectedHours = LabelTextREPO.hours[row]
                raceHtext.text = LabelTextREPO.selectedHours
            case minutesPicker:
                LabelTextREPO.selectedMinutes = LabelTextREPO.minutes[row]
                raceMtext.text = LabelTextREPO.selectedMinutes
            case lapMinPicker:
                LabelTextREPO.selectedLapMin = LabelTextREPO.lapMin[row]
                lapMtext.text = LabelTextREPO.selectedLapMin
            case lapSecPicker:
                LabelTextREPO.selectedLapSec = LabelTextREPO.lapSec[row]
                lapStext.text = LabelTextREPO.selectedLapSec
            case fuelLapPicker:
                LabelTextREPO.selectedFuel = LabelTextREPO.fuelLap[row]
                fuelPLtext.text = LabelTextREPO.selectedFuel
                if LabelTextREPO.selectedTrack != "-----" && LabelTextREPO.selectedCar != "-----" {
                    trackIndex = LabelTextREPO.tracks.firstIndex(of: LabelTextREPO.selectedTrack)!
                    for (car) in carRepo.carsArray{
                        if car.name == LabelTextREPO.selectedCar{
                            car.usagePerTrack[trackIndex] = LabelTextREPO.selectedFuel
                        }
                    }
                }
            default:
                fuelPLtext.text = "error"
        }
        
    }
        

    func createTrackPicker(){
         trackPicker = UIPickerView()
         trackPicker?.setValue(UIColor.white, forKey: "textColor")
         trackPicker?.setValue(UIColor.darkGray, forKey: "backgroundColor")
         trackPicker?.delegate = self
         TrackText.inputView = trackPicker
     }
    
    func createCarPicker(){
        carPicker = UIPickerView()
        carPicker?.setValue(UIColor.white, forKey: "textColor")
        carPicker?.setValue(UIColor.darkGray, forKey: "backgroundColor")
        carPicker?.delegate = self
        CarText.inputView = carPicker
    }

    func createHoursPicker() {
        hoursPicker = UIPickerView()
        hoursPicker?.setValue(UIColor.white, forKey: "textColor")
        hoursPicker?.setValue(UIColor.darkGray, forKey: "backgroundColor")
        hoursPicker?.delegate = self
        raceHtext.inputView = hoursPicker
    }

    func createMinutesPicker() {
        minutesPicker = UIPickerView()
        minutesPicker?.setValue(UIColor.white, forKey: "textColor")
        minutesPicker?.setValue(UIColor.darkGray, forKey: "backgroundColor")
        minutesPicker?.delegate = self
        raceMtext.inputView = minutesPicker
    }

    func createFuelLapPicker() {
        fuelLapPicker = UIPickerView()
        fuelLapPicker?.setValue(UIColor.white, forKey: "textColor")
        fuelLapPicker?.setValue(UIColor.darkGray, forKey: "backgroundColor")
        fuelLapPicker?.delegate = self
        fuelPLtext.inputView = fuelLapPicker
    }

    func createLaptimeMinPicker() {
        lapMinPicker = UIPickerView()
        lapMinPicker?.setValue(UIColor.white, forKey: "textColor")
        lapMinPicker?.setValue(UIColor.darkGray, forKey: "backgroundColor")
        lapMinPicker?.delegate = self
        lapMtext.inputView = lapMinPicker
    }

    func createLaptimeSecPicker() {
        lapSecPicker = UIPickerView()
        lapSecPicker?.setValue(UIColor.white, forKey: "textColor")
        lapSecPicker?.setValue(UIColor.darkGray, forKey: "backgroundColor")
        lapSecPicker?.delegate = self
        lapStext.inputView = lapSecPicker
    }
    
}

    




