//
//  PopoverViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/20.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabelView.dataSource = self
//        self.tabelView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
