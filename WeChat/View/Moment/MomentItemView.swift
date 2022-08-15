//
//  MomentItemView.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct MomentItemView: View {
    var moment: MomentVO
    
    @EnvironmentObject var mockData: MockDataViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("\(moment.authorProfile)-profile")
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text(moment.authorName)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(.colorPrimary)
                    
                    Text("15 min ago")
                        .font(.system(size: 12))
                        .foregroundColor(.colorGray)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .frame(height: 20)
            }
            
            Text(moment.description)
                .lineLimit(2)
                .font(.system(size: 12))
                .foregroundColor(.colorGray)
            
            
//            Rectangle()
//                .frame(height: 205)
            MomentImageGridView()
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 23, height: 20)
                    .foregroundColor(.colorRed)
                
                Text("10")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.colorRed)
                
                Spacer()
                
                Image(systemName: "ellipsis.bubble")
                    .frame(width: 26, height: 21.64)
                    .foregroundColor(.colorPrimaryVariant)
                
                Spacer()
                    .frame(width: 2)
                
                Text("2")
                    .font(.system(size: 15))
                    .foregroundColor(.colorPrimaryVariant)
                
                Spacer()
                    .frame(width: 16)
                
                Image(systemName: "bookmark")
                    .foregroundColor(.colorPrimaryVariant)
            }
        }
    }
}

struct MomentItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MomentItemView(moment: MockDataViewModel().moments[0])
            
            MomentItemView(moment: MockDataViewModel().moments[1])
        }
        .environmentObject(MockDataViewModel())
        .previewLayout(.fixed(width: 375, height: 350))
    }
}

