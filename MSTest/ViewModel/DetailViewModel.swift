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
    
    var temp: Int {
        return cityWeather.temp ?? 0
    }
    
    var icon: String {
        return cityWeather.icon ?? ""
    }
    
    var minTemp: String {
        return cityWeather.minTemp ?? ""
    }
    
    var maxTemp: String {
        return cityWeather.maxTemp ?? ""
    }
    
    var hourlyWeather: [HourlyWeather] {
        return cityWeather.hourlyWeather ?? []
    }
    
    var dailyWeather: [DailyWeatherStr] {
        return cityWeather.dailyWeather ?? []
    }
    
    init(city: Weather) {
        self.cityWeather = city
    }
    
    func collectionCellViewModel(indexPath: IndexPath) -> CollectionCellViewModel? {
        guard let cellWeather = cityWeather.hourlyWeather?[indexPath.row] else {return nil}//citiesWeather?[indexPath.row] else { return nil }
        return CollectionCellViewModel(cellWeather: cellWeather)
    }
    
    func scrollCellViewModel(indexPath: IndexPath) -> DetailCellViewModel? {
        guard let cellWeather = cityWeather.dailyWeather?[indexPath.row] else {return nil}//citiesWeather?[indexPath.row] else { return nil }
        return DetailCellViewModel(cellWeather: cellWeather)
    }
}
