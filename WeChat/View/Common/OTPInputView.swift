//
//  PinStackVIew.swift
//  WeChat
//
//  Created by kira on 30/07/2022.
//

import SwiftUI

struct OTPInputView: View {
    
    @Binding var otpCode: String
    
    @State private var otpInput = ""
    @FocusState private var isFocused
    
    private func getPinNumber(_ index: Int) -> String {
        
        let pin = Array(otpInput)
        
        if pin.indices.contains(index), !String(pin[index]).isEmpty {
            return String(pin[index])
        }
        
        return "_"
    }
    
    var body: some View {
        ZStack {
            backgroundField
            HStack {
                ForEach(0..<4) { i in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .shadow(color: .colorOTPShadow, radius: 2, x: 0, y: 5)

                        Text(getPinNumber(i))
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 21))
                    .foregroundColor(.colorPrimary)
                    .frame(width: 45, height: 45)
                }
            }
            .onTapGesture {
                isFocused = true
            }
            
        }
        .frame(height: 50)
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.otpInput }, set: { newValue in
            otpInput = newValue
            
            if otpInput.count == 4 {
                isFocused = false
                otpCode = otpInput
            }
            
        })
        
        return TextField("", text: boundPin)
            .focused($isFocused)
            .keyboardType(.numberPad)
            .overlay(.white)
    }
}

struct PinStackView_Previews: PreviewProvider {
    static var previews: some View {
        OTPInputView(otpCode: .constant(""))
        .previewLayout(.sizeThatFits)
    }
}
