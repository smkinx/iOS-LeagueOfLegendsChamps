//
//  NavigationTableViewController.swift
//  lol champions 1
//
//  Created by Supratim Baruah on 12/12/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit

class NavigationTableViewController: UITableViewController {

     var nav = [String]()

    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    //@IBOutlet var tabView: UITableView!
    var favChampsNames     = [String]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        nav.append("Title")
        nav.append("AllChampions")
        nav.append("FavoriteChamps")
        nav.append("Trailer")
        tableView.backgroundColor = UIColor(red: 0.259, green: 0.259, blue:0.259, alpha:1.000)
        //tabView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewDidLoad()
        self.favChampsNames = applicationDelegate.dict_FavChamps.allKeys as [String]
        self.favChampsNames.sort { $0 < $1 }
        println("fav")
        var i: Int = 0;
        for(i; i < self.favChampsNames.count; i++)
        {
            println(favChampsNames[i])
        }
        //tabView.reloadData()
        // Deselect the earlier selected directions type
        //directionsTypeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return nav.count
    }
    
    /*
    ------------------------------------
    Prepare and Return a Table View Cell
    ------------------------------------
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rowNumber: Int = indexPath.row
        var cellIdentifier: String = nav[rowNumber]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        //cell.textLabel.text = "hello";
        return cell
    }
    
    // Informs the table view delegate that the specified row is selected.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        var rowNumber: Int = indexPath.row    // Identify the row number
        //var frontViewController: UIViewController = FrontViewPositionLeft as UIViewController
        var segue: String =  nav[rowNumber]
        //self.revealViewController().setFrontViewPosition(FrontViewPositionLeft, animated: true)
        performSegueWithIdentifier(segue, sender: self)
        
    }

    /*
    -------------------------
    MARK: - Prepare For Segue
    -------------------------
    */
    
    // This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
    // You never call this method. It is invoked by the system.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        //var trailer: MoreInfoWebViewController = MoreInfoWebViewController();
        if(segue.isKindOfClass(SWRevealViewControllerSegue))
        {
            var rvcs: SWRevealViewControllerSegue = segue as SWRevealViewControllerSegue
            var rvc:SWRevealViewController = self.revealViewController()
            
            rvcs.performBlock = {(rvc_segue, svc, dvc) in
                //var nc:UINavigationController = self.revealViewController().frontViewController as UINavigationController
                //nc.setViewControllers([dvc], animated: false)
                self.revealViewController().setFrontViewController(segue.destinationViewController as UIViewController, animated: true)
                self.revealViewController().setFrontViewPosition(FrontViewPositionLeft, animated: true)
                
                
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
