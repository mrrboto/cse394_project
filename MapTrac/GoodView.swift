//
//  GoodView.swift
//  MapTrac
//
//  Created by user on 4/19/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class GoodView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeMap: MKMapView!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placeDescript: UITextView!
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let insertContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var viewContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var nItem:GoodData? = nil
    
    //map items from CLLocationManger
    var currentLocation = CLLocation()
    var locManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "green_bg.png")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        if nItem != nil {
            
            placeName.text = nItem?.name
            placeDescript.text = nItem?.descript
            placeImage.image = UIImage(data: (nItem?.pic)!)
        }
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.distanceFilter = kCLDistanceFilterNone
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        placeMap.setUserTrackingMode(.Follow, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
        print("location updated: \(currentLocation.coordinate.latitude)")
        
        locManager.stopUpdatingLocation()
        
        print("SOMETHING \(currentLocation.coordinate.latitude)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("failed with error")
    }
    
    @IBAction func addImage(sender: UIButton) {
    
        let photoPicker = UIImagePickerController ()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        
        // display image selection view
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    @IBAction func saveData(sender: UIBarButtonItem) {
    
        //add catch for no image + address section
        if nItem == nil
        {
            let context = self.context
            let ent = NSEntityDescription.entityForName("GoodData", inManagedObjectContext: context)
            
            let nItem = GoodData(entity: ent!, insertIntoManagedObjectContext: context)
            let imageData = UIImagePNGRepresentation(placeImage.image!)
            nItem.name = placeName.text!
            nItem.descript = placeDescript.text!
            nItem.pic = imageData!
            
            do {
                try context.save()
            } catch _ {
            }
        }else
        {
            nItem!.name = placeName.text!
            nItem!.descript = placeDescript.text!
            nItem!.pic = UIImagePNGRepresentation(placeImage.image!)
            do {
                try context.save()
            } catch _ {
            }
        }
        
        navigationController!.popViewControllerAnimated(true)
        
    }
    
    @IBAction func cancelData(sender: AnyObject) {
    navigationController!.popViewControllerAnimated(true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        placeImage.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
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
