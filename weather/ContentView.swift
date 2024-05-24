//
//  ContentView.swift
//  weather
//
//  Created by Caio Malvezzi on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack {
                CityNameView(cityName: "Mogi Mirim", stateName: "SP")
                TemperatureTodayView(icon: isNight ? "moon.stars.fill" : "cloud.sun.fill")
                HStack() {
                    DaysView(day: "TUE", temperature: "74°", iconName: "cloud.sun.fill")
                    DaysView(day: "WED", temperature: "70°", iconName: "sun.max.fill")
                    DaysView(day: "THU", temperature: "66°", iconName: "wind")
                    DaysView(day: "FRI", temperature: "60°", iconName: "sunset.fill")
                    DaysView(day: "SAT", temperature: "55°", iconName: "moon.stars.fill")
                }.padding(.top, 20)
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(buttonText: "Change day time", textColor: .blue, backgroundColor: .white)
                }
                Spacer()
            }
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
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("76°")
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
