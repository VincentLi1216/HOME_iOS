//
//  CheatSheetModelo.swift
//  Home
//
//  Created by ζεεΎ on 2021/9/5.
//

import Foundation


struct CheatSheet: Identifiable, Codable{
    var id: String = UUID().uuidString
    let documentID: String
    let IRRawData: String
    let buttonWasPressed: Bool
    let isCompleted: Bool

}
