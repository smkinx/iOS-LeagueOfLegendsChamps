//
//  FavoriteChampionsTableViewController.swift
//  lol champions 1
//
//  Created by Supratim Baruah on 12/4/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit

class FavoriteChampionsTableViewController: UITableViewController {

    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    let tableViewRowHeight: CGFloat = 100.0
    
    //@IBOutlet var tabView: UITableView!
    var champsData = [String: AnyObject]()
    var favChampsNames     = [String]()
    var champs = [String]()
    var champDataToPass = [String: AnyObject]()
    var champ: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Organize, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.leftBarButtonItem = button
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        
        //Fetching data from api
        var dict_ChampsData = [String: AnyObject]()
        let apiURL = "https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=info&api_key=3f12fb97-3289-4cdd-9ca7-a3d8e314e65d"
        
        // Create an NSURL object from the API URL string
        var url = NSURL(string: apiURL)
        
        var jsonError: NSError?
        
        let jsonData: NSData? = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMapped, error: &jsonError)
        
        if let jsonDataFromApiUrl = jsonData {
            
            let jsonDataDictionary = NSJSONSerialization.JSONObjectWithData(jsonDataFromApiUrl,
                options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            
            // Typecast the returned NSDictionary as Dictionary<String, AnyObject>
            dict_ChampsData = jsonDataDictionary as Dictionary<String, AnyObject>
            
            champs = dict_ChampsData["data"]?.allKeys as [String]
            
            champsData = dict_ChampsData["data"] as Dictionary<String, AnyObject>
            
            //sort the champs by name
            champs.sort{$0 < $1}
            
            
        } else {
            showErrorMessage("Error in retrieving JSON data: \(jsonError!.localizedDescription)")
        }
        
    
        
        //getting data from the plist file
       
  

    }

    /*
    ------------------------------------------------
    MARK: - Show Alert View Displaying Error Message
    ------------------------------------------------
    */
    
    func showErrorMessage(errorMessage: String) {
        
        // Instantiate an alert view object
        var alertView = UIAlertView()
        
        alertView.title = "Unable to Obtain Data!"
        alertView.message = errorMessage
        alertView.delegate = nil
        
        //alertView.dismissWithClickedButtonIndex(-1, animated: true)
        alertView.addButtonWithTitle("OK")
        
        alertView.show()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewDidLoad()
        self.favChampsNames = applicationDelegate.dict_FavChamps["FavChamp"] as [String]
        self.favChampsNames.sort { $0 < $1 }
        println("fav")
        var i: Int = 0;
        for(i; i < self.favChampsNames.count; i++)
        {
            println(favChampsNames[i])
        }
        tableView.reloadData()
        // Deselect the earlier selected directions type
        //directionsTypeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
    }

    /*
    -----------------------------------
    MARK: - Table View Delegate Methods
    -----------------------------------
    */
    
    // Asks the table view delegate to return the height of a given row.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableViewRowHeight
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
        if(favChampsNames.count != 0)
        {
            return favChampsNames.count
        }
        else
        {
            return 1
        }
    }

    /*
    ------------------------------------
    Prepare and Return a Table View Cell
    ------------------------------------
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChampionTableViewCell = tableView.dequeueReusableCellWithIdentifier("FavChampCell", forIndexPath: indexPath) as ChampionTableViewCell

        let rowNumber: Int = indexPath.row
        if(favChampsNames.count != 0)
        {
            cell.champName.text = favChampsNames[rowNumber]
            var champName: String = favChampsNames[rowNumber]
            // Create an NSURL object from the thumbnail URL string
            var url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/4.20.1/img/champion/\(champName).png")
            
            var errorInReadingImageData: NSError?
            
            // Retrieve the movie poster thumbnail image data from the thumbnail URL
            var imageData: NSData? = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &errorInReadingImageData)
            
            if let iD = imageData {

                cell.champImage.image = UIImage(data: imageData!)
                
            } else {
                showErrorMessage("Error occurred while retrieving movie poster image data!")
            }
            var data = [String: AnyObject]()
            data = champsData["\(champName)"] as Dictionary<String, AnyObject>
            cell.champTitle.text = data["title"] as String
            cell.bgImage.backgroundColor = UIColor.blackColor()
            cell.bgImage.alpha = 0.0
            
            cell.champImage.layer.cornerRadius = cell.champImage.frame.size.width / 2
            cell.champImage.clipsToBounds = true
            cell.champImage.layer.borderWidth = 3.0
            cell.champImage.layer.borderColor = UIColor.whiteColor().CGColor
            cell.seperatorImage.backgroundColor = UIColor.whiteColor()
            cell.seperatorImage.alpha = 0.3
            cell.backgroundColor = UIColor.clearColor()
            
            
            
        }
        else
        {
            
            cell.textLabel.text = "You have no favorite champion"
            cell.textLabel.textColor = UIColor.whiteColor()
            cell.backgroundColor = UIColor.clearColor()
            cell.champName.text = ""
            cell.champTitle.text = ""
            cell.champImage.image = nil
            cell.champImage.layer.borderColor = UIColor.clearColor().CGColor
            
        }
        
        

        
        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if(favChampsNames.count > 0)
        {
            var rowNumber: Int = indexPath.row    // Identify the row number
            var data = [String: AnyObject]()
            champ = favChampsNames[rowNumber]
            data = champsData["\(champ)"] as Dictionary<String, AnyObject>
            champDataToPass = data
            //print(champ)
            performSegueWithIdentifier("champInfo", sender: self)
        }
        
    }
    
    /*
    -------------------------
    MARK: - Prepare For Segue
    -------------------------
    */
    
    // This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
    // You never call this method. It is invoked by the system.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "champInfo" {
            
            // Obtain the object reference of the destination view controller
            var champInfoController: ChampionInfoViewController = segue.destinationViewController as ChampionInfoViewController
            
            
            //Pass the data object to the destination view controller object
            champInfoController.champ = champ
            champInfoController.champDataToPass = champDataToPass
            
        }
        
    }
   
}
