//
//  CheatSheetViewModel.swift
//  Home
//
//  Created by 李善得 on 2021/9/5.
//

import Foundation
import FirebaseFirestore

class CheatSheetsViewModel: ObservableObject{
    
    
    init(CheatSheetPath: String, roomPath: String) {
        self.roomPath = roomPath
        self.CheatSheetPath = CheatSheetPath
    }
    
    private var CheatSheetPath: String
    private var roomPath: String
    
    @Published var cheatSheets:[CheatSheet] = []
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection(CheatSheetPath).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.cheatSheets = documents.map{(QueryDocumentSnapshot) -> CheatSheet in
                let data = QueryDocumentSnapshot.data()
                
                let documentID = QueryDocumentSnapshot.documentID
                let IRRawData = data["IRRawData"] as? String ?? ""
                let buttonWasPressed = data["buttonWasPressed"] as? Bool ?? false
                let isCompleted = data["isCompleted"] as? Bool ?? false
                
                
                let cheatSheet = CheatSheet(documentID: documentID, IRRawData: IRRawData, buttonWasPressed: buttonWasPressed, isCompleted: isCompleted)
                return cheatSheet
            }
        }
    }
    
    func sendFunc(IRRawData:String, DocID:String){

        let newDoc = db.collection("Requests").document()
        

        newDoc.setData(["IRRawData" : IRRawData, "isCompleted" : false, "destination" : roomPath, "path" : "\(CheatSheetPath)/\(DocID)"]) { error in
            if error != nil{
                //we have a problem here
            }else{
                //doc added sucessfully
            }
        }
        
    }
    
    func ButtonWasPressedIsTrue(cheatSheetID: String){
        db.collection(CheatSheetPath).document(cheatSheetID).setData(["isCompleted" : false], merge: true)
        db.collection(CheatSheetPath).document(cheatSheetID).setData(["buttonWasPressed" : true], merge: true)
        
    }
    
    func ButtonWasPressedIsFalse(cheatSheetID: String){
        db.collection(CheatSheetPath).document(cheatSheetID).setData(["buttonWasPressed" : false], merge: true)

    }
}
