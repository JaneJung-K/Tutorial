//
//  QRCodeScanViewController.swift
//  LotteGRS
//
//  Created by jihyeon on 01/10/2019.
//  Copyright © 2019 lotteGRS. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScanViewController: UIViewController{
    
//    var completeQRScanDelegate: QRScannerViewDelegate?
    
    @IBOutlet weak var constraintViewHeight: NSLayoutConstraint!
    @IBOutlet weak var captureView: UIView!
  
    @IBOutlet weak var messageLabel: UILabel!
    var messageText: String?
    @IBAction func touchUpCloseView(_ sender: Any) {
         dismiss(animated: false, completion: nil)
    }
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var qrScanningSuccess: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVCaptureDevice.requestAccess(for: .video) { granted in
            
        }
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
     
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = self.metaObjectTypes()
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        captureView.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        constraintViewHeight.constant = UIScreen.main.bounds.width - 30
    }
    
    public func initialView(){
        messageLabel.text = messageText
    
    }
    
    private func metaObjectTypes() -> [AVMetadataObject.ObjectType]{
        return [.qr,
                .code128,
                .code39,
                .code93,
                .code39Mod43,
                .ean13,
                .ean8,
                .interleaved2of5,
                .itf14,
                .pdf417,
                .upce]
    }
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }

    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
   
    
    func found(code: String) {
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
extension QRCodeScanViewController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        
        if let metadataObject = metadataObjects.first {
  
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            self.qrScanningSuccess?(stringValue)
            found(code: stringValue)
        }
       
        dismiss(animated: true)
    }
}
