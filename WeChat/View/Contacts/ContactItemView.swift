//
//  ContactItemView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct ContactItemView: View {
    @State private var selected = false
    var user: UserVO
    
    var body: some View {
        HStack {
            ChatHeadItemView(isActive: true, avatar: user.profilePicture)
            
            Text(user.name)
                .font(.system(size: 16))
                .foregroundColor(.colorPrimary)
            
            Spacer()
        }
    }
}
