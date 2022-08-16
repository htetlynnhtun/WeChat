//
//  MomentScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct MomentScreen: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var vm: MomentViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(vm.moments) { moment in
                    VStack {
                        MomentItemView(vm: MomentItemViewModel(moment: moment, user: authVM.currentUser!), moment: moment)
                            .frame(height: 350)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 20)
                        Divider()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Moments")
                        .font(.custom("YorkieDEMO-Bold", size: 34))
                        .foregroundColor(.colorPrimary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.isPresentingNewMoment = true
                        vm.onViewAddNewMomentScreen()
                    } label: {
                        Image("new-moment")
                            .frame(width: 35, height: 35)
                    }
                }
            }
            .fullScreenCover(isPresented: $vm.isPresentingNewMoment) {
                NavigationView {
                    AddNewMomentScreen()
                }
            }
            
        }
    }
}

struct MomentScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone SE (3rd generation)"], id: \.self) { deviceName in
            MomentScreen()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
