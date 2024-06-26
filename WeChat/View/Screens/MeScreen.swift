//
//  MeScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI
import CachedAsyncImage

struct MeScreen: View {
    @EnvironmentObject var mockData: MockDataViewModel
    @State private var isShowingDialog = false
    @State private var nameValue = ""
    @State private var phoneValue = ""
    @State private var dobValue = Date.now
    @State private var genderValue = Gender.male
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    HStack {
                        ZStack {
                            CachedAsyncImage(url: URL(string: "https://i.pravatar.cc/150?u=a042581f4e29026704d")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(Circle())
                            
                            Rectangle()
                                .fill(.white)
                                .frame(width: 48, height: 48)
                                .offset(x: 34, y: 36)
                            
                            Button {
                                
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
                            Text("Phyo Zeyar")
                                .font(.system(size: 20))
                            
                            HStack {
                                Image(systemName: "iphone.homebutton")
                                
                                Text("09 1234 56789 ")
                                    .font(.system(size: 14))
                            }
                            
                            HStack {
                                Image(systemName: "calendar")
                                
                                Text("09 1234 56789 ")
                                    .font(.system(size: 14))
                            }
                            
                            HStack {
                                Image(systemName: "arrow.triangle.branch")
                                
                                Text("09 1234 56789 ")
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
                    
                    ForEach(mockData.moments) { moment in
                        VStack {
                            MomentItemView(moment: moment)
                                .frame(height: 350)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 20)
                            Divider()
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
                            isShowingDialog = true
                        } label: {
                            Image("edit-profile-icon")
                        }
                    }
                }
                .listStyle(.inset)
            }
            
            if (isShowingDialog) {
                ZStack {
                    Rectangle()
                        .fill(.black.opacity(0.5))
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 32) {
                            MaterialTextField(placeholder: "Name", text: $nameValue)
                            
                            MaterialTextField(placeholder: "Name", text: $phoneValue)
                            
                            DatePicker("Date of Birth", selection: $dobValue, displayedComponents: .date)
                                .font(.system(size: 15))
                                .foregroundColor(.colorDarkBlue)
                            
                            Picker("Gender", selection: $genderValue) {
                                ForEach(Gender.allCases, id: \.rawValue) { gender in
                                    Text(gender.rawValue)
                                        .tag(gender)
                                }
                            }
                            .pickerStyle(.segmented)
                            
                            HStack(spacing: 16) {
                                Button("Cancel") {
                                    isShowingDialog = false
                                }
                                .frame(width: 100, height: 48)
                                .wcSecondaryButton()

                                Button("Save") {
                                    
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
        }
    }
}

struct MeScreen_Previews: PreviewProvider {
    static var previews: some View {
        MeScreen()
            .environmentObject(MockDataViewModel())
    }
}
