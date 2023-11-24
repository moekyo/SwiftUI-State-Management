//
//  DataManagementDemoApp.swift
//  DataManagementDemo
//
//  Created by Rex Xin on 2023/11/24.
//

import SwiftUI

@main
struct DataManagementDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ObservableObjectView()
//                .environmentObject(DataModel())
        }
    }
}
