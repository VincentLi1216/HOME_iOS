//
//  RoomModel.swift
//  Home
//
//  Created by ζεεΎ on 2021/7/29.
//

import Foundation

struct Room: Identifiable, Codable{
    var id: String = UUID().uuidString
    let documentID: String
    let temperature: Int
    let humidity: Int
}

