//
//  AddNewGroupScreen.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI

struct AddNewGroupScreen: View {
    @ObservedObject var vm = ContactsViewModel(currentUser: MockDataViewModel().currentUser)
    @State private var groupName = ""
    @State private var searchValue = ""
    @State private var selected = [UserVOD]()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "YorkieDEMO-Medium", size: 24)!,
            .foregroundColor: UIColor(.colorPrimary)
        ]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Group Name")
                .font(.system(size: 16))
                .foregroundColor(.colorPrimary)
                .padding(.horizontal)
            
            TextField("", text: $groupName)
                .textFieldStyle(.plain)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.colorPrimary)
                }
                .frame(height: 30)
                .padding(.horizontal)
            
            SearchContactView(searchValue: $searchValue)
                .padding([.horizontal, .top], 16)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 13) {
                    SelectedMemberItemView()
                    SelectedMemberItemView()
                    SelectedMemberItemView()
                    SelectedMemberItemView()
                    SelectedMemberItemView()
                    SelectedMemberItemView()
                    SelectedMemberItemView()
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 2)
            }
            
            ScrollView(showsIndicators: false) {
                SelectableContactSectionView(sectionTitle: "Favorites(\(vm.favorites.count))", users: vm.favorites)
                    .padding(4)
                
                ForEach(Array(vm.contacts.keys.sorted()), id: \.self) { value in
                    SelectableContactSectionView(sectionTitle: value, users: vm.contacts[value]!)
                }
                .padding(4)
            }
            .padding([.horizontal, .top], 16)
        }
    }
}

struct AddNewGroupScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGroupScreen()
    }
}
