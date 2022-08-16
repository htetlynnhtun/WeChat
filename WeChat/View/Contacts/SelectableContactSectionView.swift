//
//  SelectableContactSectionView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct SelectableContactSectionView: View {
    var sectionTitle: String
    var users: [UserVOD]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 0.5)
            
            VStack(alignment: .leading) {
                Text(sectionTitle)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.colorPrimary)
                
                Spacer()
                    .frame(height: 16)
                
                ForEach(users, id: \.self) { value in
                    SelectableContactItemView(user: value)
                }
            }
            .padding(8)
        }
    }
}
