//
//  CameraViewController.swift
//  CustomCamera
//
//  Created by Awesomepia on 1/23/24.
//

import UIKit
import AVFoundation

/*
 Custom Camera
 - SwiftUI, MVVM, Combine
 https://enebin.medium.com/swiftui%EB%A7%8C-%EC%8D%A8%EC%84%9C-%ED%98%B8%EB%8B%A4%EB%8B%A5-%EC%B9%B4%EB%A9%94%EB%9D%BC%EC%95%B1-%EB%A7%8C%EB%93%A4%EA%B8%B0-feat-mvvm-1-2782b457f796
 - Swift, UIKit
 https://hongssup.tistory.com/292
 */
final class CameraViewController: UIViewController {
    
    lazy var captureButton: UIButton = {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 100)
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle.inset.filled", withConfiguration: imageConfiguration), for: .normal)
        button.tintColor = .white
        button.addAction(UIAction(handler: { _ in
            self.cameraModel.capturePhoto()
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var flashButton: UIButton = {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 24)
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "bolt.slash", withConfiguration: imageConfiguration), for: .normal)
        button.tintColor = .white
        button.addAction(UIAction(handler: { _ in
            self.cameraModel.switchFlash()
            
            if self.cameraModel.isFlashOn {
                button.setImage(UIImage(systemName: "bolt", withConfiguration: imageConfiguration), for: .normal)
                
            } else {
                button.setImage(UIImage(systemName: "bolt.slash", withConfiguration: imageConfiguration), for: .normal)
                
            }
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var preview: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let cameraModel = Camera()
    
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.setPreview()
        self.cameraModel.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- CameraViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CameraViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .black
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        self.view.addSubview(self.captureButton)
        self.view.addSubview(self.flashButton)
        self.view.addSubview(self.preview)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // captureButton
        NSLayoutConstraint.activate([
            self.captureButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.captureButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -34),
            self.captureButton.widthAnchor.constraint(equalToConstant: 100),
            self.captureButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // flashButton
        NSLayoutConstraint.activate([
            self.flashButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            self.flashButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            self.flashButton.widthAnchor.constraint(equalToConstant: 24),
            self.flashButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // preview
        NSLayoutConstraint.activate([
            self.preview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.preview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.preview.topAnchor.constraint(equalTo: self.flashButton.bottomAnchor, constant: 20),
            self.preview.bottomAnchor.constraint(equalTo: self.captureButton.topAnchor, constant: -20)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setPreview() {
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.cameraModel.session)
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.preview.bounds
        }
        self.videoPreviewLayer.videoGravity = .resizeAspectFill
        self.preview.layer.addSublayer(self.videoPreviewLayer)
    }
}

// MARK: - Extension for methods added
extension CameraViewController {
    
}

// MARK: - Extension for selector methods
extension CameraViewController {
    
}

protocol EssentialViewMethods {
    func setViewFoundation()
    func initializeObjects()
    func setDelegates()
    func setGestures()
    func setNotificationCenters()
    func setSubviews()
    func setLayouts()
    func setViewAfterTransition()
}

