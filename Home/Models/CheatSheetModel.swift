//
//  CheatSheetModelo.swift
//  Home
//
//  Created by 李善得 on 2021/9/5.
//

import Foundation


struct CheatSheet: Identifiable, Codable{
    var id: String = UUID().uuidString
    let documentID: String
    let IRRawData: String
    let buttonWasPressed: Bool
    let isCompleted: Bool

}
