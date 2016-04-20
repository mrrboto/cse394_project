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
    
    @IBOutlet weak var goodTable: UITableView!
   
    
    var place:GoodData? = nil
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(),managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return dataViewController
        
    }
    
    func listFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "GoodData")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //green background for page
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
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.goodTable.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections  = dataViewController.sections?.count
        return numberOfSections!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = dataViewController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //add custom table view and change PlaceTableViewCell
        let cell = self.goodTable.dequeueReusableCellWithIdentifier("goodCell", forIndexPath: indexPath) as! CellView
        let placeInfo = dataViewController.objectAtIndexPath(indexPath) as! GoodData
        
        var name = placeInfo.name
        var descript = placeInfo.descript
        var pic = placeInfo.pic
        
        cell.goodName.text = name
        cell.goodImage.image = UIImage(data: pic!)
        
        return cell
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! GoodData
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goodView"
        {
            let cell = sender as! UITableViewCell
            let indexPath = self.goodTable.indexPathForCell(cell)
            
            //change DetailViewController to "Good" class
            let dest: GoodView =  segue.destinationViewController as! GoodView
            let row = dataViewController.objectAtIndexPath(indexPath!) as! GoodData
            dest.nItem = row
            
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
