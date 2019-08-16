//
//  UIView+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension UIView {
    var height: CGFloat {
        return self.bounds.height
    }
    var witdh: CGFloat {
        return self.bounds.width
    }
    func radius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    class func fromNib() -> UIView? {
        return Bundle(for: self).loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView
    }
}
