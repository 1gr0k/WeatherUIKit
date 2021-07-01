//
//  DetailViewModel.swift
//  MSTest
//
//  Created by Андрей Калямин on 01.07.2021.
//

import Foundation

class DetailViewModel {
    
    private var cityWeather: Weather
    
    var cityName: String {
        return cityWeather.city ?? "error"
    }
    
    init(city: Weather) {
        self.cityWeather = city
    }
}
