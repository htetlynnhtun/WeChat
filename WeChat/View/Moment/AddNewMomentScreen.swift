//
//  AddNewMomentScreen.swift
//  WeChat
//
//  Created by kira on 19/07/2022.
//

import SwiftUI

struct AddNewMomentScreen: View {
    @Binding var isPresentingNewMoment: Bool
    @State private var textEditorValue = ""
    
    var body: some View {
        VStack {
            HStack {
                Image("lamelo-profile")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                Text("Lamelo")
                    .font(.system(size: 18))
                    .foregroundColor(.colorPrimary)
                
                Spacer()
            }
            
            ZStack(alignment: .leading) {
                
                if textEditorValue.isEmpty {
                    VStack {
                        Text("What’s on your mind")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .padding(.top, 12)
                            .padding(.leading, 2)
                        
                        Spacer()
                    }
                }
                
                TextEditor(text: $textEditorValue)
                    .opacity(textEditorValue.isEmpty ? 0.5 : 1)
            }
            
            Spacer()
            
            MomentImagePickingView()
        }
        .navigationTitle("New Moment")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isPresentingNewMoment = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.colorPrimary)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("Pressed")
                } label: {
                    Text("Create")
                        .padding(.trailing, 8)
                }
                .frame(width: 70, height: 32)
                .wcPrimaryButton()
            }
        }
        .padding()
        .onAppear {
            UINavigationBar.appearance().titleTextAttributes = [
                .font : UIFont(name: "YorkieDEMO-Medium", size: 24)!,
                .foregroundColor: UIColor(.colorPrimary)
            ]
        }
        
    }
}


struct AddNewMomentScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNewMomentScreen(isPresentingNewMoment: .constant(false))
        }
    }
}
