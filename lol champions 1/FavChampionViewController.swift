//
//  FavChampionViewController.swift
//  LOL Champions
//
//  Created by Supratim Baruah on 12/14/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit

class FavChampionViewController: UINavigationController {

    var champ: String = ""
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var champImg: UIImageView!
    @IBOutlet var champName: UILabel!
    @IBOutlet var blurBgImage: UIImageView!
    @IBOutlet var moreInfoButton: UIImageView!
    @IBOutlet var img: UIImageView!
    @IBOutlet var champTitle: UILabel!
    @IBOutlet var addToFav: UIButton!
    
    @IBOutlet var favorite: UIButton!
    @IBOutlet var defense: UILabel!
    @IBOutlet var magic: UILabel!
    @IBOutlet var difficulty: UILabel!
    @IBOutlet var attack: UILabel!
    
    var champDataToPass = [String: AnyObject]()
    
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = champ
        
        
        
        //self.view.frame.width
        // Do any additional setup after loading the view.
        // Create an NSURL object from the thumbnail URL string
        var url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/4.20.1/img/champion/\(champ).png")
        var url1 = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champ)_0.jpg")
        
        var errorInReadingImageData: NSError?
        
        // Retrieve the movie poster thumbnail image data from the thumbnail URL
        var imageData: NSData? = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &errorInReadingImageData)
        var imageData1: NSData? = NSData(contentsOfURL: url1!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &errorInReadingImageData)
        
        print(self.view.frame.width)
        
        
        //sets up the view
        self.view.backgroundColor = UIColor(red: 0.259, green: 0.259, blue:0.259, alpha:1.000)
        champImg.image = UIImage(data: imageData!)
        bgImage.image = UIImage(data: imageData1!)
        moreInfoButton.backgroundColor = UIColor.grayColor()
        img.backgroundColor = UIColor.whiteColor()
        
        blurBgImage.image = UIImage(data: imageData1!)
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        
        var blurWidth: CGFloat = 0.0
        if( self.view.frame.height < self.view.frame.width)
        {
            blurWidth = self.view.frame.width
        }
        else
        {
            blurWidth = self.view.frame.height
        }
        var isFav: Bool = false
        var favArr: [String] = applicationDelegate.dict_FavChamps.objectForKey("FavChamp") as [String]
        favArr.sort{$0 < $1}
        
        
        //sets up the favorite button for the view
        for(var i: Int = 0; i < favArr.count; i++)
        {
            if(favArr[i] == champ)
            {
                isFav = true
            }
            //var champName = champs[i] as String
        }
        addToFav.layer.cornerRadius = 15
        if(!isFav)
        {
            
            addToFav.backgroundColor = UIColor(red: 0/255, green: 120/255, blue:0/255, alpha:1.000)
            addToFav.clipsToBounds = true
            addToFav.tintColor = UIColor.whiteColor()
            addToFav.setTitle("Add To Favorites", forState: UIControlState.Normal)
            
        }
        else
        {
            
            addToFav.backgroundColor = UIColor(red: 204/255, green: 0/255, blue:0/255, alpha:1.000)
            addToFav.clipsToBounds = true
            addToFav.tintColor = UIColor.whiteColor()
            addToFav.setTitle("Delete from Favorite", forState: UIControlState.Normal)
            
        }
        effectView.frame = CGRectMake(0, 0, blurWidth, 400)
        blurBgImage.addSubview(effectView)
        
        //blurBgImage.backgroundColor = UIColor.blackColor()
        bgImage.alpha = 0.1
        
        //champName.text = champ
        
        champTitle.text = champDataToPass["title"] as String
        
        var info = [String: AnyObject]()
        info = champDataToPass["info"] as Dictionary<String, AnyObject>
        var d: Int = info["defense"] as Int
        defense.text = "Defense: " + String(d) + " / 10"
        var m: Int = info["magic"] as Int
        magic.text = "Magic: " + String(m) + " / 10"
        var di: Int = info["difficulty"] as Int
        difficulty.text = "Difficulty: " + String(di) + " / 10"
        var a: Int = info["attack"] as Int
        attack.text = "Attack: " + String(a) + " / 10"
        
        champImg.layer.cornerRadius = champImg.frame.width / 2
        champImg.clipsToBounds = true
        champImg.layer.borderWidth = 3.0
        champImg.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFavorite(sender: UIButton)
    {
        var isFav: Bool = false
        var favArr: [String] = applicationDelegate.dict_FavChamps.objectForKey("FavChamp") as [String]
        favArr.sort{$0 < $1}
        
        var i : Int = 0
        for(i; i < favArr.count; i++)
        {
            if(favArr[i] == champ)
            {
                isFav = true
                break;
            }
            //var champName = champs[i] as String
        }
        if(!isFav)
        {
            favArr.append(champ)
            favArr.sort{$0 < $1}
            applicationDelegate.dict_FavChamps.setObject(favArr, forKey: "FavChamp")
            
            
            addToFav.backgroundColor = UIColor(red: 204/255, green: 0/255, blue:0/255, alpha:1.000)
            addToFav.clipsToBounds = true
            addToFav.tintColor = UIColor.whiteColor()
            addToFav.setTitle("Delete from Favorite", forState: UIControlState.Normal)
            
        }
        else
        {
            
            favArr.removeAtIndex(i)
            favArr.sort{$0 < $1}
            
            applicationDelegate.dict_FavChamps.setObject(favArr, forKey: "FavChamp")
            addToFav.backgroundColor = UIColor(red: 0/255, green: 120/255, blue:0/255, alpha:1.000)
            addToFav.clipsToBounds = true
            addToFav.tintColor = UIColor.whiteColor()
            addToFav.setTitle("Add To Favorites", forState: UIControlState.Normal)
            
            
            
        }
        //addToFav.backgroundColor = UIColor(red: 204/255, green: 0/255, blue:0/255, alpha:1.000)
        
    }
    
    //performes segue for the more info
    @IBAction func moreInfo(sender: UIButton) {
        
        performSegueWithIdentifier("MoreInfo", sender: self)
        
        
    }
    
    //performes segue for guides
    @IBAction func guides(sender: UIButton) {
        
        performSegueWithIdentifier("Guide", sender: self)
        
        
    }
    
    //performes segue for counters
    @IBAction func counters(sender: UIButton) {
        
        performSegueWithIdentifier("Counter", sender: self)
        
        
    }
    
    /*
    -------------------------
    MARK: - Prepare For Segue
    -------------------------
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "MoreInfo" {
            
            //Obtain the object reference of the destination view controller
            var moreInfoViewController: MoreInfoWebViewController = segue.destinationViewController as MoreInfoWebViewController
            
            //Pass the data object to the destination view controller object
            moreInfoViewController.champ = champ
            
            
        }
        if segue.identifier == "Guide" {
            
            //Obtain the object reference of the destination view controller
            var moreInfoViewController: GuidesWebViewController = segue.destinationViewController as GuidesWebViewController
            
            //Pass the data object to the destination view controller object
            moreInfoViewController.champ = champ
            
            
        }
        if segue.identifier == "Counter" {
            
            //Obtain the object reference of the destination view controller
            var moreInfoViewController: CounterWebViewController = segue.destinationViewController as CounterWebViewController
            
            //Pass the data object to the destination view controller object
            moreInfoViewController.champ = champ
            
            
        }
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