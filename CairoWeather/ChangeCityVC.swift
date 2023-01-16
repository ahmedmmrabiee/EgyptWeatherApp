//
//  ChangeCityVC.swift
//  CairoWeather
//
//  Created by ahmed rabie on 13/01/2023.
//

import UIKit

class ChangeCityVC: UIViewController {

    var arrCities = [City(name: "Cairo", id: "360630"), City(name: "Dahab", id:"358245") , City(name: "Aswan", id:"359792") , City(name: "Luxor", id:"360502"), City(name: "Asyūţ", id:"359783"), City(name: "Ash Sharqīyah", id:"360016") , City(name: "Al Manşūrah", id:"360761") , City(name: "Al Wādī al Jadīd", id:"360483") ]
    var cityNameFromHome: String = ""
    var selectedCity : City?
    @IBOutlet weak var cityUpdatedLabel: UILabel!
    @IBOutlet weak var citiesPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
        cityUpdatedLabel.text = cityNameFromHome

        /*
         "id": 358245, "name": "Dahab",
         "id": 359781, "name": "Muḩāfaz̧at Asyūţ",
         "id": 359783, "name": "Asyūţ",
         "id": 359792, "name": "Aswan",
         "id": 360016, "name": "Muḩāfaz̧at ash Sharqīyah",
         "id": 360483, "name": "Muḩāfaz̧at al Wādī al Jadīd",
         "id": 360502, "name": "Luxor",
         "id": 360630, "name": "Cairo",
         "id": 360631,"name": "Cairo Governorate",
          "id": 360761, "name": "Al Manşūrah",
         "id": 360928, "name": "Al Khānkah",
         */
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if let selectedCityUpdated = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Change City"), object: nil, userInfo: ["City Updated":selectedCityUpdated])
            dismiss(animated: true)
        }
        
    }
}
extension ChangeCityVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrCities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrCities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = arrCities[row]
    }
}
