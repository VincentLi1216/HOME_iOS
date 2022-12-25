//
//  NotAvailableNowView.swift
//  Home
//
//  Created by 李善得 on 2021/8/13.
//

import SwiftUI

struct NotAvailableNowView: View {
    var body: some View {
        
        
        ZStack{
            Color(#colorLiteral(red: 0.9332684875, green: 0.7703300118, blue: 0, alpha: 1))
                .ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:120, height:120)
                    .font(.headline)
                    .padding(.top)
                
                Text("This function is not available yet!")
                    .font(.system(size: 35, weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Please wait till next firmware update, thank you for your patience.")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .foregroundColor(.white)
                
                Spacer()
                Spacer()

                
            }
        }
        
        
        
    }
}

struct NotAvailableNowView_Previews: PreviewProvider {
    static var previews: some View {
        NotAvailableNowView()
    }
}
