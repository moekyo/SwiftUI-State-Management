//
//  ContentView.swift
//  DataManagementDemo
//
//  Created by Rex Xin on 2023/11/24.
//

import SwiftUI

// MARK: @State
struct ContentView: View {
    @State private var greenBG = false
    @State private var count = 0
    var body: some View {
        ZStack(content: {
            if greenBG {
                Color.green.ignoresSafeArea()
            } else {
                Color.cyan.ignoresSafeArea()
            }
            VStack(spacing: 20, content: {
                Button("Reload background color") {
                    greenBG.toggle()
                }
                .buttonStyle(.borderedProminent)
                Text("current count: \(count)")
                MyView(counter: $count)
            })
        })
        
    }
}
// MARK: @Binding
struct MyView: View {
    @Binding var counter: Int
    var body: some View {
        HStack {
            Button {
                counter = counter + 1
            } label: {
                Text("+ 1")
            }
            Button {
                counter = counter - 1
            } label: {
                Text("- 1")
            }
        }
        .buttonStyle(.borderedProminent)

    }
}

#Preview("@State&@Binding") {
    ContentView()
}


class DataModel: ObservableObject {
    @Published var name = "Some Name"
}
struct ObservableObjectView: View {
    @ObservedObject private var model = DataModel()

    var body: some View {
        Text("current user name: \(model.name)")
        UserEditView(model: model)
    }
}

struct UserEditView: View {
    @ObservedObject var model: DataModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack() {
            TextField("Name", text: $model.name)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

#Preview("@ObservatedObject") {
    ObservableObjectView()
}

