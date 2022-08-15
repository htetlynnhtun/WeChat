//
//  AddNewContactScreen.swift
//  WeChat
//
//  Created by kira on 20/07/2022.
//

import SwiftUI
import Introspect

struct AddNewContactScreen: View {
    
    @State var anyTabBarController: UITabBarController?
    @StateObject private var scannerModel = ScannerModel()
    @State private var isShowingPhotoPicker = false
    @State private var selectedUIImages = [UIImage]()

    
    var body: some View {
        ZStack {
            // For temporary background, remove this
            Color.black
            
            ScannerPreview(scannerModel: scannerModel)
                .ignoresSafeArea(.all, edges: .all)
            
            if !scannerModel.isAuthorized {
                Text("Need camera access to scan...")
            }
            
            VStack {
                Button {
                    
                } label: {
                    VStack(spacing: 5) {
                        Text("Tap to Scan lll")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                        
                        Text("Scan the QR code to add your frined in contact.")
                            .font(.system(size: 14))
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .frame(width: UIScreen.main.bounds.width - 96)

                Spacer()
                
                Button {
                    isShowingPhotoPicker = true
                } label: {
                    HStack {
                        Image(systemName: "photo")
                        
                        Text("Select Image for QR Scan")
                            .font(.system(size: 14))
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .padding(.vertical)
        }
        .sheet(isPresented: $isShowingPhotoPicker, content: {
            PhotoPicker(isPresented: $isShowingPhotoPicker, selectedImages: $selectedUIImages, selectionLimit: 1)
        })
        .onChange(of: selectedUIImages) { newValue in
            if let image = newValue.last {
                print("User picked an image...")
                /*
                 - This image may not contain qr code
                 - So, handle failure
                 - If any error, let user know
                 */
                scannerModel.scanFromImage(with: image)
                selectedUIImages = []
            }
        }
        .onChange(of: scannerModel.scanResult, perform: { newValue in
            /*
             onChange run only once...
             
             */
            print("scan result: \(newValue)")
        })
        .onAppear {
            scannerModel.check()
        }

        .introspectTabBarController { tabBarController in
            tabBarController.tabBar.isHidden = true
            anyTabBarController = tabBarController
        }.onDisappear{
            anyTabBarController?.tabBar.isHidden = false
        }
    }
}

struct AddNewContactScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewContactScreen()
    }
}
