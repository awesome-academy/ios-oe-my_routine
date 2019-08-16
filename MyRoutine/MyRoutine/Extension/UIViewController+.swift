//
//  Array+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/12/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension UIViewController {
    class func top(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return top(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return top(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return top(controller: presented)
        }
        return controller
    }
}
 
