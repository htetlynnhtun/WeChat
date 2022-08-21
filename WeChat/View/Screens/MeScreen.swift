//
//  MeScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MeScreen: View {
    @EnvironmentObject var momentVM: MomentViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var meVM: MeViewModel
    
    var body: some View {
        ProgressWrapperView(showActivityIndicator: meVM.showActivityIndicator) {
            ZStack {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        HStack {
                            ZStack {
                                WebImage(url: meVM.profilePicture)
                                    .resizable()
                                    .indicator(.activity)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                
                                Image(uiImage: meVM.qrCodeImage)
                                    .resizable()
                                    .interpolation(.none)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 48, height: 48)
                                    .offset(x: 34, y: 36)
                                    .onTapGesture {
                                        meVM.showQRCodeDialog = true
                                    }
                                
                                Button {
                                    meVM.showPhotoPicker = true
                                } label: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 19, height: 19)
                                        .font(.system(size: 1, weight: .black, design: .default))
                                        .foregroundColor(.white)
                                }
                                .offset(x: -52, y: 48)
                            }
                            .frame(width: 120, height: 120)
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text(meVM.name)
                                    .font(.system(size: 20))
                                
                                HStack {
                                    Image(systemName: "iphone.homebutton")
                                    
                                    Text(authVM.currentUser?.qrCode ?? "")
                                        .font(.system(size: 14))
                                }
                                
                                HStack {
                                    Image(systemName: "calendar")
                                    
                                    Text(meVM.dob.toDobFormat())
                                        .font(.system(size: 14))
                                }
                                
                                HStack {
                                    Image(systemName: "arrow.triangle.branch")
                                    
                                    Text(meVM.gender)
                                        .font(.system(size: 14))
                                }
                            }
                            .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width - 32,height: 144)
                        .background {
                            Color.colorPrimary
                        }
                        .cornerRadius(8)
                        
                        HStack {
                            Text("Bookmarked Moments")
                                .font(.system(size: 20, design: .serif))
                                .underline()
                                .foregroundColor(.colorPrimary)
                            
                            Spacer()
                        }
                        .padding()
                        
                        if (momentVM.bookmarkedMoments.isEmpty) {
                            Text("No bookmarked Moments...")
                        } else {
                            ForEach(momentVM.bookmarkedMoments) { moment in
                                VStack {
                                    MomentItemView(vm: MomentItemViewModel(moment: moment, user: authVM.currentUser!), moment: moment)
                                        .frame(height: 350)
                                        .padding(.horizontal, 15)
                                        .padding(.bottom, 20)
                                    Divider()
                                }
                            }
                        }
                        
                    }
                    .padding(.top)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Me")
                                .screenTitle()
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                meVM.isShowingDialog = true
                            } label: {
                                Image("edit-profile-icon")
                            }
                        }
                    }
                    .listStyle(.inset)
                    .sheet(isPresented: $meVM.showPhotoPicker) {
                        PhotoPicker(isPresented: $meVM.showPhotoPicker, selectedImages: $meVM.selectedImages, selectionLimit: 1)
                    }
                }
                
                if (meVM.isShowingDialog) {
                    ZStack {
                        Rectangle()
                            .fill(.black.opacity(0.5))
                            .ignoresSafeArea()
                        
                        ScrollView {
                            VStack(spacing: 32) {
                                MaterialTextField(placeholder: "Name", text: $meVM.nameValue)
                                
                                DatePicker("Date of Birth", selection: $meVM.dobValue, displayedComponents: .date)
                                    .font(.system(size: 15))
                                    .foregroundColor(.colorDarkBlue)
                                
                                Picker("Gender", selection: $meVM.genderValue) {
                                    ForEach(Gender.allCases, id: \.rawValue) { gender in
                                        Text(gender.rawValue)
                                            .tag(gender)
                                    }
                                }
                                .pickerStyle(.segmented)
                                
                                HStack(spacing: 16) {
                                    Button("Cancel") {
                                        meVM.isShowingDialog = false
                                    }
                                    .frame(width: 100, height: 48)
                                    .wcSecondaryButton()
                                    
                                    Button("Save") {
                                        meVM.isShowingDialog = false
                                        meVM.onTapSave()
                                    }
                                    .frame(width: 100, height: 48)
                                    .wcPrimaryButton()
                                }
                                
                            }
                            .padding(.horizontal)
                            .padding(.top, 32)
                            .padding(.bottom, 16)
                        }
                        .background(.white)
                        .frame(width: UIScreen.main.bounds.width - 56, height: UIScreen.main.bounds.height / 2.5)
                        .cornerRadius(8)
                    }
                }
                
                if (meVM.showQRCodeDialog) {
                    ZStack {
                        Rectangle()
                            .fill(.black.opacity(0.5))
                            .ignoresSafeArea()
                            .onTapGesture {
                                meVM.showQRCodeDialog = false
                            }
                        
                        Image(uiImage: meVM.qrCodeImage)
                            .resizable()
                            .interpolation(.none)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.width - 32)
                        
                    }
                }
            }
        }
    }
}

struct MeScreen_Previews: PreviewProvider {
    static var previews: some View {
        MeScreen()
            .environmentObject(MockDataViewModel())
    }
}
