//
//  SelectableContactItemView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct SelectableContactItemView: View {
    @State private var selected = false
    var user: UserVOD
    
    var body: some View {
        HStack {
            ContactItemView(user: user)
            
            Button {
                selected.toggle()
                print("Selected: \(selected)")
            } label: {
                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.colorPrimary)
            }
        }
    }
}
