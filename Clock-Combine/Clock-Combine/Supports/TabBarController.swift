//
//  TabBarController.swift
//  Clock-Combine
//
//  Created by sejin on 2023/11/22.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTabBarControllers()
    }
}

extension TabBarController {
    private func setUI() {
        tabBar.backgroundColor = .black
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .systemOrange
    }
    
    private func setTabBarControllers() {
        let worldColckNVC = templateNavigationController(title: "세계 시계",
                                                           unselectedImage: UIImage(systemName: "globe"),
                                                           selectedImage: UIImage(systemName: "globe"),
                                                           rootViewController: WorldClockVC())
        let alarmNVC = templateNavigationController(title: "알람",
                                                         unselectedImage: UIImage(systemName: "alarm.fill"),
                                                         selectedImage: UIImage(systemName: "alarm.fill"),
                                                         rootViewController: AlarmVC())
        let jhStopwatchNVC = templateNavigationController(title: "준혁 스톱워치",
                                                         unselectedImage: UIImage(systemName: "stopwatch.fill"),
                                                         selectedImage: UIImage(systemName: "stopwatch.fill"),
                                                         rootViewController: JHStopwatchVC())
        let ysStopwatchNVC = templateNavigationController(title: "연수 스톱워치",
                                                         unselectedImage: UIImage(systemName: "stopwatch.fill"),
                                                         selectedImage: UIImage(systemName: "stopwatch.fill"),
                                                         rootViewController: YSStopwatchVC())
        
        let timerNVC = templateNavigationController(title: "타이머",
                                                         unselectedImage: UIImage(systemName: "timer"),
                                                         selectedImage: UIImage(systemName: "timer"),
                                                         rootViewController: TimerVC())
        
        viewControllers = [worldColckNVC, alarmNVC, jhStopwatchNVC, ysStopwatchNVC, timerNVC]
    }
    
    private func templateNavigationController(title: String, unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.title = title
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
}

