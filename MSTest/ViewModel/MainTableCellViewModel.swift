//
//  MainTableCellViewModel.swift
//  MSTest
//
//  Created by Андрей Калямин on 30.06.2021.
//

import Foundation

class MainTableCellViewModel {
    private var cityWeather: Weather
    
    var cityName: String {
        return cityWeather.city ?? ""
    }
    
    var cityTemp: String {
        return String(cityWeather.temp ?? 0)
    }
    
    init(cityWeather: Weather) {
        self.cityWeather = cityWeather
    }
}
