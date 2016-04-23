//
//  ViewController.swift
//  MapTrac
//
//  Created by user on 4/13/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func listChoice(sender: AnyObject) {
    performSegueWithIdentifier("listViewSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "listViewSegue"){
            let next = segue.destinationViewController as! ListViewController
            
            next.listType = (sender!.tag == 0) ? "Good List" : "Bad List"
            //next.locations = self.locations
        }
    }

}

