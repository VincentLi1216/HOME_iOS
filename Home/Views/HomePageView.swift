//
//  ContentView.swift
//  Home
//
//  Created by 李善得 on 2021/7/29.
//

import SwiftUI

struct HomePageView: View {
    
    @StateObject var isShowTab = ShowTab()
    var tabImageName = ["house.fill", "square.grid.2x2.fill", "chart.bar.xaxis", "gear"]
    var tabText = ["主頁", "房間", "數據", "設定"]
    @State var tabIndex = 0
    
    var body: some View {
        
        
        
//        TabView{
//            RoomsView()
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("主頁")
//                }
//
//            NotAvailableNowView()
//                .tabItem {
//                    Image(systemName: "square.grid.2x2.fill")
//                    Text("房間")
//                }
//
//            NotAvailableNowView()
//                .tabItem {
//                    Image(systemName: "chart.bar.xaxis")
//                    Text("數據")
//                }
//
//            NotAvailableNowView()
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("設定")
//                }
//
//        }.environmentObject(isShowTab)
//            .disabled(isShowTab.showTab)
        
        ZStack{
            
            switch tabIndex {
            case 0:
                VStack{
                    RoomsView()
                }.ignoresSafeArea(.all)
                
            case 1:
                NotAvailableNowView()
            case 2:
                NotAvailableNowView()
            case 3:
                SettingView()
            default:
                RoomsView()
                
                
            }

            
            VStack{
                Spacer()

                ZStack {


                    Rectangle()
                         .frame(height: 110)
                        .offset(y:45)
                        .ignoresSafeArea(.all)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 20)




                    HStack{
                        ForEach(0..<4){index in

                            HStack{

                                Spacer()


                                Button {
                                    tabIndex = index
                                } label: {

                                    VStack{
                                        Image(systemName: tabImageName[index])
                                            .frame(width: 20, height: 20)
                                            .font(.system(size: 25))
                                            .padding(0)
                                            .padding(.bottom, 2)


                                        Text(tabText[index])
                                            .font(.system(size: 13))

                                    }.foregroundColor(tabIndex == index ? .purple : .gray)


                                }




                                Spacer()
                            }.padding(.horizontal, 7)





                        }


                    }.offset(y: 30)
                }



            }
            
        }
        
        
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}




