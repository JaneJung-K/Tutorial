//
//  ProgressViewWithPanGestureViewController.swift
//  Tutorial
//
//  Created by Leah on 2021/12/06.
//

import UIKit

class ProgressViewWithPanGestureViewController: UIViewController {
    var isVolume: Bool = false
    
    let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.5
        progress.progressTintColor = .yellow
        progress.trackTintColor = .clear
        progress.progressViewStyle = .bar
        progress.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progress.isHidden = true
        return progress
    }()
    
    let progressView2: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.5
        progress.progressTintColor = .white
        progress.trackTintColor = .clear
        progress.progressViewStyle = .bar
        progress.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progress.isHidden = true
        return progress
    }()
    
    let touchArea: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan.withAlphaComponent(0.5)
        return view
    }()
    
    let labelVolume: UILabel = {
       let label = UILabel()
        label.text = "50"
        return label
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupGesture()
        setupViews()

    }
    
    private func setupViews() {
        view.addSubview(progressView)
        view.addSubview(progressView2)
        view.addSubview(touchArea)
        view.addSubview(labelVolume)
        
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(view.frame.width/4)
            make.centerY.equalToSuperview()
            make.width.equalTo(view.frame.height)
            make.height.equalTo(view.frame.width/2)
        }
        progressView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-view.frame.width/4)
            make.centerY.equalToSuperview()
            make.width.equalTo(view.frame.height)
            make.height.equalTo(view.frame.width/2)
        }
        touchArea.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(200)
            make.left.right.equalToSuperview()
        }
        labelVolume.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

    }



}

extension ProgressViewWithPanGestureViewController: UIGestureRecognizerDelegate {
    
    func setupGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        touchArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        var locationPoint: CGPoint
        
        switch sender.state {
        case .began:
            locationPoint = sender.location(in: touchArea)
            // 왼쪽은 밝기 bar 오른쪽은 볼륨 bar
            if locationPoint.x > touchArea.bounds.size.width / 2 {
                progressView.isHidden = false
                isVolume = true
            }
            else {
                progressView2.isHidden = false
                isVolume = false
            }
            
            
        case .changed:
            if isVolume {
                let yTranslation = sender.translation(in: touchArea).y

                let tolerance: CGFloat = 5

                if abs(yTranslation) >= tolerance {
                    //progress 0~1 사이이기 때문에 변경해준다.
                    let newValue = progressView.progress - Float((yTranslation / tolerance)/100)
                    
                    //볼륨 적용 및 label text에 들어갈 int값도 필요하다.
                    let intA = Int(newValue * 100)
                    
                    progressView.setProgress(newValue, animated: true)
                    labelVolume.text = String(intA)

                    sender.setTranslation(.zero, in: touchArea)
                }
            }
            else {
                
            }
        case .ended:
            if isVolume {
                progressView.isHidden = true
            }
            else {
                
                progressView2.isHidden = true
            }
           
        case .cancelled:
            break
        case .possible:
            break
        case .failed:
            break
        @unknown default:
            break
        }
    }
}
