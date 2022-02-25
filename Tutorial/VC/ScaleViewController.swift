//
//  TableViewController.swift
//  CarouselExample
//
//  Created by 정혜영 on 2021/09/30.
//
import SnapKit
import UIKit

class ScaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.identifier)
        
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    private var cell = FirstTableViewCell()
    
    private let gradient = CAGradientLayer()
    
    private var _button: UIButton = {
        let button = UIButton()
        button.setTitle("방송보기", for: .normal)
        button.titleLabel?.font = Fonts.text14()
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 135, height: 40)
        button.addTarget(self, action: #selector(didTapWatch), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = _button.bounds
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        view.addSubview(tableView)
        view.addSubview(_button)

        _button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(112)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(90)
            make.width.equalTo(135)
            make.height.equalTo(40)
        }

        _button.layer.insertSublayer(gradient, at: 0)
    }
    
    @objc func didTapWatch() {
        let vc = TutorialTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cell.collectionView1.scrollToItem(at: IndexPath(item: 5, section: 0), at: .centeredHorizontally, animated: false)
        cell.collectionView2.scrollToItem(at: IndexPath(item: 5, section: 0), at: .centeredHorizontally, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as! FirstTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - FirstTableViewCell

class FirstTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "FirstTableViewCell"
    
    var collectionView1: UICollectionView!
    var collectionView2: UICollectionView!
    
    let data1: [UIColor] = [.blue, .gray, .brown, .cyan, .green]
    let data2: [UIColor] = [.systemPink, .orange, .darkGray, .purple, .systemYellow]
    
    private lazy var increasedData1: [UIColor] = {
        data1 + data1 + data1
    }()
    
    private lazy var increasedData2: [UIColor] = {
        data2 + data2 + data2
    }()
    
    private var originalDataSouceCount: Int {
        data1.count
    }
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    private var image: UIImageView {
        let image = UIImageView()
        image.backgroundColor = .red
        return image
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCollectionView1()
        setUpCollectionView2()
    }
    
    func setUpCollectionView1() {
        let layout = CustomFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
        collectionView1.isPagingEnabled = false
        
        collectionView1.register(CollectionView1Cell.self, forCellWithReuseIdentifier: CollectionView1Cell.identifier)
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        contentView.addSubview(collectionView1)
        
        self.collectionView1 = collectionView1
        
        collectionView1.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
    }
    
    func setUpCollectionView2() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
        
        collectionView2.register(CollectionView2Cell.self, forCellWithReuseIdentifier: CollectionView2Cell.identifier)
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        contentView.addSubview(collectionView2)
        
        self.collectionView2 = collectionView2
        
        collectionView2.snp.makeConstraints { make in
            make.top.equalTo(collectionView1.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return increasedData1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionView1Cell.identifier, for: indexPath) as? CollectionView1Cell else {
                return UICollectionViewCell()
            }
            
            cell.backgroundColor = increasedData1[indexPath.row]
            cell.layer.cornerRadius = 16
            return cell
        }
        else if collectionView == collectionView2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionView2Cell.identifier, for: indexPath) as? CollectionView2Cell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = increasedData2[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView1 {
        return CGSize(width: contentView.frame.width-130, height: 300)
        }
        else {
            return CGSize(width: contentView.frame.width, height: 300)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if collectionView1.getInt() > increasedData1.count - 2 {
            collectionView1.scrollToItem(at: IndexPath(item: originalDataSouceCount*2, section: .zero),
                                                at: .centeredHorizontally,
                                                animated: false)
            collectionView2.scrollToItem(at: IndexPath(item: originalDataSouceCount*2, section: .zero),
                                                at: .centeredHorizontally,
                                                animated: false)
            return
        }
        if collectionView1.getInt() <= 0 {
            collectionView1.scrollToItem(at: IndexPath(item:5, section: .zero),
                                                at: .centeredHorizontally,
                                                animated: false)
            collectionView2.scrollToItem(at: IndexPath(item: 5, section: .zero),
                                                at: .centeredHorizontally,
                                                animated: false)
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionView1.scrollToNearestVisibleCollectionViewCell()
        collectionView2.scrollToItem(at: self.collectionView1.getIndex(), at: .centeredHorizontally, animated: false)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collectionView1.scrollToNearestVisibleCollectionViewCell()
        }
    }

//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
//            let pageInt = Int(round(pageFloat))
//
//            switch pageInt {
//            case 0:
//                collectionView1.scrollToItem(at: [0, 3], at: .left, animated: false)
//            case increasedData1.count - 1:
//                collectionView1.scrollToItem(at: [0, 1], at: .left, animated: false)
//            default:
//                break
//            }
//        }
}



//MARK: - CollectionView1Cell
class CollectionView1Cell: UICollectionViewCell {
    static let identifier = "CollectionView1Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - CollectionView2Cell
class CollectionView2Cell: UICollectionViewCell {
    static let identifier = "CollectionView2Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - CustomFlowLayout

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
           let superAttributes = super.layoutAttributesForElements(in: rect)
           
           superAttributes?.forEach { attributes in
            
               guard let collectionView = self.collectionView else { return }

               let collectionViewCenter = collectionView.frame.size.width / 2
               let offsetX = collectionView.contentOffset.x
               let center = attributes.center.x - offsetX
               
               print("center.x: \(attributes.center.x)")
               print("offset : \(offsetX)")
               print("self.minimumLineSpacing : \(self.minimumLineSpacing)")
               print("self.itemSize.width : \(self.itemSize.width)")

               let maxDis = self.itemSize.width + self.minimumLineSpacing
               let dis = min(abs(collectionViewCenter-center), maxDis)

               if dis == maxDis {
                   print("equal!!!")
               }
               
               let ratio = (maxDis - dis)/maxDis
               let scale = ratio * (1-0.7) + 0.7

               if scale != 0.7 {
                   print("!!1")
               }

               //
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
//               attributes.size = CGSize(width: 200 * scale, height: 250 * scale)
//            attributes.transform = CGAffineTransform(translationX: 0, y: 0)
//            attributes.transform = CGAffineTransform(rotationAngle: .pi)
//            attributes.frame = CGRect(x: attributes.frame.origin.x, y: attributes.frame.origin.y-16, width: attributes.frame.width, height: attributes.frame.height)
          
           }
           
           return superAttributes
    }
     
}


class CoverFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 1.获取该范围内的布局数组
        let attributes = super.layoutAttributesForElements(in: rect)
        // 2.计算出整体中心点的 x 坐标
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        // 3.根据当前的滚动，对每个 cell 进行相应的缩放
        attributes?.forEach({ (attr) in
            // 获取每个 cell 的中心点，并计算这俩个中心点的偏移值
            let pad = abs(centerX - attr.center.x)
            
            // 如何计算缩放比?我的思路是，距离越小，缩放比越小，缩放比最大是1，当俩个中心点的 x 坐标
            // 重合的时候，缩放比就为 1.
            
            // 缩放因子
            let factor = 0.0019
            // 计算缩放比
            let scale = 1 / (1 + pad * CGFloat(factor))
            attr.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
        // 4.返回修改后的 attributes 数组
        return attributes
    }
        
    /// 滚动时停下的偏移量
    /// - Parameters:
    ///   - proposedContentOffset: 将要停止的点
    ///   - velocity: 滚动速度
    /// - Returns: 滚动停止的点
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetPoint = proposedContentOffset
        // 1.计算中心点的 x 值
        let centerX = proposedContentOffset.x + collectionView!.bounds.width / 2
        // 2.获取这个点可视范围内的布局属性
        let attrs = self.layoutAttributesForElements(in: CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height))

        // 3. 需要移动的最小距离
        var moveDistance: CGFloat = CGFloat(MAXFLOAT)
        // 4.遍历数组找出最小距离
        attrs!.forEach { (attr) in
            if abs(attr.center.x - centerX) < abs(moveDistance) {
                moveDistance = attr.center.x - centerX
            }
        }
        // 5.返回一个新的偏移点
        if targetPoint.x > 0 && targetPoint.x < collectionViewContentSize.width - collectionView!.bounds.width {
            targetPoint.x += moveDistance
        }

        return targetPoint
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: sectionInset.left + sectionInset.right + (CGFloat(collectionView!.numberOfItems(inSection: 0)) * (itemSize.width + minimumLineSpacing)) - minimumLineSpacing, height: 0)
//    }
}
