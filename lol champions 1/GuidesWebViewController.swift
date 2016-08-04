//
//  GuidesWebViewController.swift
//  lol champions 1
//
//  Created by Supratim Baruah on 12/12/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit

class GuidesWebViewController: UIViewController {

    var champ :String = ""
    //var viewTitle :String = ""
    
    
    @IBOutlet var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = champ + "'s Guides"
        //champ.lowercaseString
        //print(stadiumName)
        // Compose the query URL for Google's map API
        var query = "http://www.lolpro.com/guides/\(champ.lowercaseString)"
        
        /*
        * Convert the URL entered by the user into an NSURL object and store its object
        * reference into the local variable url. An NSURL object represents a URL.
        */
        
        //print(query)
        var url = NSURL(string: query)
        
        /*
        * Convert the NSURL object into an NSURLRequest object and store its object
        * reference into the local variable request. An NSURLRequest object represents
        * a URL load request in a manner independent of protocol and URL scheme.
        */
        var request = NSURLRequest(URL: url!)
        
        // Ask the web view object to display the web page for the URL entered by the user.
        web.loadRequest(request)
        
    }
    
    /******************************************************************************************
    * UIWebView Delegate Methods: These methods must be implemented whenever UIWebView is used.
    ******************************************************************************************/
    
    func webViewDidStartLoad(webView: UIWebView!) {
        // Starting to load the web page. Show the animated activity indicator in the status bar
        // to indicate to the user that the UIWebVIew object is busy loading the web page.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView!) {
        // Finished loading the web page. Hide the activity indicator in the status bar.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        /*
        Ignore this error if the page is instantly redirected via javascript or in another way.
        NSURLErrorCancelled is returned when an asynchronous load is cancelled, which happens
        when the page is instantly redirected via javascript or in another way.
        */
        if error.code == NSURLErrorCancelled {
            return
        }
        
        // An error occurred during the web page load. Hide the activity indicator in the status bar.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        // Create the error message in HTML as a character string and store it into the local constant errorString
        let errorString = "<html><font size=+2 color='red'><p>An error occurred: <br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>" + error.localizedDescription
        
        // Display the error message within the UIWebView object
        web.loadHTMLString(errorString, baseURL: nil)
    }
    
}
