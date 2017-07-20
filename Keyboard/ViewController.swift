//
//  ViewController.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        testEmoticon()
    }
    
    func testEmoticon() {
        
        var groupList = [EmoticonGroup]()
        if let qqemoticon = EmoticonGroup(identifier: "com.qq.classic") {
            groupList.append(qqemoticon)
        }
        
        if let liemoticon = EmoticonGroup(identifier: "cn.com.a-li") {
            groupList.append(liemoticon)
        }
        
        let height: CGFloat = 216
        let frame = CGRect(x: 0, y: self.view.height - height, width: self.view.width, height: height)
        let inputView = EmoticonInputView(frame: frame)
        inputView.groupList = groupList
        self.view.addSubview(inputView)
        
        inputView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

