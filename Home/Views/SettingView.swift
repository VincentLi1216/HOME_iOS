//
//  SettingView.swift
//  Home
//
//  Created by 李善得 on 2022/1/29.
//

import SwiftUI

struct SettingView: View {
    
//    @AppStorage("userName") var userName: String?  //AppStorage seems doesn't work well passing through Views
    
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    
    @State var userName = ""
    @State var userCityID = ""
    @State var changed = false
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        
        
        
        NavigationView{
            
            VStack{
                
                VStack{
                    
                    HStack{
                        Text("Your Name:")
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    
                    
                    TextField(userName == "" ? "type somthing" : userName, text: $userName){ change in
                        
                        if change {
                            changed = true
                        }else{
                            changed = false
                        }
                        
                    }
                        .foregroundColor(.gray)
                        .padding()
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }.padding(.top, 30)
                
                
                
                VStack{
                    
                    HStack{
                        Text("Your CityID:")
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    
                    
                    TextField(userCityID == "" ? "type somthing" : userCityID, text: $userCityID){ change in
                        
                        if change {
                            changed = true
                        }else{
                            changed = false
                        }
                        
                    }
                    .foregroundColor(isCityIDValid() ? .gray : .red)
                        .padding()
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }.padding(.vertical, 30)
                    
                Button {
                    impactMed.impactOccurred()
                    changed = false
                    UserDefaults.standard.set(userName, forKey: "Name")
                    UserDefaults.standard.set(userCityID, forKey: "CityID")
                    
                    
                    
                } label: {
                    Text("Save Preference")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(isAllValid() && changed ? .blue : .gray)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 30)
                        .padding()
                }.disabled(!isAllValid() && !changed)

                
                
                
                Spacer()
                
            }
            .navigationTitle("Setting")
            .onAppear {
                userName = UserDefaults.standard.string(forKey: "Name") ?? ""
                userCityID = UserDefaults.standard.string(forKey: "CityID") ?? "7279742"
            }
            
            
            
                
            
        }
        
        
        
    }
    
    
    func isCityIDValid() -> Bool{
        if userCityID.count == 7{
            return true
        }else{
            return false
        }
        
        
        
        
    }
    
    func isChanged() -> Bool{
        if UserDefaults.standard.string(forKey: "Name") == userName && UserDefaults.standard.string(forKey: "CityID") == userCityID{
            return false
        }else{
            return true
        }
    }
    
    func isAllValid() -> Bool{
        
        if isCityIDValid() && isChanged(){
            return true
        }else{
            return false
        }
            
    }

}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}


