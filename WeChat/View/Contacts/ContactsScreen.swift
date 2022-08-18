//
//  ContactsScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct ContactsScreen: View {
    @EnvironmentObject private var mockData: MockDataViewModel
    
    @EnvironmentObject var contactVM: ContactViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchContactView(searchValue: $contactVM.searchKeyword)
                    .padding(.top, 8)
                    .padding(.horizontal)
                
                ContactGroupView()
                
                if (contactVM.searchKeyword.isNotEmpty && contactVM.contacts.isEmpty) {
                    VStack {
                        Image("no-contacts-background")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 166)
                        
                        Text("No contact or group with name")
                        Text(" “\(contactVM.searchKeyword)” exits")
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
              
                
                if (!contactVM.contacts.isEmpty) {
                    ScrollViewReader { reader in
                    ZStack(alignment: .trailing) {
                        ScrollView(showsIndicators: false) {
//                            ContactSectionView(sectionTitle: "Favorites(\(vm.favorites.count))", users: vm.favorites)
//                                .id("fav")
//                                .padding(4)
//
                            ForEach(Array(contactVM.contacts.keys.sorted()), id: \.self) { value in
                                ContactSectionView(sectionTitle: value, users: contactVM.contacts[value]!)
                                    .id(value)
                                .padding(4)
                            }
                        }
                        
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
                    .padding(.horizontal)
                }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Contacts")
                        .screenTitle()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewContactScreen()
                    } label: {
                        Image("new-contact-icon")
                    }
                }
            }
            .listStyle(.inset)
            .toast(message: contactVM.toastMessage, isShowing: $contactVM.showToastMessage, duration: Toast.short)
            
        }
        .onAppear {
            contactVM.fetchContacts()
            contactVM.fetchGroups()
        }
    }
}

struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
    }
}






