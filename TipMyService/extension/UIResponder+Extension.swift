//
//  UIResponder+Extension.swift
//  TipMyService
//
//  Created by Trey Browder on 5/9/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
