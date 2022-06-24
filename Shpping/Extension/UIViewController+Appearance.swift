//
//  UIViewController+Appearance.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import UIKit

extension UIViewController {
    func setBarBlur() {
        guard let navigationVC = navigationController else {
            return
        }
        let barAppearance = UINavigationBarAppearance()
        navigationVC.navigationBar.standardAppearance = barAppearance
        navigationVC.navigationBar.scrollEdgeAppearance = barAppearance
    }
}
