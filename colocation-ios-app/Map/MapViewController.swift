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
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    let serverRooms: [Room] = Room.makeServerRooms()
    var annotationId: String = ""
    
    // MARK: - Views
    let mapView = MKMapView()
    let listButton = UIButton()
    let mypageButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
        
        locationManager.startUpdatingLocation()
        
        setupAnnotation()
    }
    
    /// serverRooms 정보를 가지고 어노테이션을 설정
    func setupAnnotation() {
        serverRooms.forEach { room in
            let latitudeValue: Double = Double(room.latitudeValue)!
            let longitudeValue: Double = Double(room.longitudeValue)!
            addAnnotation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: 0.1, title: room.address, subtitle: room.type)
        }
    }
    
    func setupViews() {
        [mapView].forEach { view.addSubview($0) }
        [listButton, mypageButton].forEach { mapView.addSubview($0) }
        
        mapView.delegate = self
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // MARK: - mypageButton
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        var image = UIImage(systemName: "person.circle", withConfiguration: imageConfig)
        
        mypageButton.setImage(image, for: .normal)
        mypageButton.setTitleColor(.darkGray, for: .normal)
        mypageButton.backgroundColor = ColorSet.AppColor.secondary
        mypageButton.tintColor = ColorSet.AppColor.tertiary
        
        mypageButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(50)
        }
        mypageButton.layer.cornerRadius = 25
        mypageButton.clipsToBounds = true
        
        
        // MARK: - listButton
        imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        image = UIImage(systemName: "list.triangle", withConfiguration: imageConfig)
        
        listButton.setImage(image, for: .normal)
        listButton.setTitleColor(.darkGray, for: .normal)
        listButton.backgroundColor = ColorSet.AppColor.secondary
        listButton.tintColor = ColorSet.AppColor.tertiary
        listButton.snp.makeConstraints {
            $0.top.equalTo(mypageButton.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(50)
        }
        listButton.layer.cornerRadius = 25
        listButton.clipsToBounds = true
        
    }
    
    func bind() {
        listButton.rx.tap
            .bind { [weak self] _ in
                self?.showRoomTableViewController()
            }
            .disposed(by: disposeBag)
        
        mypageButton.rx.tap
            .bind { [weak self] _ in
                self?.showMyPageTableViewController()
            }
            .disposed(by: disposeBag)
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
        let annotation = view.annotation!
        
        serverRooms.forEach { room in
            if room.address == annotation.title {
                annotationId = room.id
            }
        }
        mapView.setCenter(annotation.coordinate, animated: true)
        showWebViewController("https://shareroof.netlify.app/houses/\(annotationId)")
    }    
}
