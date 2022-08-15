//
//  TempScreen.swift
//  WeChat
//
//  Created by kira on 02/08/2022.
//

import SwiftUI
import AVFoundation


struct WCCameraScreen: View {
    var body: some View {
        CameraView()
    }
}

struct WCCameraScreen_Previews: PreviewProvider {
    static var previews: some View {
        WCCameraScreen()
    }
}

struct CameraView: View {
    @StateObject private var cameraModel = CamearModel()
    
    var body: some View {
        ZStack {
            CameraPreview(camera: cameraModel)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                if cameraModel.isTaken {
                    HStack {
                        Spacer()
                        
                        Button {
                            cameraModel.retake()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    if cameraModel.isTaken {
                        Button {
                            /*
                             Instead of saving, send image data to firebase
                             So getting data is may be enough
                             */
                            if !cameraModel.isSaved {
                                cameraModel.savePic()
                            }
                        } label: {
                            // Send to firebase and dismiss
                            Text(cameraModel.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(.white)
                                .clipShape(Capsule())
                        }
                        .padding(.leading)
                        
                        Spacer()
                    } else {
                        Button {
                            cameraModel.takePic()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                        
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear {
            cameraModel.check()
        }
    }
}

class CamearModel: NSObject, AVCapturePhotoCaptureDelegate, ObservableObject {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var isAuthorized = true
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
            setup()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.isAuthorized = true
                    self.setup()
                }
            }
        case .denied:
            isAuthorized = false
            return
        default:
            return
        }
    }
    
    func setup() {
        do {
            session.beginConfiguration()
            let device = AVCaptureDevice.default(for: .video)
            // Failing on simulator cause device is nil
            let input = try AVCaptureDeviceInput(device: device!)
            
            if session.canAddInput(input) {
                session.addInput(input)
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            session.commitConfiguration()
        } catch {
            // TODO: handle me
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    self.session.stopRunning()
                }
            }
//            self.session.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken = true
                }
            }
        }
    }
    
    func retake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                self.isTaken = false
                self.isSaved = false
            }
        }
    }
    
    func savePic() {
        // error
        let image = UIImage(data: picData)!
        print(picData)
        // Got pic data here, can be send to firebase
        
//        UIImageWriteToSavedPhotosAlbum(image, .none, .none, .none)
        
        isSaved = true
        print("Saved pic successfully...")
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        
        print("Pic taken...")
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        self.picData = imageData
        
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CamearModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
