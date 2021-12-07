//
//  DynamicCollectionView.swift
//  Tutorial
//
//  Created by Leah on 2021/12/07.
//

import UIKit
import SnapKit

final class DynamicCollectionViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return collectionView
    }()
    
    private let items: [String] = [
        "안녕하세요 좋은 저녁입니다. 곧 있으면 퇴근을 할 수 있으니 너무 좋습니다. ",
        "지금은 크리스마스를 앞두고 있습니다. 연말 분위기가 물씬나서 거리를 걷던 지하철 역을 가던 어디서든 크리스마스 트리를 볼 수 있습니다.",
        "새로운 일을 시작하는 건 언제나 설레입니다. 잘될지 안될지 예측할 수 없고 함께하는 구성원 모두 알게 된지 얼마 되지 않았지만 다 같이 으쌰으쌰 해보겠습니다."
       
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
            make.left.right.equalToSuperview()
        }
    }
    
}

extension DynamicCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(name: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionViewCell.fittingSize(availableWidth: view.frame.width-20, name: items[indexPath.item])
    }
    
}
