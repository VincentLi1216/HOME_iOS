//
//  HomeApp.swift
//  Home
//
//  Created by 李善得 on 2021/7/29.
//

import SwiftUI
import Firebase

@main
struct HomeApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
        }
    }
}
