//
//  ContentView.swift
//  weather
//
//  Created by Caio Malvezzi on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    @State private var cityName: String = ""
    @State private var weatherData: WeatherData?
    @State private var forecastData: Forecast?
    @State private var errorMessage: String?
    
    struct DayData {
        let day: String
        let temperature: String
        let iconName: String
    }
    
    let daysData: [DayData] = [
        DayData(day: "TUE", temperature: "74°", iconName: "cloud.sun.fill"),
        DayData(day: "WED", temperature: "70°", iconName: "sun.max.fill"),
        DayData(day: "THU", temperature: "66°", iconName: "wind"),
        DayData(day: "FRI", temperature: "60°", iconName: "sunset.fill"),
        DayData(day: "SAT", temperature: "55°", iconName: "moon.stars.fill"),
    ]
    
    func fetchWeather(for city: String) {
        let weatherService = WeatherService()
        weatherService.getWeather(for: city) { data in
            DispatchQueue.main.async {
                if let data = data {
                    print(data)
                    self.weatherData = data
                } else {
                    self.errorMessage = "Não foi possível carregar os dados do tempo."
                }
            }
        }
        weatherService.getForecast(for: "Mogi Mirim") {
            data in
            DispatchQueue.main.async {
                if let data = data {
                    print(data)
                    self.forecastData = data
                } else {
                    self.errorMessage = "Não foi possível carregar os dados dos próximos dias"
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack {
                TextField("Enter city name", text: $cityName, onCommit: {
                    fetchWeather(for: cityName)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                CityNameView(cityName: weatherData?.location.name ?? "", stateName: weatherData?.location.region ?? "")
                TemperatureTodayView(icon: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: weatherData?.current.temp_c ?? 0)
                HStack() {
                    ForEach(daysData, id: \.day) {
                        day in DaysView(day: day.day, temperature: day.temperature, iconName: day.iconName)
                    }
                }.padding(.top, 20)
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(buttonText: "Change day time", textColor: .blue, backgroundColor: .white)
                }
                Spacer()
            }
        }.onAppear {
            fetchWeather(for: "Mogi Mirim")
        }
    }
}

#Preview {
    ContentView()
}

struct CityNameView: View {
    var cityName: String
    var stateName: String
    
    var body: some View {
        HStack() {
            Text(cityName)
                .font(.system(size: 36, weight: .medium, design: .default))
                .foregroundColor(.white)
            Text("-")
                .font(.system(size: 36, weight: .medium, design: .default))
                .foregroundColor(.white)
            Text(stateName)
                .font(.system(size: 36, weight: .medium, design: .default))
                .foregroundColor(.white)
        }.padding(.top, 25)
    }
}

struct DaysView: View {
    var day: String
    var temperature: String
    var iconName: String
    
    var body: some View {
            VStack(spacing: 18) {
                Text(day)
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundStyle(.white)
                Image(systemName: iconName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                Text(temperature)
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundStyle(.white)
            }.padding(.horizontal, 7)
    }
}

struct TemperatureTodayView: View {
    var icon: String
    var temperature: Double = 0.0
    var formattedTemperature: String {
        return String(format: "%.1f°", temperature)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text(formattedTemperature)
                .font(.system(size: 70,
                              weight: .medium,
                              design: .default))
                .foregroundStyle(.white)
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight: Bool
    
    var body: some View {
        
        LinearGradient(colors: [isNight ? .black : .blue , isNight ? .gray : Color("lightBlue")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
