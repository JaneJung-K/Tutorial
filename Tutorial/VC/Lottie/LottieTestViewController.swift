//
//  LottieTestViewController.swift
//  Tutorial
//
//  Created by imac on 2022/03/15.
//

import UIKit
import Lottie

class LottieTestViewController: UIViewController {

    private lazy var viewBackground: UIView = {
       let view = UIView()
        return view
    }()
    
    private lazy var testLottieView = LottieAniView()
    
    let loadURL = "https://assets10.lottiefiles.com/packages/lf20_g5lcqnay.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLottieView.setAnimationURL(url: loadURL)

        view.addSubview(viewBackground)
        viewBackground.addSubview(testLottieView)
        viewBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        testLottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        testLottieView.play()
    }

}

class LottieAniView: UIView {
     var animationView = AnimationView(name: "Lottie")
    
     override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setAnimationView(name: String, loop: Bool = true) {
        animationView = AnimationView(name: name)
        self.addSubview(animationView)
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.loopMode = loop ? .loop : .playOnce
    }
    
     func setAnimationURL(url: String, loop: Bool = true) {
         Animation.loadedFrom(
            url: URL(string:url)!,
            closure: { [weak self] (animation) in
             self?.animationView.animation = animation
             self?.animationView.play()
         },
            animationCache: LRUAnimationCache.sharedCache
         )
        self.addSubview(animationView)
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.loopMode = loop ? .loop : .playOnce
    }
    
     func aspectRatio() -> CGFloat {
        return (animationView.animation?.bounds.size.width ?? 0) / (animationView.animation?.bounds.size.height ?? 1)
    }
    
    override func updateConstraints() {
        
        animationView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
        super.updateConstraints()
    }
    
     func play() {
        if !animationView.isAnimationPlaying {
            animationView.play()
        }
    }
    
     func playAndCompletion() {
        if !animationView.isAnimationPlaying {
            animationView.play(fromProgress: 0.0, toProgress: 1, completion: { (complete: Bool) in
                NotificationCenter.default.post(name: Notification.Name("NOTI_LOTTI_BANNER_INVISIBLE"), object:nil, userInfo: nil)
            })
        }
    }
     func stop() {
        if animationView.isAnimationPlaying {
            animationView.stop()
        }
    }
    
    
    
}
