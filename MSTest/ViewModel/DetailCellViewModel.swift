//
//  DetailCellViewModel.swift
//  MSTest
//
//  Created by Андрей Калямин on 04.07.2021.
//

import Foundation

class DetailCellViewModel {
    private var cellWeather: DailyWeatherStr
    
    var temp: String {
        return cellWeather.temp ?? "--"
    }
    
    var day: String {
        return cellWeather.day ?? ""
    }

    var icon: String {
        return cellWeather.icon ?? ""
    }
    
    init(cellWeather: DailyWeatherStr) {
        self.cellWeather = cellWeather
    }
}
