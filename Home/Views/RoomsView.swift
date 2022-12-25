//
//  HomeView.swift
//  Home
//
//  Created by 李善得 on 2021/8/13.
//

import SwiftUI

struct RoomsView: View {
    
    @ObservedObject private var viewModel = RoomsViewModel()
    @State var name = ""
    @State var cityID = ""
    
    
    
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var badInternetConnection = false
    
    var body: some View {
        
        VStack{
            NavigationView{
                
                
                ScrollView(showsIndicators: false){
                    VStack{
                        
                        if let weather = weather{
                            WeatherView(weather: weather)
                            
                        }else{
                            WeatherLoadingView()
                                .frame(height: 190)
                                .task{
                                    do{
                                        weather = try await weatherManager.getCurrentWeather(cityID: cityID)
                                    }catch{
                                        print("Error getting weather: \(error)")
                                        badInternetConnection = true
                                        
                                    }
                                }
                        }
                        
     
                        ForEach(viewModel.rooms){room in
                            
                            NavigationLink(
                                destination: DevicesView(roomPath: room.documentID)
                                    //.offset(y:-10)
                                    
                                ,
                                label: {
                                    HStack(spacing: 30){
                                        Text(room.documentID)
                                            .font(.system(size: 40, weight: .bold, design: .serif))
                                        
                                        Text("\(room.temperature)°C")
                                            .font(.system(size: 30, weight: .light, design: .default))
                                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                        
                                        Text("\(room.humidity)%")
                                            .font(.system(size: 30, weight: .light, design: .default))
                                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    }.padding(.vertical ,40)
                                    .accentColor(.black)
                                    .frame(maxWidth:.infinity)
                                    .background(
                                        Color.white
                                            .cornerRadius(15)
                                            .shadow(color: .gray, radius: 15)
                                    
                                    )
                                    .frame(maxWidth:.infinity)
                                    .padding(.vertical, 7)
                                    
                                })
                            
                           
                        }

                        
                        
                    }
                    .padding()

                }
                .navigationTitle("\(name)'s Home")
                
                

            }.onAppear(){
                viewModel.fetchData()
                name = UserDefaults.standard.string(forKey: "Name") ?? "Vincent"
                cityID = UserDefaults.standard.string(forKey: "CityID") ?? "1665148"
                
                
            }

            Text("")
                .padding(.bottom, 50)
        }.alert(isPresented: $badInternetConnection) {
            Alert(title: Text("Lost Internet Connection!"), message: Text("Please check again your internet connection"))
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsView()
    }
}
