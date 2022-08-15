//
//  MomentImageGridView.swift
//  WeChat
//
//  Created by kira on 31/07/2022.
//

import SwiftUI

struct MomentImageGridView: View {
    @EnvironmentObject var mockData: MockDataViewModel
    
    private func getWidth(for index: Int, parentWidth: CGFloat) -> CGFloat {
        if (mockData.images.count % 2 == 0) {
            return parentWidth / 2
        } else {
            if (index == mockData.images.count - 1) {
                return parentWidth
            } else {
                return parentWidth / 2
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 8) {
                ForEach(mockData.images.indices, id: \.self) { index in
                    ZStack {
                        if (index <= 1) {
                            Image(mockData.images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getWidth(for: index, parentWidth: geometry.size.width - 8), height: 205)
                                .cornerRadius(7)
                        }
                        
                        if mockData.images.count > 2 && index == 1 {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.black.opacity(0.3))
                            
                            Text("+ \(mockData.images.count - 2)")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                        }
                    }
                }

            }
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15, alignment: .leading), count: 2)) {
//                ForEach(mockData.images.indices, id: \.self) { index in
//                    ZStack {
//                        if (index <= 1) {
//                            Image(mockData.images[index])
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: getWidth(for: index, parentWidth: geometry.size.width), height: 205)
//                                .cornerRadius(7)
//                        }
//
//                        if mockData.images.count > 2 && index == 1 {
//                            RoundedRectangle(cornerRadius: 5)
//                                .fill(.black.opacity(0.3))
//
//                            Text("+ \(mockData.images.count - 2)")
//                                .fontWeight(.heavy)
//                                .foregroundColor(.white)
//                        }
//                    }
//                }
//            }
        }
        .frame(height: 205)
    }
}

//struct MomentImageGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        MomentImageGridView()
//    }
//}
