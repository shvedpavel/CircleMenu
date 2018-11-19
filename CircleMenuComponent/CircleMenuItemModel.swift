//
//  CircleMenuItemModel.swift
//  CircleMenu
//
//  Created by Pavel Chehov on 08/11/2018.
//  Copyright © 2018 Pavel Chehov. All rights reserved.
//

import UIKit

public class CircleMenuItemModel {
    public var id: Int?
    public var imageSource: UIImage?
    public var children: [CircleMenuItemModel]?
    public var hasChildren: Bool {
        guard let children = children else {
            return false
        }
        return children.count > 0
    }
    
    public init() {
        children = [CircleMenuItemModel]()
    }
    
    public init(id: Int?, imageSource: UIImage?, children: [CircleMenuItemModel]? = nil) {
        self.id = id
        self.imageSource = imageSource?.withRenderingMode(.alwaysTemplate)
        self.children = children ?? [CircleMenuItemModel]()
    }
}
