//
//  AddNewMomentScreen.swift
//  WeChat
//
//  Created by kira on 19/07/2022.
//

import SwiftUI
import CachedAsyncImage
import SDWebImageSwiftUI

struct AddNewMomentScreen: View {
    @EnvironmentObject var momentVM: MomentViewModel
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ProgressWrapperView(showActivityIndicator: momentVM.showActivityIndicator) {
            VStack {
                HStack {
                    WebImage(url: authVM.currentUser!.profilePicture)
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    Text(authVM.currentUser!.name)
                        .font(.system(size: 18))
                        .foregroundColor(.colorPrimary)
                    
                    Spacer()
                }
                
                ZStack(alignment: .leading) {
                    
                    if momentVM.textEditorValue.isEmpty {
                        VStack {
                            Text("What’s on your mind")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .padding(.top, 12)
                                .padding(.leading, 2)
                            
                            Spacer()
                        }
                    }
                    
                    TextEditor(text: $momentVM.textEditorValue)
                        .opacity(momentVM.textEditorValue.isEmpty ? 0.5 : 1)
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
                        momentVM.isPresentingNewMoment = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.colorPrimary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        momentVM.onTapCreateMoment(userVO: authVM.currentUser!)
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
}


struct AddNewMomentScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNewMomentScreen()
        }
    }
}
