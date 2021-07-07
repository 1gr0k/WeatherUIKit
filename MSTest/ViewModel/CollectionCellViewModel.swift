//
//  ScrollCellViewModel.swift
//  MSTest
//
//  Created by Андрей Калямин on 04.07.2021.
//

import Foundation

class CollectionCellViewModel {
    private var cellWeather: HourlyWeather
    
    var temp: String {
        return cellWeather.temp ?? "--"
    }
    
    var hour: String {
        return cellWeather.hour ?? ""
    }

    var icon: String {
        return cellWeather.icon ?? ""
    }
    
    init(cellWeather: HourlyWeather) {
        self.cellWeather = cellWeather
    }
}
