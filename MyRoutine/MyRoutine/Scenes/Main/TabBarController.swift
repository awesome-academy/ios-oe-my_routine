//
//  TabBarController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

class TabBarController: UITabBarController {
    // MARK: - Variables
    let diaryVC = Storyboards.diary.instantiateViewController(withIdentifier: "Diary")
    let statisticAll = Storyboards.statisticAll.instantiateViewController(withIdentifier: "StatisticAll")
    let setting = Storyboards.setting.instantiateViewController(withIdentifier: "Setting")
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    // MARK: - Setup
    func setupTabBar() {
        diaryVC.tabBarItem = UITabBarItem(title: "Nhật ký",
                                          image: UIImage(named: "iconDiary"), tag: 0)
        statisticAll.tabBarItem = UITabBarItem(title: "Thống kê",
                                               image: UIImage(named: "iconStatistic"), tag: 1)
        setting.tabBarItem = UITabBarItem(title: "Cài đặt",
                                          image: UIImage(named: "iconSetting"), tag: 2)
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.6677710414, blue: 0.7362043262, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.viewControllers = [diaryVC, statisticAll, setting]
    }
    
}
