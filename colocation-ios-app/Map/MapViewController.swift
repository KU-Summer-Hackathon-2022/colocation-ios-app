//
//  MapViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import MapKit
import SnapKit
import RxSwift

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        locationManager.startUpdatingLocation()
        
        addAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지 퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
        addAnnotation(latitudeValue: 37.5433183958374, longitudeValue: 127.08835455546703, delta: 0.1, title: "자취방", subtitle: "서울시 광진구 자양로 30길 63")
    }
    
    func setupViews() {
        [mapView].forEach { view.addSubview($0) }
        mapView.delegate = self
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MapViewController {
    
    /// 위도와 경도로 원하는 위치를 표시하고, 위치를 반환
    func goLocation(
        latitudeValue: CLLocationDegrees,
        longitudeValue: CLLocationDegrees,
        delta span: Double
    ) -> CLLocationCoordinate2D {
        
        let location = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region = MKCoordinateRegion(center: location, span: spanValue)
        
        mapView.setRegion(region, animated: true)
        
        return location
    }
    
    /// 위치가 업데이트 되었을 때 지도에 나타내기 위한 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        _ = goLocation(
            latitudeValue: location.coordinate.latitude,
            longitudeValue: location.coordinate.longitude,
            delta: 0.01
        )
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error -> Void in
            let placemark = placemarks?.first
            let country = placemark?.country
            var address: String = country!
            if placemark?.locality != nil {
                address += " "
                address += placemark!.thoroughfare!
            }
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    /// 어노테이션을 추가
    func addAnnotation(
        latitudeValue: CLLocationDegrees,
        longitudeValue: CLLocationDegrees,
        delta span: Double,
        title: String,
        subtitle: String
    ) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect:: \(mapView)")
    }
}
