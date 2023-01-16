//
//  ViewController.swift
//  CairoWeather
//
//  Created by ahmed rabie on 11/01/2023.
//

import UIKit
import Alamofire
class HomeVC: UIViewController {
    
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
@IBOutlet weak var pressureLabel: UILabel!
@IBOutlet weak var humadityLabel: UILabel!

    let url: String = "https://api.openweathermap.org/data/2.5/weather?"
    var cityId : String = "360630"
    let appId : String = "9a7d93921e4e3bb0647aff66d63f8da1"
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(changeCityNameAfterEdit), name: NSNotification.Name(rawValue: "Change City"), object: nil)
        
        getWeatherInfoForCityIdByAPI()
        print("hello Weather")
    }
    func getWeatherInfoForCityIdByAPI (){
        weatherActivityIndicator.isHidden = false
        weatherActivityIndicator.startAnimating()
        let params = ["id" : cityId, "appid" : appId]
        
        AF.request(url, parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result = response.value {
                let jsonDictionary = result as! NSDictionary
                let main = jsonDictionary["main"] as! NSDictionary
                var temp = main["temp"] as! Double
                temp -= 272.15
                temp = Double(round(1000 * temp) / 1000)
                self.tempLabel.text = "\(temp)°C"
                
                let pressure = main["pressure"] as! Int
                self.pressureLabel.text = "\(pressure)"
                
                let humadity = main["humidity"] as! Int
                self.humadityLabel.text = "\(humadity)"
                self.weatherActivityIndicator.stopAnimating()
                self.weatherActivityIndicator.isHidden = true
            }
        }
    }
    
    @objc func changeCityNameAfterEdit(notification: Notification){
        if let cityAfterUpdated = notification.userInfo?["City Updated"] as? City {
            cityNameLabel.text = cityAfterUpdated.name
            cityId = cityAfterUpdated.id
            getWeatherInfoForCityIdByAPI()
        }
}
   
    @IBAction func changeCityButton(_ sender: Any) {
        if let toChangeCityView = storyboard?.instantiateViewController(withIdentifier: "ChangeCityID") as? ChangeCityVC {
        toChangeCityView.cityNameFromHome = cityNameLabel.text!
      
        present(toChangeCityView, animated: true)
    }
  }
}

