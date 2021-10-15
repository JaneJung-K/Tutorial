//
//  CalendarViewController.swift
//  Tutorial
//
//  Created by Leah on 2021/10/12.
//

import UIKit

// 수평 스크롤 되는 DatePicker Calendar
class CalendarViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
    
    //MARK: - Property
    
    private var calendarDayArray:[String]?
    private var calendarMonthArray:[String]?
    
    private lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 44, height: 54)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       return collectionView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(calendarCollectionView)
        
        calendarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(320)
            make.height.equalTo(54)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //오늘 날짜로 스크롤한다.
        scrollToDate(date: Date())
    }
    
    func scrollToDate(date: Date) {
        print("will scroll to today")
        let startDate = CalendarModel.shared.startDate
        let cal = Calendar.current
        if let numberOfDays = cal.dateComponents([.day], from: startDate, to: date).day {
            let indexPath = IndexPath(row: numberOfDays, section: 0)
            calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: false)
        }
       
    }
    
}

// MARK: - CollectionView

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        calendarDayArray = CalendarModel.shared.arrayOfDays() as? [String]
        calendarMonthArray = CalendarModel.shared.arrayOfMonths() as? [String]
        guard calendarDayArray != nil else { return 0 }
        return calendarDayArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as! CalendarCollectionViewCell
        let month = calendarMonthArray![indexPath.row]
        let day = calendarDayArray![indexPath.row]
        cell.configure(with: month, with: day)
        cell.backgroundColor = .cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let pvc = PageControlViewController()
        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = self
        
        present(pvc, animated: true, completion: nil)
    }
}

extension CalendarViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        }
}

extension UICollectionView {
    
    func scrollToIndex(to index: Int) {
        self.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    
}

// MARK: - CollectionViewCell

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "calendarCollectionViewCell"
    
    private var monthLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(monthLabel)
        contentView.addSubview(dateLabel)
        monthLabel.sizeToFit()
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        dateLabel.sizeToFit()
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with month: String, with day: String) {
        monthLabel.text = month
        dateLabel.text = day
    }
    
}

// MARK: -CalendarModel

struct CalendarModel {
    static let shared = CalendarModel()
    
    // 달력의 시작 날짜
    var startDate: Date {
        var startComponents = DateComponents()
        startComponents.calendar = Calendar.current
        startComponents.year = 2021
        startComponents.month = 10
        startComponents.day = 1
        startComponents.timeZone = TimeZone(abbreviation: "GMT")

        let res = Calendar.current.date(from: startComponents) ?? Date()
        return res
    }
    
    func arrayOfDays() -> NSArray {
            let numberOfDays: Int = 730
            let formatter: DateFormatter = DateFormatter()
//            formatter.dateFormat = "M월d"
            formatter.dateFormat = "d"
            let calendar = Calendar.current
            var offset = DateComponents()
            var dates: [Any] = [formatter.string(from: startDate)]
            
            for i in 1..<numberOfDays {
                offset.day = i
                let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
                let nextDayString = formatter.string(from: nextDay!)
                dates.append(nextDayString)
            }
            return dates as NSArray
        }
    
    func arrayOfMonths() -> NSArray {
            let numberOfDays: Int = 730
            let formatter: DateFormatter = DateFormatter()
//            formatter.dateFormat = "M월d"
            formatter.dateFormat = "M월"
            let calendar = Calendar.current
            var offset = DateComponents()
            var dates: [Any] = [formatter.string(from: startDate)]
            
            for i in 1..<numberOfDays {
                offset.day = i
                let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
                let nextDayString = formatter.string(from: nextDay!)
                dates.append(nextDayString)
            }
            return dates as NSArray
        }
    
}
