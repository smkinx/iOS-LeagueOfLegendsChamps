//
//  NavBarViewController.swift
//  lol champions 1
//
//  Created by Supratim Baruah on 12/14/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit

class NavBarViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor(red: 240/255, green: 240/255, blue:240/255, alpha:1.000)
        self.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue:0.259, alpha:1.000)
        //tabBarControllerbarTintColor = UIColor(red: 0.259, green: 0.259, blue:0.259, alpha:1.000)
        //tabBarController.tabBar.tintColor = UIColor.whiteColor()
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
