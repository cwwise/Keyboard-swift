//
//  UIButton+Extension.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/22.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

extension UIButton {
    public func setNormalImage(_ image: UIImage, highlighted hlimage: UIImage) {
        self.setImage(image, for: .normal)
        self.setImage(hlimage, for: [.highlighted,.selected])
        self.setImage(hlimage, for: .selected)
    }
}
