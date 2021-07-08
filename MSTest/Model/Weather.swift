//
//  Weather.swift
//  MSTest
//
//  Created by Андрей Калямин on 30.06.2021.
//

import Foundation

private let weekdays = [
    "1" : "Понедельник",
    "2" : "Вторник",
    "3" : "Среда",
    "4" : "Четверг",
    "5" : "Пятница",
    "6" : "Суббота",
    "7" : "Воскресенье"
]

private let iconMap = [
    "Rain" : "🌧",
    "Clouds" : "☁️",
    "Clear" : "☀️",
    "error" : " 🌚"
]

struct Weather {
    let city: String?
    let temp: Int?
    let icon: String?
    let minTemp: String?
    let maxTemp: String?
    let hourlyWeather: [HourlyWeather]?
    let dailyWeather: [DailyWeatherStr]?
    
    init(weatherData: WeatherData) {
        self.city = weatherData.city?.name
        self.temp = Int(weatherData.list?.first?.main?.temp ?? 0)
        self.minTemp = String(Int(weatherData.list?.first?.main?.temp_min ?? 0))
        self.maxTemp = String(Int(weatherData.list?.first?.main?.temp_max ?? 0))
        self.icon = iconMap[weatherData.list?.first?.weather.first?.description ?? ""]
        
        var result: [HourlyWeather] = []
        var resultDay: [DailyWeatherStr] = []
        weatherData.list?.forEach({ hour in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "UTC")!
            
            let days = formatter.date(from: hour.date!)
            let calendar = Calendar.current
            let day = weekdays[String(calendar.component(.weekday, from: days!))]!
            let hou = String(calendar.component(.hour, from: days!))
            if hou == "16" {
                resultDay.append(DailyWeatherStr(day: day, weatherData: hour))
            }
            result.append(HourlyWeather(hour: hou, weatherData: hour))
        })
        self.hourlyWeather = result
        
        self.dailyWeather = resultDay
    }
}

struct DailyWeatherStr {
    let temp: String?
    let day: String?
    let icon: String?
    
    init(day: String, weatherData: WeatherList){
        self.temp = String(Int(weatherData.main?.temp ?? 0))
        self.icon = iconMap[weatherData.weather.first?.description ?? ""]
        self.day = day
    }
}


struct HourlyWeather {
    let temp: String?
    let icon: String?
    var hour: String?
    
    init(hour: String, weatherData: WeatherList) {
        self.temp = String(Int(weatherData.main?.temp ?? 0))
        self.icon = iconMap[weatherData.weather.first?.description ?? ""]
        self.hour = hour
    }
    
}
