//
//  DynamicCollectionView.swift
//  Tutorial
//
//  Created by Leah on 2021/12/07.
//

import UIKit
import SnapKit

struct Message {
    var nick: String
    var text: String
}

final class DynamicCollectionViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 3
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()
    
var items: [Message] = [
                        Message(nick: "찌리릿차", text: "포르쉐는 911이지"),
                        Message(nick: "베이지", text: "억~~~~~"),
                        Message(nick: "포르쉐사자", text: "예약하고 가면 여성딜러분이 차 보여주시나요? 무서운남자 아닌데요요용"),
                        Message(nick: "얍얍얍", text: "지짜 대박이다..."),
                        Message(nick: "차란차별", text: "포르쉐는 카이엔..별"),
                        Message(nick: "월간차", text: "이사님 여깁니다!!!"),
                        Message(nick: "rlagusals", text: "30키로 탔는데 신차값보다 많이 떨어졌네요 살만하네요"),
                        Message(nick: "월간차", text: "AMG 곳곳에서 존재감 뿜내는 거 보소"),
                        Message(nick: "대한시연만세", text: "오")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}

extension DynamicCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(model: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionViewCell.fittingSize(availableWidth: 276, model: items[indexPath.item])
    }
    
}
