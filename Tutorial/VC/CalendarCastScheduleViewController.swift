//
//  CalendarCastScheduleViewController.swift
//  charancha
//
//  Created by Leah on 2021/10/14.
//

import UIKit

class CalendarCastScheduleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "친환경 고효율 하이브리드 전기차 특집"
        label.font = Fonts.text16()
        return label
    }()
    
    private lazy var btnCancel: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width-36, height: 97)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarCastScheduleCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCastScheduleCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(btnCancel)
        view.addSubview(collectionView)
        view.layer.cornerRadius = 16
        
        btnCancel.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        btnCancel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCastScheduleCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }
    
}

class CalendarCastScheduleCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCastScheduleCollectionViewCell"
    
}

// MARK: - UIPresentationController

class PresentationController: UIPresentationController {
    
    let dimmingView: UIVisualEffectView = {
        var view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let dummyView = UIView()
 
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView else { fatalError() }
        
        containerView.insertSubview(dimmingView, at: 0)
        containerView.addSubview(dummyView)
        
        dimmingView.frame = containerView.frame
        dimmingView.alpha = 0.0
        dummyView.frame = dimmingView.frame
        
        containerView.layoutIfNeeded()
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            return
        }
        coordinator.animate(alongsideTransition: { (animation) in
            self.dimmingView.alpha = 1.0
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        guard let coordinator = presentingViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            presentingViewController.view.transform = CGAffineTransform.identity
            containerView?.layoutIfNeeded()
            return
        }
        coordinator.animate(alongsideTransition: { (animator) in
            self.dimmingView.alpha = 0.0
            self.presentingViewController.view.transform = CGAffineTransform.identity
            self.containerView?.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmingView.frame = containerView!.frame
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        presentingViewController.view.transform = CGAffineTransform.identity
        coordinator.animate(alongsideTransition: { (ani) in
            self.presentingViewController.view.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        }, completion: nil)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height*(1/6), width: bounds.width, height: bounds.height*(5/6))
    }
  
}
