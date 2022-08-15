//
//  ContactGroupView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct ContactGroupView: View {
    @State private var showAddNewGroup = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Groups(5)")
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.colorPrimary)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Button {
                        showAddNewGroup = true
                    } label: {
                        VStack {
                            Image("add-people-icon")
                            Text("Add New")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                        }
                    }
                    .frame(width: 90, height: 90)
                    .background(Color.colorPrimary)
                    .cornerRadius(5)
                    .padding(.leading)
                    
                    ForEach(0..<5) { i in
                        ContactGroupItemView()
                    }
                }
                .padding(.bottom)
            }
        }
        .fullScreenCover(isPresented: $showAddNewGroup) {
            NavigationView {
                AddNewGroupScreen()
                    .navigationTitle("New Group")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                showAddNewGroup = false
                            } label: {
                                Image(systemName: "multiply")
                                    .foregroundColor(.colorPrimary)
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print("Create")
                            } label: {
                                Text("Create")
                            }
                            .padding(.trailing, 8)
                            .frame(width: 70, height: 32)
                            .wcPrimaryButton()
                        }
                    }
            }
            
        }
    }
}
