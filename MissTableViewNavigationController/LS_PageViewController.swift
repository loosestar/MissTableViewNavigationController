//
//  LS_PageViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 24/12/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation
import UIKit

protocol LS_PageViewControllerDelegate: class {
    func pageDidSwipe(to index: Int)
}

class LS_PageViewController: UIPageViewController {
    weak var swipeDelegate: LS_PageViewControllerDelegate?
    var pages = [UIViewController]()
    var prevIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
    }
    
    func selectPage(at index: Int) {
        self.setViewControllers([self.pages[index]],
                                direction: self.direction(for: index),
                                animated: true,
                                completion: nil)
        self.prevIndex = index
    }
    
    private func direction(for index: Int) -> UIPageViewController.NavigationDirection {
        if index > self.prevIndex {
            return UIPageViewController.NavigationDirection.forward
        } else {
            return UIPageViewController.NavigationDirection.reverse
        }
    }
}

extension LS_PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil }
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
}


extension LS_PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentPageIndex = self.viewControllers?.first?.view.tag else { return }
            self.prevIndex = currentPageIndex
            self.swipeDelegate?.pageDidSwipe(to: currentPageIndex)
        }
    }
}
