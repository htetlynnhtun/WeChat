//
//  SearchContactView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct SearchContactView: View {
    @Binding var searchValue: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.colorPrimary)
            
            TextField("", text: $searchValue)
                .placeholder(when: searchValue.isEmpty) {
                    Text("Search")
                        .foregroundColor(.colorPrimary.opacity(0.5))
                }
            
            Spacer()
            
            Button {
                searchValue = ""
            } label: {
                Image(systemName: "multiply")
            }
            .foregroundColor(.colorPrimary)
        }
        .frame(height: 46)
        .padding(.horizontal, 14)
        .background(Color.colorPrimaryVariant.opacity(0.4))
        .cornerRadius(5)
    }
}
