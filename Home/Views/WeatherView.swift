//
//  WeatherView.swift
//  Home
//
//  Created by 李善得 on 2022/1/29.
//

import SwiftUI



struct WeatherView: View {
   
    var weather: ResponseBody
    
    var body: some View {
        HStack(alignment:.center, spacing: 50){
            VStack(alignment: .leading){
                Text(weather.name)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .regular, design: .rounded))
                
                Text(weather.main.feels_like.roundDouble() + "°C")
                    .font(.system(size: 42, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
            }.padding(.horizontal)
            
            
            
            Image(systemName: getIcon(name: weather.weather[0].icon))
                .foregroundColor(.white)
                .font(.system(size: 70))
                .padding(.horizontal)
            
            
        }.padding(30)
        .frame(maxWidth:.infinity, maxHeight: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                           startPoint: .topTrailing,
                           endPoint: .bottomLeading)
            )
        .cornerRadius(15)
        .padding(.vertical, 20)
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
            .padding()
    }
}
