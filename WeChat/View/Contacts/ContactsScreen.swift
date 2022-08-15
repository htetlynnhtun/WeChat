//
//  ContactsScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct ContactsScreen: View {
    @State private var searchValue = ""
    @EnvironmentObject private var mockData: MockDataViewModel
    @ObservedObject private var vm: ContactsViewModel
    
    init(vm: ContactsViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchContactView(searchValue: $searchValue)
                    .padding(.top, 8)
                    .padding(.horizontal)
                
                ContactGroupView()
                
                //                    VStack {
                //                        Image("no-contacts-background")
                //                            .resizable()
                //                            .aspectRatio(contentMode: .fit)
                //                            .frame(height: 166)
                //
                //                        Text("No contact or group with name")
                //                        Text(" “Aung Naing” exits")
                //                    }
                //                    .frame(maxWidth: .infinity)
                
                
                ScrollViewReader { reader in
                    ZStack(alignment: .trailing) {
                        ScrollView(showsIndicators: false) {
                            ContactSectionView(sectionTitle: "Favorites(\(vm.favorites.count))", users: vm.favorites)
                                .id("fav")
                                .padding(4)
                            
                            ForEach(Array(vm.contacts.keys.sorted()), id: \.self) { value in
                                ContactSectionView(sectionTitle: value, users: vm.contacts[value]!)
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
                            
                            ForEach(vm.alphabets, id: \.self) { value in
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
            
        }
    }
}

struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen(vm: .forPreivew())
    }
}






