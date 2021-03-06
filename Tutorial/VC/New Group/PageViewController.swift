//
//  PageViewController.swift
//  Tutorial
//
//  Created by Leah on 2021/11/10.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()

    override func viewDidLoad() {
       super.viewDidLoad()
            self.dataSource = self
            self.delegate = self
            let initialPage = 0
            let page1 = ViewController1()
            let page2 = ViewController2()
            let page3 = ViewController3()
                    
            // add the individual viewControllers to the pageViewController
            self.pages.append(page1)
            self.pages.append(page2)
            self.pages.append(page3)
            setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)

             // pageControl
             self.pageControl.frame = CGRect()
             self.pageControl.currentPageIndicatorTintColor = UIColor.black
             self.pageControl.pageIndicatorTintColor = UIColor.lightGray
             self.pageControl.numberOfPages = self.pages.count
             self.pageControl.currentPage = initialPage
             self.view.addSubview(self.pageControl)

             self.pageControl.translatesAutoresizingMaskIntoConstraints = false
             self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
             self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
             self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
             self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                pageControl.currentPage = self.pages.count - 1
                return self.pages.last
            } else {
                // go to previous page in array
                pageControl.currentPage = viewControllerIndex - 1
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
            
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                pageControl.currentPage = viewControllerIndex + 1
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                pageControl.currentPage = 0
                return self.pages.first
            }
        }
        return nil
    }
}
