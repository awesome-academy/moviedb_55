//
//  UIViewController+Extension.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Then

extension UINavigationController {
    func presentVC(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
        let transition = CATransition().then {
            $0.duration = duration
            $0.type = CATransitionType.push
            $0.subtype = type
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        
        if let view = view.window {
            view.layer.add(transition, forKey: kCATransition)
            present(vc, animated: false, completion: nil)
        }
    }
    
    func dismissVC(duration: CFTimeInterval, type: CATransitionSubtype) {
        let transition = CATransition().then {
            $0.duration = duration
            $0.type = CATransitionType.push
            $0.subtype = type
        }
        
        if let view = view.window {
            view.layer.add(transition, forKey: kCATransition)
            dismiss(animated: false)
        }
    }
}
