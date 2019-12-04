//
//  ViewController.swift
//  lab1_prognoza
//
//  Created by Student on 09/10/2018.
//  Copyright © 2018 Zygmunt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var locationNr: String? {
        didSet {
            refreshUI()
        }
    }
    
    func refreshUI() {
        loadViewIfNeeded()
        self.checkWeather()
        self.temp.text = locationNr
    }

    @IBOutlet weak var temp: UILabel!
    var weather = Weather()
    var date = Date()
    
    @IBOutlet weak var stateLab: UILabel!
    
    @IBOutlet weak var tempMax: UILabel!
    
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var airPress: UILabel!
    
    @IBOutlet weak var windDirLab: UILabel!
    
    @IBOutlet weak var dateDisp: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkWeather()
    }

    @IBAction func next(_ sender: Any) {
       self.date =  Calendar.current.date(byAdding: .day, value: 1, to: self.date)!
       self.checkWeather()
        
    }
    
    @IBAction func prev(_ sender: Any) {
        self.date =  Calendar.current.date(byAdding: .day, value: -1, to: self.date)!
        self.checkWeather()
    }
    
    func checkWeather(){
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        let s = format.string(from: self.date)
        let url = URL(string: "https://www.metaweather.com/api/location/44418/\(s)/")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]];
            DispatchQueue.main.async {
                
               self.setWeather(json)
                
            }       }
    task.resume()
        format.dateFormat = "dd-MM-yyyy"
        self.dateDisp.text = format.string(from: self.date)    }
    
    func setWeather(_ json : [[String: AnyObject]]){
        self.weather.state = json[1]["weather_state_name"] as! String? ?? "no data";
        self.weather.wind_dir = json[1]["wind_direction_compass"] as! String? ?? "no data";
        self.weather.wind_speed = String(format:"%.2f", json[1]["wind_speed"] as! Double)
        self.weather.max =  String(format:"%.2f", json[1]["max_temp"] as! Double);
        self.weather.min =  String(format:"%.2f", json[1]["min_temp"] as! Double)
        self.weather.pressure = String(format:"%.2f", json[1]["air_pressure"] as! Double);     self.setImage(json[1]["weather_state_abbr"] as! String)
        self.mapToLabels(self.weather)
        
    }
    
  func  mapToLabels(_ wethDisp : Weather){
   self.temp.text = wethDisp.min + " C"
    self.tempMax.text = wethDisp.max + " C"
    self.windDirLab.text = wethDisp.wind_dir
    self.windSpeed.text = wethDisp.wind_speed + "m/s"
    self.stateLab.text = wethDisp.state
    self.airPress.text = wethDisp.pressure + " hPa"
    
    }
    func setImage(_ abbr: String){
        let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(abbr).png")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            
            DispatchQueue.main.async {
                
                self.image.image  = UIImage(data: data!)!
                
            }       }
        
        task.resume()
    }
    
    
}


class Weather {
    var state:String="";
    var min:String="";
    var max:String="";
    var wind_speed:String="";
    var wind_dir:String="";
    var pressure:String="";
}
