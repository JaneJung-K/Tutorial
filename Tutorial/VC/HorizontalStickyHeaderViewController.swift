//
//  HorizontalStickyHeaderViewController.swift
//  Tutorial
//
//  Created by imac on 2022/03/23.
//

import UIKit
import HorizontalStickyHeaderLayout

class HorizontalStickyHeaderViewController: UIViewController {
    let colorBackground: [UIColor] = [ .cyan, .red, .blue, .gray, .orange, .cyan, .red, .blue, .gray, .orange
                                    ]
    // 1. collectionview 만들기
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.register(HeaderView.self, forCellWithReuseIdentifier: "headercell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headercell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(500)
        }
    }
    // 2. header 만들기
    // 3. collectionvivew section 나누기
    // 4. section header 만들기
}

extension HorizontalStickyHeaderViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colorBackground[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headercell", for: indexPath) as! HeaderView
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       return CGSize(width: 200, height: 200)
    }
}

class HeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HorizontalStickyHeaderViewController: HorizontalStickyHeaderLayoutDelegate {
    private enum Const {
        static let headerSize = CGSize(width: 100, height: 38)
        static let itemSize0  = CGSize(width: 50, height: 50)
        static let itemSize1  = CGSize(width: 80, height: 80)
        static let headerLeft: CGFloat = 8
    }
    func collectionView(_ collectionView: UICollectionView, hshlSizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if indexPath.section % 2 == 0 {
            return Const.itemSize0
        } else {
            return Const.itemSize1
        }
    }
    func collectionView(_ collectionView: UICollectionView, hshlSizeForHeaderAtSection section: Int) -> CGSize {
        return Const.headerSize
    }
    func collectionView(_ collectionView: UICollectionView, hshlHeaderInsetsAtSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Const.headerLeft, bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, hshlMinSpacingForCellsAtSection section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, hshlSectionInsetsAtSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: section == 4 ? 0 : 20)
    }
}
