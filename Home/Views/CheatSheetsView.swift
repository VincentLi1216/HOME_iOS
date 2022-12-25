//
//  CheatSheetsView.swift
//  Home
//
//  Created by 李善得 on 2021/9/5.
//

import SwiftUI

struct CheatSheetsView: View {
    

    @ObservedObject private var viewModel: CheatSheetsViewModel
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    @State var isFailed = false
    init(CheatSheetPath: String, roomPath: String){
        viewModel = CheatSheetsViewModel(CheatSheetPath: CheatSheetPath, roomPath: roomPath)
    }
    var body: some View {
        
        ZStack{
            
            Color(.white)
                .ignoresSafeArea()
            
            VStack{
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 90)
                    .foregroundColor(.white)
                    

                
                List(viewModel.cheatSheets){cheatSheet in
                    
                    Button(action: {
                        viewModel.ButtonWasPressedIsTrue(cheatSheetID: cheatSheet.documentID)
                        viewModel.sendFunc(IRRawData: cheatSheet.IRRawData, DocID: cheatSheet.documentID)
                        impactMed.impactOccurred()
                        
                        
                    }, label: {
                        
                        ZStack{
                            ZStack{
                             
                                Color(.white)
                                    .cornerRadius(13)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                
                                Text(cheatSheet.documentID)
                                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                    .font(.system(size: 30, weight: .black))
                                    .padding()
                                    .padding(.horizontal, 20)

                            }.padding(.vertical, 10)
                            
//                            VStack{
//
//                                HStack{
//                                    Spacer()
//
//                                    if cheatSheet.buttonWasPressed{
//
//
//                                        if cheatSheet.isCompleted{
//                                            Image(systemName:"checkmark.circle.fill")
//                                                .font(.system(size: 20))
//                                                .foregroundColor(.green)
//                                                .padding()
//                                                .padding(.top, 7)
//                                                .onAppear(){
//
//                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                                        viewModel.ButtonWasPressedIsFalse(cheatSheetID: cheatSheet.documentID)
//                                                    }
//
//                                                }
//
//                                        }
//                                        
//                                        if !cheatSheet.isCompleted && !isFailed{
//                                            ProgressView()
//                                                .onAppear(){
//                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                                                        isFailed = true
//                                                    }
//                                                }
//                                        }
//                                        
//                                        
//                                        if isFailed{
//                                            Image(systemName:"checkmark.circle.fill")
//                                                .font(.system(size: 20))
//                                                .foregroundColor(.red)
//                                                .padding()
//                                                .padding(.top, 7)
//                                                .onAppear(){
//
//                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                                        viewModel.ButtonWasPressedIsFalse(cheatSheetID: cheatSheet.documentID)
//                                                        isFailed = false
//                                                    }
//
//                                                }
//
//                                        }
//                                        
//
//
//                                    }
//
//                                }
//
//                                Spacer()
//                            }
                            
                            
                        }
                        
                        
                    }).buttonStyle(ScaleButtonStyle())
                    
                    
                }.onAppear(){
                    viewModel.fetchData()
                }
                .transition(AnyTransition.opacity)
                .animation(nil)
                

            }
        }
        
        
        
    }
}

struct CheatSheetsView_Previews: PreviewProvider {
    static var previews: some View {
        CheatSheetsView(CheatSheetPath: "CheatSheets/主臥室/Devices/電風扇/CheatSheet", roomPath: "主臥室")
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.6 : 1.0)
            .animation(.spring())
    }
}
