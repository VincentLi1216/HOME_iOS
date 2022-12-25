//
//  DeviceViewModel.swift
//  Home
//
//  Created by 李善得 on 2021/9/5.
//

import Foundation
import FirebaseFirestore

class DevicesViewModel: ObservableObject{
    
    init(roomPath: String) {
        self.roomPath = roomPath
    }
    
    @Published var devices:[Device] = []
    

    
    
    private var db = Firestore.firestore()
    
    @Published var roomPath: String
    
    func fetchData(){
        db.collection("CheatSheets/\(roomPath)/Devices").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.devices = documents.map{(QueryDocumentSnapshot) -> Device in
                let data = QueryDocumentSnapshot.data()
                
                let documentID = QueryDocumentSnapshot.documentID
                let status = data["status"] as? Bool ?? false
                let powerIRRawData = data["powerIRRawData"] as? String ?? ""
                let buttonWasPressed = data["buttonWasPressed"] as? Bool ?? false
                let isCompleted = data["isCompleted"] as? Bool ?? false
                let iconName = data["iconName"] as? String ?? "wind"
                
                
                    let device = Device(documentID: documentID, status: status, roomPath:self.roomPath, powerIRRawData: powerIRRawData, buttonWasPressed: buttonWasPressed, isCompleted: isCompleted, iconName: iconName)

                return device
            }
        }
    }
    
    func toggleStatus(device:String, IRRawData:String){
        
        let cheatSheetRef = db.collection("CheatSheets/\(roomPath)/Devices").document(device)
        let newDoc = db.collection("Requests").document()
        var executeStatus = false
        
        
        newDoc.setData(["IRRawData" : IRRawData, "destination" : roomPath, "isCompleted" : false, "path" : "CheatSheets/\(roomPath)/Devices/\(device)"]) { error in
            if error != nil{
                //we have a problem here
            }else{
                //doc added sucessfully
            }
        }
        
        cheatSheetRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()//.map(String.init(describing:)) ?? "nil"
                let onOrOff = dataDescription!["status"] as? Bool ?? false
                
                if onOrOff{
                    executeStatus = false
                }else{
                    executeStatus = true
                }
                
                self.db.collection("CheatSheets/\(self.roomPath)/Devices").document(device).setData([ "status": executeStatus, "buttonWasPressed" : true, "isCompleted" : false ], merge: true)
                    //print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
        }
        
    }
    
    func ButtonWasPressedIsTrue(deviceID: String){
        db.collection("CheatSheets/\(roomPath)/Devices").document(deviceID).setData(["isCompleted" : false], merge: true)
        db.collection("CheatSheets/\(roomPath)/Devices").document(deviceID).setData(["buttonWasPressed" : true], merge: true)
        
    }
    
    func ButtonWasPressedIsFalse(deviceID: String){
        db.collection("CheatSheets/\(roomPath)/Devices").document(deviceID).setData(["buttonWasPressed" : false], merge: true)
    }
}
