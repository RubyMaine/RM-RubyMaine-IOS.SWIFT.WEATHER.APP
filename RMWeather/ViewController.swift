//
//  ViewController.swift
//  RMWeather
//
//  Created by RubyMaine on 06/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var weatherLable: UILabel!
    @IBOutlet var getWeatherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherLable.text = "Узнать погоду"
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
    }

    @objc func didTapGetWeatherButton(){
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherLable.text = "\(weather.currentWeather.temperature) °"
                }
            } else {
                print("Failed!")
            }
        }
        task.resume()
    }

}
