//
//  WCViewModifiers.swift
//  WeChat
//
//  Created by kira on 19/07/2022.
//

import Foundation
import SwiftUI

struct WCPrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.colorPrimary)
            .foregroundColor(.white)
            .font(.custom("YorkieDEMO-Bold", size: 16))
            .cornerRadius(5)
    }
}

struct WCSecondaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.colorPrimary)
            .font(.custom("YorkieDEMO-Bold", size: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.colorPrimary, lineWidth: 2)
            )
    }
}

struct ScreenTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("YorkieDEMO-Bold", size: 34))
            .foregroundColor(.colorPrimary)
    }
}

extension View {
    func wcPrimaryButton() -> some View {
        modifier(WCPrimaryButtonModifier())
    }
    
    func wcSecondaryButton() -> some View {
        modifier(WCSecondaryButtonModifier())
    }
    
    func screenTitle() -> some View {
        modifier(ScreenTitleModifier())
    }
}
