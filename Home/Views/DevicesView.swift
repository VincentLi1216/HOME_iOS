//
//  RoomDetailView.swift
//  Home
//
//  Created by 李善得 on 2021/7/30.
//

import SwiftUI

struct DevicesView: View {
    
    
    @State var roomName = ""
    @State var showSheet = false
    @State var cheatSheetPath = ""
    @State var deviceName = ""
    @State var roomPath = ""
    @State var viewState = CGSize.zero
    @State var isFailed = false
    @State var showAlert = false
    @State var isReallyFailed = true
    @EnvironmentObject var showTab: ShowTab
    //@State var buttonIsPressed = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: DevicesViewModel
    let lightImpactMed = UIImpactFeedbackGenerator(style: .light)
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    init(roomPath: String){
        self.viewModel = DevicesViewModel(roomPath: roomPath)
        self.roomName = roomPath
        
    }
    
    var body: some View {
        
        ZStack{
            
            
            Rectangle()
                .opacity(0)
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                           startPoint: .topTrailing,
                                           endPoint: .bottomLeading))
                .ignoresSafeArea()

            
           
            VStack(alignment:.leading){
                
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        
                        HStack{
                            Image(systemName: "chevron.backward")
                                .padding(.leading)
                                .font(.system(size: 45, weight: .light))
                            
                            Text(viewModel.roomPath)
                                .offset(x: -10)
                                .font(.system(size: 50, weight: .medium))
                                
                        }.accentColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .padding(.top)

                        
                        
                    })
                    
                    Spacer()
                }  .blur(radius: showSheet ? 15 : 0)
                .animation(.easeOut)

                
                ScrollView{
                    ForEach(viewModel.devices){ device in
                        
                        ZStack{
                            HStack{
                                
                                Spacer()
                                
                                VStack{
                                    
                                    
                                    Image(systemName: device.iconName)
                                        .aspectRatio(contentMode: .fill)
                                        .font(.system(size: 60, weight: .black))
                                        .frame(width:100, height:100)
                                        .offset(y:5)
                                        .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                                    
                                    Text("\(device.documentID)")
                                        .font(.system(size: 30, weight: .regular))
                                        .foregroundColor(.secondary)
                                        .offset(y:-5)
                                    
                                    
                                    
                                    
                                }.blur(radius: showSheet ? 15 : 0)
                                .animation(.easeOut)
                                
                                
                                Spacer()
                                
                                Image(systemName: "power")
                                    .font(.system(size: 70, weight: .semibold))
                                    .foregroundColor(device.status ? .green : .gray)
                                    .animation(nil)
                                    .blur(radius: showSheet ? 15 : 0)
                                    .animation(.easeOut)
                                
                                Spacer()

                        
                            }.frame(maxWidth:.infinity)
                            .frame(height:150)
                            .background(
                                Color.white
                            )
                            .opacity(device.status ? 1 : 0.7)
                            .cornerRadius(25)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            
                            .onTapGesture {
                                
                                viewModel.toggleStatus(device: device.documentID, IRRawData: device.powerIRRawData)
                                impactMed.impactOccurred()
                                viewModel.ButtonWasPressedIsTrue(deviceID: device.documentID)
                            }.onLongPressGesture {
                                if device.status{
                                    lightImpactMed.impactOccurred()
                                    cheatSheetPath = "CheatSheets/\(device.roomPath)/Devices/\(device.documentID)/CheatSheet"
                                    deviceName = device.documentID
                                    roomPath = device.roomPath
                                    showSheet.toggle()
                                }
                                
                            }
                            .blur(radius: showSheet ? 15 : 0)
                            .animation(.easeOut)
                            
                            
//                            VStack{
//
//                                HStack{
//
//                                    Spacer()
//
//                                    if device.buttonWasPressed{
//
//
//                                        if device.isCompleted{
//                                            Image(systemName:"checkmark.circle.fill")
//                                                .font(.system(size: 20))
//                                                .foregroundColor(.green)
//                                                .padding(25)
//                                                .padding(.trailing, 5)
//                                                .onAppear(){
//                                                    isFailed = false
//                                                    isReallyFailed = false
//                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                                        viewModel.ButtonWasPressedIsFalse(deviceID: device.documentID)
//                                                    }
//
//                                                }
//
//                                        }
//
//                                        if !device.isCompleted && !isFailed{
//                                            ProgressView()
//                                                .padding(25)
//                                                .padding(.trailing, 5)
//                                                .onAppear(){
//                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                                                        //isFailed = true
//                                                        viewModel.ButtonWasPressedIsFalse(deviceID: device.documentID)
//                                                        if isReallyFailed{
//                                                            showAlert = true
//                                                        }
//                                                    }
//                                                }
//                                        }
//
//
////                                        if isFailed{
////                                            Image(systemName:"checkmark.circle.fill")
////                                                .font(.system(size: 20))
////                                                .foregroundColor(.red)
////                                                .padding()
////                                                .padding(.top, 7)
////                                                .onAppear(){
////
////                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                                                        viewModel.ButtonWasPressedIsFalse(deviceID: device.documentID)
////                                                        isFailed = false
////                                                    }
////
////                                                }
////
////                                        }
//
//
//
//                                    }
//                                }
//
//
//                                Spacer()
//                            }
                            
                            
                            
                        }
                        
                        
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Error occurs when trying to connect with raspberry pi"), dismissButton: .default(Text("OK")))
                }
            }
            
            
            
            if showSheet {
                
                //MARK: CheatSheetView
                ZStack{
                    CheatSheetsView(CheatSheetPath: cheatSheetPath, roomPath: roomPath)
                        .cornerRadius(25)
                        .padding(30)
                    
                    VStack{

                        HStack{
                            HStack{
                                Image(systemName: "chevron.down.circle")
                                    .padding(.leading)
                                    .font(.system(size: 50, weight: .medium))
                                    .padding(.trailing)

                                Text(deviceName)
                                    .offset(x: -10)
                                    .font(.system(size: 50, weight: .medium))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                            .foregroundColor(Color(#colorLiteral(red: 0.2927811146, green: 0.4152171612, blue: 0.9781650901, alpha: 1)))
                            .padding(30)
                            .padding(.top, 20)

                            Spacer()
                        }


                        Spacer()
                    }.gesture(
                        DragGesture()
                            .onChanged({ yOffset in
                                self.viewState = yOffset.translation
                                self.viewState.height *= 3
                            })
                            .onEnded({ yOffset in
                                if self.viewState.height > 200{
                                    self.viewState = CGSize(width: 0, height: 800)
                                    showSheet = false
                                    lightImpactMed.impactOccurred()
                                    self.viewState = CGSize.zero
                                }else{
                                    self.viewState = CGSize.zero
                                }
                                
                                
                            })
                    )
                }.transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeOut)
                .offset(y: viewState.height)
                //.offset(y: -30)
                
                
            }
            
        }.onDisappear(){
            presentationMode.wrappedValue.dismiss()
            //showTab.showTab = true

        }
        .onAppear(){
            viewModel.fetchData()
            //showTab.showTab = false
        }

    }
}

struct RoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView(roomPath: "主臥室")
    }
}
