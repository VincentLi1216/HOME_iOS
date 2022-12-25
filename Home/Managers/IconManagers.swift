//
//  iconManagers.swift
//  MyWeather
//
//  Created by 李善得 on 2022/1/29.
//

import Foundation
import SwiftUI


func getIcon(name: String) -> String{
    
    switch name{
        
    case "01d":
        return "sun.max"
    case "02d":
        return "cloud.sun"
    case "03d":
        return "cloud"
    case "04d":
        return "smoke"
    case "09d":
        return "cloud.rain"
    case "10d":
        return "cloud.sun.rain"
    case "11d":
        return "cloud.bolt.rain"
    case "13d":
        return "snowflake"
    case "50d":
        return "cloud.fog"
    case "01n":
        return "moon"
    case "02n":
        return "cloud.moon"
    case "03n":
        return "cloud"
    case "04n":
        return "smoke"
    case "09n":
        return "cloud.rain"
    case "10n":
        return "cloud.moon.rain"
    case "11n":
        return "cloud.bolt.rain"
    case "13n":
        return "snowflake"
    case "50n":
        return "cloud.fog"
        
    default:
        return "questionmark.square"
    }
}
