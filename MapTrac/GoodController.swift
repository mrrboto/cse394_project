//
//  GoodController.swift
//  MapTrac
//
//  Created by user on 4/16/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import UIKit
import CoreData

class GoodController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var placeTable: UITableView!
    
    var place:Place? = nil
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return dataViewController
        
    }
    
    func listFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Place")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "green_bg.png")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        dataViewController = getFetchResultsController()
        
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
        } catch _ {
        }
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
