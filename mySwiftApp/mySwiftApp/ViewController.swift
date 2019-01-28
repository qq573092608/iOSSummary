//
//  ViewController.swift
//  mySwiftApp
//
//  Created by 黄小刚 on 2019/1/28.
//  Copyright © 2019年 黄小刚. All rights reserved.
//

import UIKit
import Masonry

class ViewController: UIViewController {

    // var nameLbl:UILabel = UILabel.init(frame: CGRect(x: 60, y: 300, width: 100, height: 30))
    var nameLbl:UILabel = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testBtn:UIButton = UIButton(type: .custom)
        testBtn.frame = CGRect(x: 0, y: 600, width: 200.0, height: 30.0)
        testBtn.setTitle("登陆", for: .normal)
        testBtn.setTitleColor(UIColor.lightGray, for: .normal)
        testBtn.tag = 101
        //
        testBtn.addTarget(self, action: #selector(testActionMethod), for: .touchUpInside)
        
        // 带参数的按钮点击事件
        // testBtn.addTarget(self, action: #selector(testAction(testBtn:)), for: .touchUpInside)
        self.view.addSubview(testBtn)
        
        // 标签
        nameLbl.text = "名称"
        nameLbl.textColor = UIColor.blue
        nameLbl.textAlignment = .center
        self.view.addSubview(nameLbl)
        
        NSLog("000...")
    }
    
    @objc func testActionMethod(){
        print("no arguments.....")
    }
    
    @objc func testAction(testBtn:UIButton){
        print("testAction.... \(testBtn.tag)")
    }
    
    override func viewWillLayoutSubviews() {
        
        NSLog("aaaa...")
        
        nameLbl.mas_makeConstraints { (make) in
            make?.centerX.offset()
            make?.centerY.offset()
            make?.width.height()?.offset()(100)
        }
    }
}

