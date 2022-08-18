//
//  AddNewGroupScreen.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI

struct AddNewGroupScreen: View {
    
    @EnvironmentObject var contactVM: ContactViewModel
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "YorkieDEMO-Medium", size: 24)!,
            .foregroundColor: UIColor(.colorPrimary)
        ]
    }
    
    var body: some View {
        ProgressWrapperView(showActivityIndicator: contactVM.showActivityIndicator) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Group Name")
                    .font(.system(size: 16))
                    .foregroundColor(.colorPrimary)
                    .padding(.horizontal)
                
                TextField("", text: $contactVM.groupName)
                    .textFieldStyle(.plain)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.colorPrimary)
                    }
                    .frame(height: 30)
                    .padding(.horizontal)
                
                SearchContactView(searchValue: $contactVM.searchKeyword)
                    .padding([.horizontal, .top], 16)
                    .padding(.bottom, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 13) {
                        ForEach(contactVM.selectedUsers, id: \.self) { user in
                            SelectedMemberItemView(user: user)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 2)
                }
                
                if (!contactVM.contacts.isEmpty) {
                    ScrollViewReader { reader in
                        ZStack(alignment: .trailing) {
                            ScrollView(showsIndicators: false) {
                                //                    SelectableContactSectionView(sectionTitle: "Favorites(\(vm.favorites.count))", users: vm.favorites)
                                //                        .padding(4)
                                
                                ForEach(Array(contactVM.contacts.keys.sorted()), id: \.self) { value in
                                    SelectableContactSectionView(sectionTitle: value, users: contactVM.contacts[value]!)
                                }
                                .padding(4)
                            }
                            .padding([.horizontal, .top], 16)
                            
                            VStack(spacing: 6) {
                                Button {
                                    withAnimation {
                                        reader.scrollTo("fav")
                                    }
                                } label: {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 10))
                                        .foregroundColor(.green)
                                }
                                
                                ForEach(contactVM.alphabets, id: \.self) { value in
                                    Button {
                                        withAnimation {
                                            reader.scrollTo(value)
                                        }
                                    } label: {
                                        Text(value)
                                            .font(.system(size: 10))
                                    }
                                }
                            }
                            .padding(4)
                            .background {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                                    .shadow(color: Color.gray.opacity(0.5), radius: 1, x: 1, y: 0)
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

struct AddNewGroupScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGroupScreen()
    }
}
