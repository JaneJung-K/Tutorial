//
//  QRCodeBaseViewController.swift
//  Tutorial
//
//  Created by Leah on 2022/10/18.
//

import UIKit

class QRCodeBaseViewController: UIViewController {
    private lazy var btnQRScan: UIButton = {
        let button = UIButton()
        button.setTitle("QRScan", for: .normal)
        button.titleLabel?.font = Fonts.text14()
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 135, height: 40)
        button.addTarget(self, action: #selector(didTapQRScan), for: .touchUpInside)
        return button
    }()
    
    private lazy var btNew: UIButton = {
        let button = UIButton()
        button.setTitle("NewQRScan", for: .normal)
        button.titleLabel?.font = Fonts.text14()
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 135, height: 40)
        button.addTarget(self, action: #selector(didTapNewQRScan), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(btnQRScan)
        view.addSubview(btNew)
        
        btnQRScan.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        btNew.snp.makeConstraints { make in
            make.top.equalTo(btnQRScan.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
      
    }
    
    @objc func didTapQRScan() {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "QRCodeScanView") as! QRCodeScanViewController
        viewController.modalPresentationStyle = .fullScreen
        present(viewController,animated: false)
        
        viewController.messageText = "영수증 하단의 바코드를 인식해주세요."
        viewController.initialView()
        
        viewController.qrScanningSuccess = { value in
//            print("QRScanFuncName : \(funcName), value : \(value)", classStr: #file, line: #line)
//            webView.evaluateJavaScript("\(funcName)('\(value)');", completionHandler: nil)
            print(value)
            
        }
    }
    
    @objc func didTapNewQRScan() {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewQRScanViewController") as! NewQRScanViewController
        viewController.modalPresentationStyle = .fullScreen
        present(viewController,animated: false)
    }
}
