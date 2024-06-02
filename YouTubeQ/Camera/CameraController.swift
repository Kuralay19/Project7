//
//  CameraController.swift
//  YouTubeQUITests
//
//  Created by Smart Castle M1A2004 on 02.03.2024.
//

import UIKit
import SnapKit
import AVFoundation
class CameraController: UIViewController {
    let output = AVCapturePhotoOutput()
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "right_arrow_shadow")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    lazy var capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "capture_photo")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupSignals()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func setupLayouts() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
        
//        view.addSubview(dismissButton)
//        dismissButton.snp.makeConstraints { make in
//            make.topMargin.equalToSuperview()
//            make.right.equalToSuperview().offset(-16)
//            make.size.equalTo(50)
//        }
            view.addSubview(capturePhotoButton)
        capturePhotoButton.snp.makeConstraints { make in
            make.bottomMargin.centerX.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
            
        }
            }
    func setupSignals() {
        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        capturePhotoButton.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
    }
    @objc func handleDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleCapturePhoto() {
        print("Capturing photo.. ")
        let setting = AVCapturePhotoSettings()
        guard let previewFormatType = setting.availablePreviewPhotoPixelFormatTypes.first else {return}
        setting.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey: previewFormatType] as [String : Any]
        output.capturePhoto(with: setting, delegate: self)
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
        
    }
extension CameraController: AVCapturePhotoCaptureDelegate {
    func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let error {
            print("Erron in camera settings", error)
        }
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        DispatchQueue.global(qos: .background).async {
            captureSession.startRunning()
        }
    
        
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            print("Ошибка в процессе фото", error!)
            return
        }
        guard let imageData  = photo.fileDataRepresentation() else { return }
        let previewImage = UIImage(data: imageData)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "captureNewPhoto"), object: previewImage)
        self.navigationController?.popViewController(animated: true)
        
        self.tabBarController?.selectedIndex = 2
        self.tabBarController?.tabBar.isHidden = false

    }
}
