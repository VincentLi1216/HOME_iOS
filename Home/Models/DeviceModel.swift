//
//  DeviceModel.swift
//  Home
//
//  Created by 李善得 on 2021/9/5.
//

import Foundation

struct Device: Identifiable, Codable{
    var id: String = UUID().uuidString
    let documentID: String
    let status: Bool
    var roomPath: String = ""
    let powerIRRawData: String
    let buttonWasPressed: Bool
    let isCompleted: Bool
    let iconName: String
}
