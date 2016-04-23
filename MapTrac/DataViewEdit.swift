//
//  DataView.swift
//  MapTrac
//
//  Created by user on 4/22/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class DataViewEdit: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeMap: MKMapView!
    @IBOutlet weak var placeDescript: UITextView!
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let insertContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var viewContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var nItem:Data? = nil
    var lType: String?
    var color: String?
    
    //map items from CLLocationManger
    var currentLocation = CLLocation()
    var locManager = CLLocationManager()
    let imagePicker = UIImagePickerController()
    var textFieldHasBeenEdited = false
    var textViewHasBeenEdited = false
    
    var lat: Double?
    var lon: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(lType)
        if lType == "Good List"
        {
            color = "good"
        }
        else
        {
            color = "bad"
        }
  
        self.view.addBackground(color!)
      
        if nItem != nil {
            
            placeName.text = nItem?.name
            placeDescript.text = nItem?.descript
            placeImage.image = UIImage(data: (nItem?.pic)!)
        }
        imagePicker.delegate = self
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.distanceFilter = kCLDistanceFilterNone
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        placeMap.setUserTrackingMode(.Follow, animated: true)
        askUserForImage()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        placeName.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textFieldHasBeenEdited == false)
        {
            placeName.text = ""
            textFieldHasBeenEdited = true
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.view.frame.origin.y -= 150
        
        if (textViewHasBeenEdited == false)
        {
            placeDescript.text = ""
            textViewHasBeenEdited = true
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.view.frame.origin.y += 150
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
        print("location updated: \(currentLocation.coordinate.latitude)")
        lat = currentLocation.coordinate.latitude
        lon = currentLocation.coordinate.longitude
        
        locManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("failed with error")
    }
    
    
    @IBAction func addImage(sender: AnyObject) {
        
        askUserForImage()
    }
    
    func askUserForImage(){
        
        var alertController: UIAlertController?
        
        alertController = UIAlertController(title: "Image Source", message: "Choose the source of the image:", preferredStyle: UIAlertControllerStyle.Alert)
        
        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: UIAlertActionStyle.Default, handler: {action -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.showImagePicker(false)
            })
        })
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {action -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.showImagePicker(true)
            })
        })
        
        alertController?.addAction(photoAlbumAction)
        alertController?.addAction(cameraAction)
        
        alertController?.view.setNeedsLayout()
        
        self.presentViewController(alertController!, animated: true, completion: nil)
        
        print("after alert controller presented")
    }
    
    func showImagePicker(fromCamera: Bool){
        imagePicker.allowsEditing = false
        
        if (fromCamera == true)
        {
            imagePicker.sourceType = .Camera
            imagePicker.cameraCaptureMode = .Photo
            imagePicker.modalPresentationStyle = .FullScreen
        }
        else
        {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            placeImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func saveData(sender: UIBarButtonItem) {
        //add catch for no image + address section
        if nItem == nil
        {
            let context = self.context
            let ent = NSEntityDescription.entityForName("Data", inManagedObjectContext: context)
            
            let nItem = Data(entity: ent!, insertIntoManagedObjectContext: context)
            let imageData = UIImagePNGRepresentation(placeImage.image!)
            nItem.name = placeName.text!
            nItem.descript = placeDescript.text!
            nItem.pic = imageData!
            nItem.lat = String(format: "%f", lat!)
            nItem.lon = String(format: "%f", lon!)
            
            if(lType == "Good List")
            {
                nItem.list = "good"
            }
            else
            {
                nItem.list = "bad"
            }
            
            
            do {
                try context.save()
            } catch _ {
            }
        }else
        {
            nItem!.name = placeName.text!
            nItem!.descript = placeDescript.text!
            nItem!.pic = UIImagePNGRepresentation(placeImage.image!)
            
            nItem!.list = "good"
            do {
                try context.save()
            } catch _ {
            }
        }
        
        navigationController!.popViewControllerAnimated(true)
        
    }
    
    @IBAction func cancelData(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    
}
