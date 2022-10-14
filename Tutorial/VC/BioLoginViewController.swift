//
//  BioLoginViewController.swift
//  Tutorial
//
//  Created by Leah on 2022/10/15.
//

import UIKit
import LocalAuthentication

class BioLoginViewController: UIViewController {
    private lazy var btnBioLogin: UIButton = {
        let button = UIButton()
        button.setTitle("BioLogin", for: .normal)
        button.titleLabel?.font = Fonts.text14()
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 135, height: 40)
        button.addTarget(self, action: #selector(didTapBioLogin), for: .touchUpInside)
        return button
    }()
    
    let authContext = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(btnBioLogin)
        
        btnBioLogin.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc func didTapBioLogin() {
        if self.canEvaluatePolicy() {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "인증해야지") { (success, error) in
                print("인증결과", success, error)
            }
        }
        
    }
    
    func canEvaluatePolicy() -> Bool {
        let can = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return can
    }
    
    enum BiometryType {
        case faceId
        case touchId
        case none
    }
    
    func getBiometryType() -> BiometryType {
        switch authContext.biometryType {
        case .faceID:
            return .faceId
        case .touchID:
            return .touchId
        default:
            return .none
        }
    }
}
