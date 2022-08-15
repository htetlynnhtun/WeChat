//
//  ScannerPreview.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI
import AVFoundation
import PhotosUI

struct ScannerPreview: UIViewRepresentable {
    @ObservedObject var scannerModel: ScannerModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        scannerModel.preview = AVCaptureVideoPreviewLayer(session: scannerModel.session)
        scannerModel.preview.frame = view.frame
        scannerModel.preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(scannerModel.preview)
        
//        scannerModel.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class ScannerModel: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var session = AVCaptureSession()
    @Published var isAuthorized = true
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var output = AVCaptureMetadataOutput()
    @Published var scanResult = ""
    
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
            setup()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    DispatchQueue.main.async {
                        self.isAuthorized = true
                        self.setup()
                    }
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
            if let device = device {
                let input = try AVCaptureDeviceInput(device: device)
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    
                    output.setMetadataObjectsDelegate(self, queue: .main)
                    output.metadataObjectTypes = [.qr]
                }
                
                session.commitConfiguration()
                session.startRunning()
            } else {
                print("Running on simulator, so no camera...")
            }
            
        } catch {
            // TODO: handle me
            print(error.localizedDescription)
        }
    }
    
    func scanFromImage(with image: UIImage) {
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
        let ciImage = CIImage(image: image)!
        var decodedString = ""
        let features = detector.features(in: ciImage)
        
        for feature in features as! [CIQRCodeFeature] {
            decodedString += feature.messageString!
        }
        
        if decodedString.isEmpty {
            // Fail to decode
        } else {
            scanResult = decodedString
        }
    }
    
    // 1:
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue else {
                return
            }
            // callback is called multiple times. Might be improved
            scanResult = stringValue
        }
    }
}
