//
//  ContactGroupView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct ContactGroupView: View {
    
    @EnvironmentObject var contactVM: ContactViewModel
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Groups(\(contactVM.groups.count))")
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.colorPrimary)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Button {
                        contactVM.onTapAddNewGroup()
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
                    
                    ForEach(contactVM.groups, id: \.id) { group in
                        ContactGroupItemView(group: group)
                    }
                }
                .padding(.bottom)
            }
        }
        .fullScreenCover(isPresented: $contactVM.showAddNewGroup) {
            NavigationView {
                AddNewGroupScreen()
                    .navigationTitle("New Group")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                contactVM.onDismissAddNewGroup()
                            } label: {
                                Image(systemName: "multiply")
                                    .foregroundColor(.colorPrimary)
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                contactVM.createNewGroup()
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
