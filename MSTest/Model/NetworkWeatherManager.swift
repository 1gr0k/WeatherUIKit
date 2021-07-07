//
//  WeatyherAPI.swift
//  testMS
//
//  Created by Андрей Калямин on 21.06.2021.
//

import Foundation
import Alamofire

class NetworkWeatherManager:NSObject {
    
    //    static let shared = WeatherAPI()
    
    var onCompletion:((Weather) -> Void)?
    
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    private let api = "cbce11c07bc8ff5271528a8fcf3fb9d0"
    
    private func absoluteURL(city: String) -> URL? {
        let queryURL = URL(string: baseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil }
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: api),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    fileprivate func parseJSON(withData data:Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            let currentWeather = Weather(weatherData: weatherData)
//            guard let currentWeather = Weather(weatherData: weatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func fetchWeather(city: String, completion: @escaping(Weather) -> ()) {
        if let url = absoluteURL(city: city) {
            AF.request(url).responseData { (responceData) in
                switch responceData.result {
                case .success(let data):
                    guard let currentWeather = self.parseJSON(withData: data) else { return }
                    completion(currentWeather)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
