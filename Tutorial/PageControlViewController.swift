//
//  PageControl.swift
//  CarouselExample
//
//  Created by 정혜영 on 2021/10/01.
//

import Foundation
import UIKit

class PageControlViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    private var cell = PageControlTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cell.pageCollectionView.scrollToItem(at: IndexPath(item: 5, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func setUpTableView() {
        let tableView = UITableView()
        tableView.register(PageControlTableViewCell.self, forCellReuseIdentifier: PageControlTableViewCell.identifier)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: PageControlTableViewCell.identifier, for: indexPath) as! PageControlTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height
    }
}

// MARK: - FirstTableViewCell

class PageControlTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "PageControlTableViewCell"
    
    
    var pageCollectionView: UICollectionView!
    
    private let pageConrol = UIPageControl()
    
    var originY: CGFloat?
    
    let data1: [UIColor] = [.blue, .gray, .brown, .cyan, .green]
    
    private lazy var increasedData1: [UIColor] = {
        data1 + data1 + data1
    }()
    
    private var originalDataSouceCount: Int {
        data1.count
    }
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpPageCollectionView()
        setUpPageControl()

        
    }
    
    func setUpPageCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        
        self.pageCollectionView = collectionView
        
        pageCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }

        
    }
    
    func setUpPageControl() {
        pageConrol.numberOfPages = 3
        pageConrol.pageIndicatorTintColor = .darkGray
        
        contentView.addSubview(pageConrol)
        
        pageConrol.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pageCollectionView.snp.bottom).inset(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return increasedData1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = increasedData1[indexPath.row]
        cell.layer.cornerRadius = 16
        originY = cell.frame.origin.y
        if indexPath.row == 5 {
            cell.frame =  CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y-16, width: cell.frame.width, height: cell.frame.height)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 280, height: 200)
       
    }
    

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if pageCollectionView.getInt() > increasedData1.count - 2 {
            pageCollectionView.scrollToItem(at: IndexPath(item: originalDataSouceCount*2-1, section: .zero),
                                                at: .centeredHorizontally,
                                                animated: false)
           
            return
        }
        if pageCollectionView.getInt() <= 0 {
            pageCollectionView.scrollToItem(at: IndexPath(item:originalDataSouceCount*2-1, section: .zero),
                                                at: .centeredHorizontally,
                                                animated: false)
        
            return
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = pageCollectionView.getInt()
        print(index)
        let page = index % 3
        if page == 0 {
            self.pageConrol.currentPage = 2
        }
        else if page == 1 {
            self.pageConrol.currentPage = 0
        }
        else if page == 2 {
            self.pageConrol.currentPage = 1
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageCollectionView.scrollToNearestVisibleCollectionViewCell()
        let index = pageCollectionView.getInt()
        let page = index % 3
        if page == 0 {
            self.pageConrol.currentPage = 2
        }
        else if page == 1 {
            self.pageConrol.currentPage = 0
        }
        else if page == 2 {
            self.pageConrol.currentPage = 1
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.pageCollectionView.scrollToNearestVisibleCollectionViewCell()
        }
        let index = pageCollectionView.getInt()
        DispatchQueue.main.async {
            for i in 0..<Int(self.pageCollectionView.visibleCells.count) where i != index {
                let cell = self.pageCollectionView.visibleCells[i]
                guard let y = self.originY else {
                    return
                }
                cell.frame = CGRect(x: cell.frame.origin.x, y: y, width: cell.frame.width, height: cell.frame.height)
            }
        }
    }
}


// MARK: - Extension CollectionView

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            let index = IndexPath(row: closestCellIndex, section: 0)
            self.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            let cell = self.cellForItem(at: index)!
            cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y-16, width: cell.frame.width, height: cell.frame.height)
    
        }
    }
    
    func getIndex() -> IndexPath {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            return IndexPath(item: closestCellIndex, section: 0)
        } else { return IndexPath(item: 0, section: 0) }
    }
    
    func getInt() -> Int {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            return closestCellIndex
        } else { return 0 }
    }
}


