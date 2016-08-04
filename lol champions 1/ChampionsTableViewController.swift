//
//  ChampionsTableViewController.swift
//  lol champions 1
//
//  Created by Supratim Baruah on 11/30/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit


class ChampionsTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    let tableViewRowHeight: CGFloat = 100.0
    
    // moviesCurrentlyPlayingInTheaters is an Array of Dictionaries, where each Dictionary contains data about a movie
    var champsData = [String: AnyObject]()
    @IBOutlet var tabView: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    var champs = [String]()
    var champDataToPass = [String: AnyObject]()
    var champ: String = ""
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var favChampsNames     = [String]()
    var champSearch = [String]()

    
    /*
    -----------------------
    MARK: - View Life Cycle
    -----------------------
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Nav bar button
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Organize , target: self.revealViewController(), action: "revealToggle:")
    
        self.navigationItem.leftBarButtonItem = button
        searchBar.tintColor = UIColor.whiteColor()
       
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        
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
    
    /*
    --------------------------------------
    MARK: - Table View Data Source Methods
    --------------------------------------
    */
    
    // Asks the data source to return the number of sections in the table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    // Asks the data source to return the number of rows in a section, the number of which is given
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return champSearch.count
        } else {
            return champs.count
        }
    }
    
    /*
    ------------------------------------
    Prepare and Return a Table View Cell
    ------------------------------------
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let rowNumber: Int = indexPath.row    // Identify the row number
        
        //var cell = UITableViewCell()
        // Obtain the object reference of a reusable table view cell object instantiated under the identifier
        // MovieCell, which was specified in the storyboard
        var cell: ChampionTableViewCell = tabView.dequeueReusableCellWithIdentifier("ChampCell") as ChampionTableViewCell
        tableView.separatorColor = UIColor.clearColor()

        
        var champDisplay = [String]()
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
            champDisplay = champSearch
        } else {
            champDisplay = champs
        }
        
        var champName: String = champDisplay[rowNumber]
        cell.champName.text = champName
        var data = [String: AnyObject]()
        data = champsData["\(champName)"] as Dictionary<String, AnyObject>
        cell.champTitle.text = data["title"] as String
        var info = [String: AnyObject]()
        info = data["info"] as Dictionary<String, AnyObject>
        
        
        // Create an NSURL object from the thumbnail URL string
        var url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/4.20.1/img/champion/\(champName).png")
        var url1 = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg")
        
        var errorInReadingImageData: NSError?
        
        // Retrieve the movie poster thumbnail image data from the thumbnail URL
        var imageData: NSData? = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &errorInReadingImageData)
        var imageData1: NSData? = NSData(contentsOfURL: url1!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &errorInReadingImageData)
        if let iD = imageData1 {
            
            // Movie poster thumbnail image data is successfully retrieved
            //cell.bgImage.image = UIImage(data: moviePosterImage1)
            cell.champImage.image = UIImage(data: imageData!)
        
            
        } else {
            showErrorMessage("Error occurred while retrieving movie poster image data!")
        }
        
        cell.bgImage.backgroundColor = UIColor.blackColor()
        cell.bgImage.alpha = 0.0        
        
        
        cell.champImage.layer.cornerRadius = cell.champImage.frame.size.width / 2
        cell.champImage.clipsToBounds = true
        cell.champImage.layer.borderWidth = 3.0
        cell.champImage.layer.borderColor = UIColor.whiteColor().CGColor
        cell.seperatorImage.backgroundColor = UIColor.whiteColor()
        cell.seperatorImage.alpha = 0.3
        cell.backgroundColor = UIColor.clearColor()
       
        
        return cell
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
    
    // Informs the table view delegate that the specified row is selected.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var rowNumber: Int = indexPath.row    // Identify the row number
        
        // Obtain the Dictionary containing the data about the selected movie to pass to the downstream view controller
        //movieDataToPass = moviesCurrentlyPlayingInTheaters[rowNumber] as Dictionary<String, AnyObject>
        if tableView == self.searchDisplayController!.searchResultsTableView {
            champ = champSearch[rowNumber]
        } else {
            champ = champs[rowNumber]
        }
        
        var data = [String: AnyObject]()
        data = champsData["\(champ)"] as Dictionary<String, AnyObject>
        champDataToPass = data
        performSegueWithIdentifier("champInfo", sender: self)
    }
    
    func filterContentForSearchText(searchText: String) {
        champSearch.removeAll(keepCapacity: false)
        for(var i: Int = 0; i < champs.count; i++)
        {
            var champName = champs[i] as String
            if((champName.lowercaseString.rangeOfString(searchText.lowercaseString)) != nil)
            {
                champSearch.append(champName)
                //print(champSearch[0])
            }
        }
        //print("hello")
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }

    
}