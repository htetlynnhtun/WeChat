//
//  ContactGroupItemView.swift
//  WeChat
//
//  Created by kira on 20/07/2022.
//

import SwiftUI

struct ContactGroupItemView: View {
    var group: GroupVO
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 90, height: 90)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 4, x: 0, y: 2)
            
            VStack {
                Image("warrior-avatar")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(group.name)
                    .font(.system(size: 14))
            }
            .frame(width: 90, height: 90)
            .cornerRadius(5)
        }
    }
}

//struct ContactGroupItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactGroupItemView()
//    }
//}
