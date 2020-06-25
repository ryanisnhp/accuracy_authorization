//
//  ViewController.swift
//  AccuracyAuthorizationLocation
//
//  Created by Nguyen Phat on 6/25/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet private weak var locationStatusLabel: UILabel!
    @IBOutlet private weak var accuracyAuthorizationLabel: UILabel!
    @IBOutlet private weak var coordinatesLabel: UILabel!
    
    @IBOutlet private weak var requestLocationButton: UIButton!
    lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinatesLabel.isHidden = true
        requestLocationButton.setTitle("Request Location", for: .normal)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    
    @IBAction func onRequestLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus()
        switch status {
        case .authorizedAlways:
            locationStatusLabel.text = ".authorizedAlways"
            break
        case .authorizedWhenInUse:
            locationStatusLabel.text = ".authorizedWhenInUse"
            break
        case .denied:
            locationStatusLabel.text = ".denied"
            break
        case .notDetermined:
            locationStatusLabel.text = ".notDetermined"
            break
        case .restricted:
            locationStatusLabel.text = ".restricted"
            break
        default:
            break
        }
        
        let accuracyAuthorization = manager.accuracyAuthorization
        switch accuracyAuthorization {
        case .fullAccuracy:
            accuracyAuthorizationLabel.text = ".fullAccuracy"
            break
        case .reducedAccuracy:
            accuracyAuthorizationLabel.text = ".reducedAccuracy"
            break
        default:
            break
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coorText = "(\(location.coordinate.latitude), \(location.coordinate.longitude))"
        coordinatesLabel.text = coorText
        coordinatesLabel.isHidden = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
}
