//
//  ViewController.swift
//  CircleMenu
//
//  Created by Pavel Chehov on 08/11/2018.
//  Copyright © 2018 Pavel Chehov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CircleMenuDelegate {
    
    var icons = [String:UIImage]()
    let submenuIds = [2,3]
    
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        icons["icImage"] = UIImage(named: "icImage")
        icons["icPanorama"] = UIImage(named: "icPanorama")
        icons["icVideo"] = UIImage(named: "icVideo")
        icons["icPhoto"] = UIImage(named: "icPhoto")
        icons["icTimelapse"] = UIImage(named: "icTimelapse")
        icons["icMacro"] = UIImage(named: "icMacro")
        icons["icPortrait"] = UIImage(named: "icPortrait")
        icons["icSeries"] = UIImage(named: "icSeries")
        icons["icTimer"] = UIImage(named: "icTimer")
        icons["icSixteenToNine"] = UIImage(named: "icSixteenToNine")
        icons["icOneToOne"] = UIImage(named: "icOneToOne")
        icons["icHDR"] = UIImage(named: "icHDR")
        
        let circleMenu = CircleMenu()
        
        circleMenu.attach(to: self)
        circleMenu.delegate = self
        
        //тут можно кастомизировать
        circleMenu.circleMenuItems = createCircleMenuItems(count: 4)
//        circleMenu.focusedIconColor = UIColor.red
//        circleMenu.unfocusedIconColor = UIColor.green
//        circleMenu.focusedBackgroundColor = UIColor.black
//        circleMenu.unfocusedBackgroundColor = UIColor.yellow
    }
    
    func menuItemSelected(id: Int) {
        print(id)
        idLabel.text = "id: \(id)"
    }
    
    private func createCircleMenuItems(count: Int) -> [CircleMenuItemModel] {
        var menuModels = [CircleMenuItemModel]()
        for i in 0..<count {
            let modelIndex = icons.index(icons.startIndex, offsetBy: i)
            let menuModel = CircleMenuItemModel(id: i, imageSource: icons[modelIndex].value)
            if submenuIds.contains(i){
                for j in  9..<12 {
                    let submodelIndex = icons.index(icons.startIndex, offsetBy: j)
                    let submenuModel = CircleMenuItemModel(id: j, imageSource: icons[submodelIndex].value)
                    menuModel.children!.append(submenuModel)
                }
            }
            menuModels.append(menuModel)
        }
        return menuModels
    }
}

