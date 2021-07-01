//
//  ViewModel.swift
//  MSTest
//
//  Created by Андрей Калямин on 30.06.2021.
//

import Foundation

class MainTableViewModel: NSObject {
    
    private var selectedIndexPath: IndexPath?
    
    private var citiesList = ["Ufa","asd"]
    private var citiesWeather: [Weather]? = []
    
    func fetchAllWeather(completion: @escaping() -> ()) {
        citiesList.forEach { [weak self] city in
            self?.citiesWeather?.append(Weather(city: city, temp: 0))
        }
        completion()
        
    }
    
    func cellViewModel(indexPath: IndexPath) -> MainTableCellViewModel? {
        guard let cityWeather = citiesWeather?[indexPath.row] else { return nil }
        return MainTableCellViewModel(cityWeather: cityWeather)
    }
    
    func viewModelForSelectedRow() -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModel(city: citiesWeather![selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func numberOfRows() -> Int{
        return citiesList.count
    }
}
