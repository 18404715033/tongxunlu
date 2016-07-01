//
//  ViewController.swift
//  tongxunlu
//
//  Created by 李伯阳  Lok’Tar Ogar on 16/7/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var db:SQLiteDB!
    
    @IBOutlet weak var txtUname: UITextField!
    
    @IBOutlet weak var txtMobile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = SQLiteDB.sharedInstance()
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        initUser()
    }
    @IBAction func saveClicked(sender: AnyObject) {
        saveUser()
    }
    
    func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtMobile.text = user["mobile"] as? String
        }
    }

    
    func saveUser() {
        let uname = self.txtUname.text!
        let mobile = self.txtMobile.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into t_user(uname,mobile) values('\(uname)','\(mobile)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

