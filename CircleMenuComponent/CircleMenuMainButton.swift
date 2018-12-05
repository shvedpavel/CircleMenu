//
//  CircleMenuMainButton.swift
//  CircleMenu
//
//  Created by Pavel Chehov on 08/11/2018.
//

import UIKit
import Lottie
import PromiseKit

public class CircleMenuMainButton: BasicCircleMenuButton {
    static let size = 52
    private let animationViewSize = 24
    private let startScale: CGFloat = 0.85
    private let endScale: CGFloat = 1.0
    private let scaleDuration = 0.1
    private let openAnimationKey = "hamburger-open"
    private let closeAnimationKey = "hamburger-close"
    private var mainbuttonOpenAnimation: LOTAnimationView
    private var mainButtonCloseAnimation: LOTAnimationView
    private var keyPaths: [LOTKeypath]
    private var colorValue: LOTColorValueCallback?
    public let id = 100
    public private(set) var isOpen: Bool = false
    
    public var unfocusedIconColor: UIColor? {
        didSet {
            colorValue = LOTColorValueCallback(color: unfocusedIconColor!.cgColor)
            for key in keyPaths {
                mainbuttonOpenAnimation.setValueDelegate(colorValue!, for: key)
                mainButtonCloseAnimation.setValueDelegate(colorValue!, for: key)
            }
        }
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        let mainButtonAnimationView = UIView()
        mainButtonAnimationView.frame = CGRect(x: (CircleMenuMainButton.size - animationViewSize) / 2, y: (CircleMenuMainButton.size - animationViewSize) / 2, width: animationViewSize, height: animationViewSize)
        mainButtonAnimationView.backgroundColor = UIColor.clear
        
        mainbuttonOpenAnimation = LOTAnimationView(name: openAnimationKey)
        mainbuttonOpenAnimation.isHidden = false
        mainbuttonOpenAnimation.frame = mainButtonAnimationView.bounds
        
        mainButtonCloseAnimation = LOTAnimationView(name: closeAnimationKey)
        mainButtonCloseAnimation.isHidden = true
        mainButtonCloseAnimation.frame = mainButtonAnimationView.bounds
        
        mainButtonAnimationView.addSubview(mainbuttonOpenAnimation)
        mainButtonAnimationView.addSubview(mainButtonCloseAnimation)
        
        keyPaths = [LOTKeypath]()
        keyPaths.append(LOTKeypath(string: "line1.Rectangle 1.Fill 1.Color"))
        keyPaths.append(LOTKeypath(string: "line2.Rectangle 1.Fill 1.Color"))
        keyPaths.append(LOTKeypath(string: "line3.Rectangle 1.Fill 1.Color"))
        
        super.init(frame: frame)
        mainButtonAnimationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainButtonAnimationViewOnTap)))
        
        backgroundColor = UIColor.white
        addSubview(mainButtonAnimationView)
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func mainButtonAnimationViewOnTap() {
        sendActions(for: .touchUpInside)
    }
    
    @objc private func touchUpInside() {
        animateScale()
        if isOpen {
                mainButtonCloseAnimation.play { _ in
                self.mainButtonCloseAnimation.isHidden = true
                self.mainbuttonOpenAnimation.isHidden = false
                self.mainButtonCloseAnimation.stop()
                self.isOpen = !self.isOpen
            }
        } else {
            mainbuttonOpenAnimation.play { _ in
                self.mainbuttonOpenAnimation.isHidden = true
                self.mainButtonCloseAnimation.isHidden = false
                self.mainbuttonOpenAnimation.stop()
                self.isOpen = !self.isOpen
            }
        }
    }
    
    private func animateScale() {
        UIView.animate(withDuration: scaleDuration, animations: {
            self.transform = CGAffineTransform.init(scaleX: self.startScale, y: self.startScale)
        }, completion: { _ in
            UIView.animate(withDuration: self.scaleDuration, animations: {
                self.transform = CGAffineTransform.init(scaleX: self.endScale, y: self.endScale)
            })
        })
    }
}
