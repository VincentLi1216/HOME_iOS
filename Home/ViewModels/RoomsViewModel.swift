//
//  RoomsVM.swift
//  Home
//
//  Created by 李善得 on 2021/9/5.
//

import Foundation
import FirebaseFirestore

class RoomsViewModel: ObservableObject{
    @Published var rooms:[Room] = []
    
    
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("CheatSheets").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.rooms = documents.map{(QueryDocumentSnapshot) -> Room in
                let data = QueryDocumentSnapshot.data()
                
                let documentID = QueryDocumentSnapshot.documentID
                let temperature = data["temperature"] as? Int ?? 0
                let humidity = data["humidity"] as? Int ?? 0
                
                let room = Room(documentID: documentID, temperature: temperature, humidity: humidity)
                return room
            }
        }
    }
}

