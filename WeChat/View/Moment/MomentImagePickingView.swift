//
//  MomentImagePickingView.swift
//  WeChat
//
//  Created by kira on 31/07/2022.
//

import SwiftUI

struct MomentImagePickingView: View {
    @EnvironmentObject var momentVM: MomentViewModel
    @State private var isPresentingPicker = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                
                ForEach(momentVM.selectedUIImages.indices, id: \.self) { i in
                    Image(uiImage: momentVM.selectedUIImages[i])
                        .resizable()
                        .frame(width: 108, height: 108)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                }
                
                Button {
                    isPresentingPicker = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 64))
                        .foregroundColor(.colorPrimary)
                    
                }
                .frame(width: 108, height: 108)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.colorPrimary, lineWidth: 3)
                }
                .sheet(isPresented: $isPresentingPicker) {
                    PhotoPicker(isPresented: $isPresentingPicker, selectedImages: $momentVM.selectedUIImages)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 111)
        }
    }
}

struct MomentImagePickingView_Previews: PreviewProvider {
    static var previews: some View {
        MomentImagePickingView()
            .previewLayout(.sizeThatFits)
    }
}

