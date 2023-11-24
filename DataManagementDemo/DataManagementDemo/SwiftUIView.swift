//
//  SwiftUIView.swift
//  DataManagementDemo
//
//  Created by Rex Xin on 2023/11/24.
//

import SwiftUI

@Observable class DataModel2 {
    var name = "Some Name"
}
struct ObservableObjectView2: View {
    private var model = DataModel2()

    var body: some View {
        Text("current user name: \(model.name)")
        UserEditView2(model: model)
    }
}

struct UserEditView2: View {
    @Bindable var model: DataModel2
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
    ObservableObjectView2()
}

