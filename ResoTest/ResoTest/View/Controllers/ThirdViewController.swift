//
//  DetailViewController.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 13.07.2022.
//

import UIKit
import MapKit
import CoreLocation

class ThirdViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: Class properties:
    private let viewModel       = ThirdViewViewModel()
    private var initialLocation = CLLocation(latitude: 55.80945, longitude: 37.95806)
    private let button          = UIButton()
    private let map             = MKMapView()
    private let detailView      = UIView()
    let name                    = UILabel()
    let adress                  = UILabel()
    let numbers                 = UILabel()
    let workTime                = UILabel()
    let days                    = UITextView()
    private let shadow          = UIView()
    var latitude                = 0.0
    var longtitude              = 0.0
    
    // MARK: View lifecycles events:
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        view.backgroundColor = .white
        view.addSubview(map)
        view.addSubview(button)
        view.addSubview(name)
        view.addSubview(adress)
        view.addSubview(numbers)
        view.addSubview(workTime)
        view.addSubview(days)
        
        initialLocation = CLLocation(latitude: self.latitude, longitude: self.longtitude)
        
        setupMap()
        setupName()
        setupAdress()
        setupButton()
        setupNumbers()
        setupWorkTime()
        setupDays()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        viewModel.getCurrentLocation()
        map.centerToLocation(initialLocation)
    }
    override func viewDidAppear(_ animated: Bool) {
        map.addShadow(to: [.top], radius: CGFloat(100.0))
        map.addShadow(to: [.bottom], radius: CGFloat(1.0), opacity: 0.1)
    }
    
    // MARK: Setup UI:
    private func setupName() {
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 20).isActive = true
        name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
        name.heightAnchor.constraint(equalToConstant: 20).isActive = true
        name.font = UIFont.boldSystemFont(ofSize: 20.0)
    }
    private func setupAdress() {
        adress.translatesAutoresizingMaskIntoConstraints = false
        adress.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        adress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        adress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        adress.heightAnchor.constraint(equalToConstant: 20).isActive = true
        adress.adjustsFontSizeToFitWidth = true
    }
    private func setupNumbers() {
        numbers.translatesAutoresizingMaskIntoConstraints = false
        numbers.topAnchor.constraint(equalTo: adress.bottomAnchor, constant: 25).isActive = true
        numbers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        numbers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        numbers.heightAnchor.constraint(equalToConstant: 20).isActive = true
        numbers.font = UIFont.boldSystemFont(ofSize: 16.0)
        numbers.adjustsFontSizeToFitWidth = true
        
    }
    private func setupWorkTime() {
        workTime.text = "Режим работы"
        workTime.translatesAutoresizingMaskIntoConstraints = false
        workTime.topAnchor.constraint(equalTo: numbers.bottomAnchor, constant: 25).isActive = true
        workTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        workTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
        workTime.heightAnchor.constraint(equalToConstant: 10).isActive = true
        workTime.font = UIFont.systemFont(ofSize: 14)
        workTime.textColor = .lightGray
    }
    private func setupDays() {
        days.translatesAutoresizingMaskIntoConstraints = false
        days.topAnchor.constraint(equalTo: workTime.bottomAnchor, constant: 0).isActive = true
        days.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        days.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        days.heightAnchor.constraint(equalToConstant: 100).isActive = true
        days.font = UIFont.systemFont(ofSize: 16)
    }
    private func setupMap() {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        let mapHeight = screenHeight/2.2
        
        map.translatesAutoresizingMaskIntoConstraints = false
        map.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        map.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        map.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        map.heightAnchor.constraint(equalToConstant: mapHeight).isActive = true
        
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
        let officeMark = OfficeMarkModel(title: name.text, adress: adress.text, coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longtitude))
        
        map.addAnnotation(officeMark)
        
        


        

    }
    private func setupDetailView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 0).isActive = true
        detailView.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 0).isActive = true
        detailView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        
        detailView.backgroundColor = .systemBlue
        
        
    }
    private func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let buttonHeight = 70
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)).isActive = true
        
        button.backgroundColor = #colorLiteral(red: 0.4817662239, green: 0.1368521452, blue: 0.6649298668, alpha: 1)
        button.setTitle("Позвонить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       get {
          return .portrait
       }
    }
    
    // MARK: UI action handling:
    @objc func buttonPressed() {
        print("button pressed")
        viewModel.getPhoneNumber(inputString: numbers.text ?? "")
        if let url = URL(string: ("tel:" + viewModel.phoneNumber.value)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }

    }
    
    // MARK: UI binding with ViewModel:
    func bindViewModel() {

    }
        
}
// MARK: MKMapView centered to initial location and zoom:
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}



