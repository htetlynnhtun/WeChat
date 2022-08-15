//
//  MaterialTextField.swift
//  WeChat
//
//  Created by kira on 30/07/2022.
//

import SwiftUI

struct MaterialTextField: View {
    var placeholder: String
    var isSecured = false
    @Binding var text: String
    @FocusState private var isFocused
    @State private var movingUp = false
    
//    init(placeholder: String, isSecured: Bool = false, text: Binding<String>) {
//        self.placeholder = placeholder
//        self.isSecured = isSecured
//        self._text = text
//
//        if self.text.isEmpty {
//            withAnimation(.easeIn(duration: 0.2)) {
//                movingUp = true
//            }
//        }
//    }
    
    var body: some View {
        VStack(spacing: 8) {
            Group {
                if (isSecured) {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }
            .font(.system(size: 16))
            .foregroundColor(.colorPrimary)
            .focused($isFocused)
            .background(alignment: .leading) {
                Text(placeholder)
                    .font(.system(size: 16))
                    .foregroundColor(.colorGray)
                    .offset(x: 0, y: movingUp ? -24 : 0)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.colorPrimary)
            
        }
        .onChange(of: isFocused) { newValue in
            withAnimation(.easeIn(duration: 0.2)) {
                movingUp = !text.isEmpty || newValue
            }
        }
    }
}

struct MaterialTextField_Previews: PreviewProvider {
    static var previews: some View {
        MaterialTextField(placeholder: "Enter Your Phone Number", text: .constant(""))
    }
}
