//
//  ListViewController.swift
//  MapTrac
//
//  Created by user on 4/22/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, NSFetchedResultsControllerDelegate  {

 
    @IBOutlet weak var tableView: UITableView!
    var listType: String?
    var place:Data? = nil
    var color: String?
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(),managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return dataViewController
        
    }
    
    func listFetchRequest() -> NSFetchRequest {
        
        if (listType == "Good List")
        {
            let list = "good"
            let fetchRequest = NSFetchRequest(entityName: "Data")
            let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescripter]
            fetchRequest.predicate = NSPredicate(format: "list = %@", list)
            return fetchRequest
        }
        
        else
        {
            let list = "bad"
            let fetchRequest = NSFetchRequest(entityName: "Data")
            let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescripter]
            fetchRequest.predicate = NSPredicate(format: "list = %@", list)
            return fetchRequest
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if listType == "Good List"
        {
            color = "good"
        }
        else
        {
            color = "bad"
        }
        self.view.addBackground(color!)
      
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
        self.tableView.reloadData()
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
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath) as! CellView
        let placeInfo = dataViewController.objectAtIndexPath(indexPath) as! Data
            
        var name = placeInfo.name
        var descript = placeInfo.descript
        var pic = placeInfo.pic
        //var lat = placeInfo.lat
        //var lon = placeInfo.lon
            
        cell.cellName.text = name
        cell.cellImage.image = UIImage(data: pic!)
        
        return cell
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
        let record = dataViewController.objectAtIndexPath(indexPath) as! Data
        
            context.deleteObject(record)
            
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "dataView"
        {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)
            let dest: DataView =  segue.destinationViewController as! DataView
   
            let row = dataViewController.objectAtIndexPath(indexPath!) as! Data
            let list = self.listType
            
            dest.nItem = row
            dest.lType = listType
        }
        
        else if segue.identifier == "addData"
        {
            let dest: DataViewEdit =  segue.destinationViewController as! DataViewEdit
            dest.lType = listType
        }
        
    }


}
