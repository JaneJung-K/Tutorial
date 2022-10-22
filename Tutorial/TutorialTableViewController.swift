//
//  TutorialTableViewController.swift
//  Tutorial
//
//  Created by imac on 2022/02/24.
//

import UIKit

class TutorialTableViewController: UITableViewController {
    
    let items: [(String, UIViewController)] = [
        ("QR 스캔", QRCodeBaseViewController()),
        ("바이오 로그인", BioLoginViewController()),
        ("연락처 가져오기", ContactsViewController()),
        ("HorizontalStickyHeaderLayout", HorizontalStickyHeaderViewController()),
        ("LottieTestViewController", LottieTestViewController()),
        ("CalendarViewController", CalendarViewController()),
        ("ScaleViewController", ScaleViewController()),
        ("ProgressViewWithPanGestureViewController",ProgressViewWithPanGestureViewController())
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iOS Tutorial"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = items[indexPath.row].1
        navigationController?.pushViewController(vc, animated: true)
    }
}

