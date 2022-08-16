//
//  SettingsScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct SettingScreen: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        Button("Logout") {
            authVM.onTapLogout()
        }
        .frame(width: 132, height: 48)
        .wcPrimaryButton()

    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
