//
//  WeatherLoadingView.swift
//  Home
//
//  Created by 李善得 on 2022/1/29.
//

import SwiftUI

struct WeatherLoadingView: View {
    var body: some View {
        HStack(alignment:.center, spacing: 50){
            VStack(alignment: .leading){
                
                LoadingView(color: .white)
                
            }.padding(.horizontal)
            
            
            
            
        }.padding(30)
        .frame(maxWidth: .infinity, maxHeight: 140)
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                           startPoint: .topTrailing,
                           endPoint: .bottomLeading)
            )
        .cornerRadius(15)
        .padding(.vertical, 20)
    }
    
}

struct WeatherLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLoadingView()
            .padding()
    }
}
