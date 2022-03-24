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
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize = CGSize(width: 300, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
            make.height.equalTo(250)
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colorBackground[indexPath.row]
        if indexPath.row == 3 {
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headercell", for: indexPath) as! HeaderView
        let title:[String] = ["첫번째", "두번째", "세번째"]
        headerView.configure(text: title[indexPath[0]])
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: -200, bottom: 0, right: 0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 3 {
//            return CGSize(width: 16, height: 200)
//        }
//        return CGSize(width: 300, height: 200)
//    }
}

class HeaderView: UICollectionReusableView {
    private lazy var lblTitle: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubview(lblTitle)
        lblTitle.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String) {
        lblTitle.text = text
    }
    
    
}

