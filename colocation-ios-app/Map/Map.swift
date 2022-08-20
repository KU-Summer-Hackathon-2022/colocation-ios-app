//
//  Map.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    let dobongLoc = CLLocationCoordinate2D(latitude: 37.6658609, longitude: 127.0317674) // 도봉구
    let eunpyeongLoc = CLLocationCoordinate2D(latitude: 37.6176125, longitude: 126.9227004) // 은평구
    let dongdaemoonLoc = CLLocationCoordinate2D(latitude: 37.5838012, longitude: 127.0507003) // 동대문구
    
    let initialCoordinate = CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525)
    
    // MARK: - Properteis
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? // 내 위치 저장
    
    // MARK: - Views
    let mapView = MKMapView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        
        setupMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationStatus()
    }
    
    func setupMapView() {
        mapView.delegate = self
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mapView.showsUserLocation = true // 사용자 위치 보기 설정
        
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        mapView.register(
            AnnotationView.self,
            forAnnotationViewWithReuseIdentifier: AnnotationView.identifier
        )
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 최고
        locationManager.requestWhenInUseAuthorization() // 위치 데이터 승인 요구
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        
        
    }
    
    /// 현재 디바이스에서 위치권한에 대한 정보
    func locationStatus() {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("✅ 유저로부터 권한을 획득했어요")
            currentLocation = locationManager.location
            self.locationManager.startUpdatingLocation() // 중요!
        default:
            let alertController = UIAlertController(
                title: "유저의 위치를 받아올 수 없어요.",
                message: "위치 서비스 기능의 꺼져있어요. 설정에서 권한을 변경할 수 있습니다.",
                preferredStyle: .alert
            )
            let confirmAction = UIAlertAction(
                title: "🐕 확인 🐕",
                style: .default
            )
            
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true)
            
            print("🚨 \(#function) 유저의 위치를 사용할 수가 없어요..")
        }
    }
    
    // 해당 위치를 반환
    func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees){
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                var myAdd: String = ""
                if let area: String = address.last?.locality{
                    myAdd += area
                }
                if let name: String = address.last?.name {
                    myAdd += " "
                    myAdd += name
                }
            }
        })
    }
    
    // MARK : 검색한 위치로 이동 & marker 추가
    func setMapView(coordinate: CLLocationCoordinate2D, addr: String){
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta:0.01))
        self.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = addr
        self.mapView.addAnnotation(annotation)
        
        self.findAddr(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else { return nil }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: AnnotationView.identifier,
            for: annotation
        ) as? AnnotationView else { return nil }
        
        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    /// 유저의 위치권한 변경
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("✅ 유저로부터 권한을 획득했어요")
            self.locationManager.startUpdatingLocation() // 중요!
        case .restricted, .notDetermined:
            print("🚨 유저로부터 권한을 얻지 못했어요")
            self.locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("🚨 유저가 거부했어요.")
            self.locationManager.requestWhenInUseAuthorization()
        default:
            print("💭 \(#function) default")
        }
    }
}
