//
//  ViewController.swift
//  Tutorial
//
//  Created by Leah on 2021/11/10.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor.yellow
            
            // label
            let labelInst = UILabel()
            self.view.addSubview(labelInst)
            labelInst.text = "Page 1"
            labelInst.translatesAutoresizingMaskIntoConstraints = false
            labelInst.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
            labelInst.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}

class ViewController2: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor.cyan
            
            // label
            let labelInst = UILabel()
            self.view.addSubview(labelInst)
            labelInst.text = "Page 2"
            labelInst.translatesAutoresizingMaskIntoConstraints = false
            labelInst.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
            labelInst.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}

class ViewController3: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor.gray
            
            // label
            let labelInst = UILabel()
            self.view.addSubview(labelInst)
            labelInst.text = "Page 3"
            labelInst.translatesAutoresizingMaskIntoConstraints = false
            labelInst.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
            labelInst.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}
