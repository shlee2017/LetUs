//
//  ViewController.swift
//  LetUs
//
//  Created by Sangheon Lee on 2/1/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet var qrScan: UIView!
    
    var stringUrl = String()
    
    enum error: Error {
        case noCamera
        case scanFail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try scanQRCode()
        } catch {
            print("Failed to scan the QR/Barcode.")
        }
    }

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects:[Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                stringUrl = machineReadableCode.stringValue!
                performSegue(withIdentifier: "ScannedUI", sender: self)
            }
        }
    }
    
    func scanQRCode() throws {
        let avCaptureSession = AVCaptureSession()
        
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
            else {
            print("No Camera")
            throw error.noCamera
            
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice)
            else {
                print("Fail to init camera")
                throw error.scanFail
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = qrScan.bounds
        
        self.qrScan.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        avCaptureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScannedUI" {
            let destination = segue.destination as! WebViewController
            destination.url = URL(string: stringUrl)
        }
    }
}

