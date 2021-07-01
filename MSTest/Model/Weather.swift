//
//  Weather.swift
//  MSTest
//
//  Created by Андрей Калямин on 30.06.2021.
//

import Foundation

struct Weather {
    let city: String?
    let temp: Int?
    
    init(city: String, temp: Int) {
        self.city = city
        self.temp = temp
    }
}
