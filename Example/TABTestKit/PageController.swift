//
//  PageController.swift
//  TABTestKit_Example
//
//  Created by Ben Gilroy on 10/07/2020.
//  Copyright © 2020 Kin + Carta. All rights reserved.
//

import UIKit

final class PageController: UIPageViewController {
    
    private var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.accessibilityIdentifier = "PageView"
        setupPages()
        setupPageControl()
        dataSource = self
    }
    
    private func setupPages() {
        let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
        pages = colors.map { color in
            let viewController = UIViewController()
            viewController.view.backgroundColor = color
            return viewController
        }
        setViewControllers([pages[0]], direction: .forward, animated: false)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = .gray
        appearance.currentPageIndicatorTintColor = .black
        appearance.backgroundColor = .white
    }

}

extension PageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
