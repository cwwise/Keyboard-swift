//
//  MoreInputView.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

protocol MoreInputViewDelegate: NSObjectProtocol {
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem)
}

class MoreInputView: UIView {
    
    weak var delegate: MoreInputViewDelegate?
    
    fileprivate var items = [MoreItem]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
