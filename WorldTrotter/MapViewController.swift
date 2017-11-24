//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Carlos Poles on 8/11/17.
//  Copyright © 2017 Carlos Poles. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapMainView: MKMapView!
    
    override func loadView() {
        // create a map view
        mapMainView = MKMapView()
        
        // set it as the view of this view controller
        view = mapMainView
        
        // localized strings for the segmented control
        let standardString = NSLocalizedString("Standard", comment: "Standard Map View")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite Map View")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid Map View")
        
        
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged) // event is the changing the value of the segmented control.
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // add segmented control subview to the view
        view.addSubview(segmentedControl)
        
        // programmatic constraints
        // use anchors between segmented control and the view
        // layout guides
        // add a constraint between the bottom of the topLayout guide
        // and the top of the segmentedControl
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        
        // define margins
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        // activate constraints
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        
        // create button
        let btnCurrentLocation = UIButton(type: .roundedRect)
        btnCurrentLocation.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btnCurrentLocation.setTitleColor(UIColor.white, for: .normal)
        btnCurrentLocation.setTitleColor(UIColor.red, for: .selected)
        let btnTitleString = NSLocalizedString("Current Location", comment: "The user current location.")
        btnCurrentLocation.setTitle(btnTitleString, for: .normal)
        btnCurrentLocation.translatesAutoresizingMaskIntoConstraints = false
        btnCurrentLocation.addTarget(self, action: #selector(MapViewController.mapView(_:didUpdate:)), for: .touchDown)
        view.addSubview(btnCurrentLocation)
        
        let btnTopConstraint = btnCurrentLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        let btnLeadingConstraint = btnCurrentLocation.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let btnTrailingConstraint = btnCurrentLocation.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        btnTopConstraint.isActive = true
        btnLeadingConstraint.isActive = true
        btnTrailingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
        mapMainView.showsUserLocation = true
        
        if let latitude = mapMainView.userLocation.location?.coordinate.latitude {
            print(latitude)
        } else {
            print("no location")
        }
     
    }
    
    
    // MARK: - Delegation
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapMainView.mapType = .standard
        case 1:
            mapMainView.mapType = .hybrid
        case 2:
            mapMainView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
      
        
    }
   
    
}
