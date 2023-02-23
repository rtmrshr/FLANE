//
//  MapViewController.swift
//  flane
//
//  Created by  ratmir on 22.02.2023.
//

import UIKit
import MapboxMaps


class MapViewController: UIViewController, LocationPermissionsDelegate, LocationConsumer {



    private var mapView: MapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MapView(frame: view.bounds)

        mapView.location.delegate = self
        mapView.location.options.activityType = .other
        mapView.location.options.puckType = .puck2D()
        mapView.location.locationProvider.startUpdatingLocation()

        let locationCoordinate = mapView.location.latestLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)

            mapView.mapboxMap.setCamera(to: CameraOptions(center: locationCoordinate, zoom: 4))
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(mapView)

        mapView.mapboxMap.onNext(event: .mapLoaded) { [self]_ in
                   self.locationUpdate(newLocation: mapView.location.latestLocation!)
               }

    }

    func locationUpdate(newLocation: Location) {
        mapView.camera.fly(to: CameraOptions(center: newLocation.coordinate, zoom: 14), duration: 3)
    }

}






























//public class MapViewController: UIViewController {
//
//    private var mapView: MapView!
//    private var cameraLocationConsumer: CameraLocationConsumer!
////    private lazy var toggleBearingImageButton = UIButton(frame: .zero)
//    private lazy var styleToggle = UISegmentedControl(items: Style.allCases.map(\.name))
//    private var style: Style = .streets {
//        didSet {
//            mapView.mapboxMap.style.uri = style.uri
//        }
//    }
//    private var showsBearingImage: Bool = false {
//        didSet {
////            syncPuckAndButton()
//        }
//    }
//
//    private enum Style: Int, CaseIterable {
//        var name: String {
//            switch self {
//            case .light:
//                return "Light"
//            case .satelliteStreets:
//                return "Satelite"
//            case .customUri:
//                return "Custom"
//            case .streets:
//                return "Streets"
//            }
//        }
//
//        var uri: StyleURI {
//            switch self {
//            case .light:
//                return .light
//            case .streets:
//                return .streets
//            case .satelliteStreets:
//                return .satelliteStreets
//            case .customUri:
//                let localStyleURL = Bundle.main.url(forResource: "blueprint_style", withExtension: "json")!
//                return .init(url: localStyleURL)!
//            }
//        }
//
//        case light
//        case satelliteStreets
//        case customUri
//        case streets
//    }
//
//    override public func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Set initial camera settings
//        let options = MapInitOptions(styleURI: style.uri)
//
//        mapView = MapView(frame: view.bounds, mapInitOptions: options)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(mapView)
//
//        addStyleToggle()
//
//        // Setup and create button for toggling show bearing image
////        setupToggleShowBearingImageButton()
//
//        cameraLocationConsumer = CameraLocationConsumer(mapView: mapView)
//
//        // Add user position icon to the map with location indicator layer
//        mapView.location.options.puckType = .puck2D()
//
//        // Allows the delegate to receive information about map events.
//        mapView.mapboxMap.onNext(event: .mapLoaded) { [weak self] _ in
//            guard let self = self else { return }
//            // Register the location consumer with the map
//            // Note that the location manager holds weak references to consumers, which should be retained
//            self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
//
//            self.cameraLocationConsumer.locationUpdate(newLocation: self.mapView.location.latestLocation!)
//
//        }
//    }
//
//
//    @objc func showHideBearingImage() {
//        showsBearingImage.toggle()
//    }
//
////    func syncPuckAndButton() {
////        // Update puck config
////        let configuration = Puck2DConfiguration.makeDefault(showBearing: showsBearingImage)
////
////        mapView.location.options.puckType = .puck2D(configuration)
////
////        // Update button title
////        let title: String = showsBearingImage ? "Hide bearing image" : "Show bearing image"
////        toggleBearingImageButton.setTitle(title, for: .normal)
////    }
//
////    private func setupToggleShowBearingImageButton() {
////        // Styling
////        toggleBearingImageButton.backgroundColor = .systemBlue
////        toggleBearingImageButton.addTarget(self, action: #selector(showHideBearingImage), for: .touchUpInside)
////        toggleBearingImageButton.setTitleColor(.white, for: .normal)
////        toggleBearingImageButton.layer.cornerRadius = 4
////        toggleBearingImageButton.clipsToBounds = true
////        toggleBearingImageButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
////
////        toggleBearingImageButton.translatesAutoresizingMaskIntoConstraints = false
////        view.addSubview(toggleBearingImageButton)
////
////        // Constraints
////        toggleBearingImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
////        toggleBearingImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
////        toggleBearingImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70.0).isActive = true
////
////        syncPuckAndButton()
////    }
//
//    @objc func switchStyle(sender: UISegmentedControl) {
//        style = Style(rawValue: sender.selectedSegmentIndex) ?? . streets
//    }
//
//    func addStyleToggle() {
//        // Create a UISegmentedControl to toggle between map styles
//        styleToggle.selectedSegmentIndex = style.rawValue
//        styleToggle.addTarget(self, action: #selector(switchStyle(sender:)), for: .valueChanged)
//        styleToggle.translatesAutoresizingMaskIntoConstraints = false
//
//        // set the segmented control as the title view
//        navigationItem.titleView = styleToggle
//    }
//}
//
//// Create class which conforms to LocationConsumer, update the camera's centerCoordinate when a locationUpdate is received
//public class CameraLocationConsumer: LocationConsumer {
//    weak var mapView: MapView?
//
//    init(mapView: MapView) {
//        self.mapView = mapView
//    }
//
//    public func locationUpdate(newLocation: Location) {
//        mapView?.camera.ease(
//            to: CameraOptions(center: newLocation.coordinate, zoom: 15), duration: 0)
//    }
//}
//
//
