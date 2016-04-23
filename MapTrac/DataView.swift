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

class DataView: UIViewController, MKMapViewDelegate {
    

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeMap: MKMapView!
    @IBOutlet weak var placeDescript: UITextView!

    
    var nItem:Data? = nil
    var lType: String?
    var color: String?
    
    var lat: String?
    var lon: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lat = nItem?.lat
        lon = nItem?.lon
    
        let location: CLLocation = CLLocation(latitude: Double(lat!)!,
                                              longitude: Double(lon!)!)
        
        //print(lType)
        //print(nItem?.lat)
        //print(nItem?.lon)
        
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
        
        getDirections(location)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDirections(sender: AnyObject) {
        
        
    let location = (sender)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location as! CLLocation, completionHandler: { (placemarks, error) -> Void in
            if let placemark = placemarks?[0]  {
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.placeMap.setRegion(region, animated: true)
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                ani.title = self.placeName.text
                
                self.placeMap.addAnnotation(ani)
            }
        })
    }
    




}
