//
//  ViewModel.swift
//  MSTest
//
//  Created by Андрей Калямин on 30.06.2021.
//

import Foundation

class MainTableViewModel: NSObject {
    
    @IBOutlet weak var networkManager: NetworkWeatherManager!
    private var selectedIndexPath: IndexPath?
    
    private var citiesList = UserDefaults.standard.object(forKey: "cities") as? [String] ?? []
    var citiesWeather: [Weather]? = []
    
    
    func fetchAllWeather(completion: @escaping() -> ()) {
        citiesWeather = []
        citiesList.forEach { city in
            fetchWeather(city: city) {
                completion()
            }
        }
        completion()
    }
    
    func fetchWeather(city: String, completion: @escaping() -> ()) {
        networkManager.fetchWeather(city: city) { [weak self] city in
            self?.citiesWeather?.append(city)
            completion()
        }
        
    }
    
    func deleteCity(row: Int) {
        citiesList.remove(at: row)
        citiesWeather?.remove(at: row)
        UserDefaults.standard.set(citiesList, forKey: "cities")
    }
    
    func addCity(city: String) {
        citiesList.append(city)
        UserDefaults.standard.set(citiesList, forKey: "cities")

        networkManager.fetchWeather(city: city) { [weak self] city in
            self?.citiesWeather?.append(city)
        }
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
        return citiesWeather?.count ?? 0
    }
    
    func isCitiesEmpty() -> Bool{
        return citiesList.count==0 ? true : false
    }
}
