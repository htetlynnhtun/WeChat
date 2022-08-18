//
//  SelectableContactItemView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct SelectableContactItemView: View {
    
    @EnvironmentObject var contactVM: ContactViewModel
    
    var user: UserVO
    
    var body: some View {
        HStack {
            ContactItemView(user: user)
            
            Button {
                contactVM.onTapSelect(user)
            } label: {
                Image(systemName: contactVM.isSelected(user) ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.colorPrimary)
            }
        }
    }
}
