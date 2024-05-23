//
//  WeatherButton.swift
//  weather
//
//  Created by Caio Malvezzi on 23/05/24.
//

import SwiftUI

struct WeatherButton: View {
    var buttonText: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(buttonText)
            .frame(width: 300, height: 55)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}

