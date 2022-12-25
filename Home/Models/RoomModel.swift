//
//  RoomModel.swift
//  Home
//
//  Created by 李善得 on 2021/7/29.
//

import Foundation

struct Room: Identifiable, Codable{
    var id: String = UUID().uuidString
    let documentID: String
    let temperature: Int
    let humidity: Int
}

