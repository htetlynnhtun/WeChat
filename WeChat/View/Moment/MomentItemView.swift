//
//  MomentItemView.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI
import CachedAsyncImage
import SDWebImageSwiftUI

struct MomentItemView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @ObservedObject var vm: MomentItemViewModel
    var moment: MomentVO
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                WebImage(url: moment.profilePicture)
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(moment.username)
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
            
            
            MomentImageGridView(moment: moment)
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                Image(systemName: vm.heartImage)
                    .resizable()
                    .frame(width: 23, height: 20)
                    .foregroundColor(vm.heartColor)
                    .onTapGesture {
                        vm.onTapLike()
                    }
                
                Text("\(moment.likes.count)")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(vm.heartColor)
                
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
                
                Image(systemName: vm.bookmarkImage)
                    .foregroundColor(vm.bookmarkColor)
                    .onTapGesture {
                        vm.onTapBookmark()
                    }
            }
        }
    }
    
   
}

//struct MomentItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MomentItemView(moment: MockDataViewModel().moments[0])
//
//            MomentItemView(moment: MockDataViewModel().moments[1])
//        }
//        .environmentObject(MockDataViewModel())
//        .previewLayout(.fixed(width: 375, height: 350))
//    }
//}

