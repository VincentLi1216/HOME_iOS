//
//  LoadingView.swift
//  MyWeather
//
//  Created by 李善得 on 2022/1/28.
//

import SwiftUI

struct LoadingView: View {
    
    var color: Color
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: color))
            .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(color: .gray)
    }
}
