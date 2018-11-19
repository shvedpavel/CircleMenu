//
//  CAAnimationExtension.swift
//  CircleMenu
//
//  Created by Pavel Chehov on 12/11/2018.
//  Copyright © 2018 Pavel Chehov. All rights reserved.
//

import UIKit

class AnimationDelegate: NSObject, CAAnimationDelegate {
    var callback: (() -> ())?
    
    convenience init(_ callback: @escaping ()->()) {
        self.init()
        self.callback = callback
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let callback = callback {
            callback()
        }
    }
}
