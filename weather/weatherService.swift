//
//  weatherService.swift
//  weather
//
//  Created by Caio Malvezzi on 24/05/24.
//

import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
}

struct Current: Codable {
    let temp_c: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let day: Day
}

struct Day: Codable {
    let avgtemp_c: Double
    let condition: Condition
}

class WeatherService {
    let apiKey = "90de4f15f1364328979135033242405"
    let baseUrl = "https://api.weatherapi.com/v1"
    
    func getWeather(for city: String, completion: @escaping (WeatherData?) -> Void) {
        let cityEscaped = adjustCityName(for: city)
        let urlString = "\(baseUrl)/current.json?key=\(apiKey)&q=\(cityEscaped)&lang=pt"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                print(weatherData)
                completion(weatherData)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    func getForecast(for city: String, completion: @escaping (Forecast?) -> Void) {
        let cityEscaped = adjustCityName(for: city)
        let urlString = "\(baseUrl)/forecast.json?key=\(apiKey)&q=\(cityEscaped)&lang=pt&days=5"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
                print(forecastData)
                completion(forecastData)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    func adjustCityName(for city: String) -> String {
        return city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
    }
}
