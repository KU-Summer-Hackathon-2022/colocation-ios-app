//
//  Map.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    // 권한이 안뜨면 초기에 허용해두어서 그렇고, plist 수정시 책 256쪽 참고
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocationInfo1.text = "" // 위치 정보를 표시할 레이블
        lblLocationInfo2.text = "" // 위치 정보를 표시할 레이블
        locationManager.delegate = self // 상수 로케이션 메니저의 델리게이트를 셀로프 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치 데이터를 추적하기 위해 사용자에게 승인을 요구하는 코드
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true // 위치 보기 값을 트루로 설정
    }
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var myMap: MKMapView!
    
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.lblLocationInfo1.text = "" // 레이블 초기화
            self.lblLocationInfo2.text = "" // 레이블 초기화
            locationManager.startUpdatingLocation() // 위치 업데이트하는 코드
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 37.73728281049552, longitudeValue: 128.89024026920865, delta: 1, title: "폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121") // 델타 값은 확대비율로 기준이 1이고 이보다 작으면 확대 크면 줌아웃이다.
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "한국 폴리텍대학 강릉캠퍼스"
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지 퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "이지퍼블리싱 출판사"
        } else if sender.selectedSegmentIndex == 3 {
            setAnnotation(latitudeValue: 37.5433183958374, longitudeValue: 127.08835455546703, delta: 0.1, title: "자취방", subtitle: "서울시 광진구 자양로 30길 63")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "자취방"
        }
        
        
    }
    
   
    
    func goLocation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double) -> CLLocationCoordinate2D {
        // 위도와 경도로 원하는 위치를 표시하기 위한 함수
        
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) // 위도 값과 경도 값을 매개변수로 하여 함수호출하여 그것을 받는다.
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 범위 값을 매개변수로 하여 함수를 호출하고 리턴값을 받는다
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // 위의 두 정보를 매개변수로 하여 리턴값을 받는다.
        myMap.setRegion(pRegion, animated: true) // 함수 호출!
        
        return pLocation
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 위치가 업데이트 되었을 때 지도에 위치를 나타내기 위한 함수
        let pLocation = locations.last // 위치가 업데이트 되면 먼저 마지막 위치 값을 찾아낸다
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 마지막 위치의 위도와 경도 값을 가지고 앞에서 만든 goLocation 함수를 호출한다. 이때 delta 값은 지도의 크기를 정하는데, 값이 작을수록 확대되는 효과가 있습니다. delta 0.01로 하였으니 1의 값보다 지도를 100배로 확대해소 보여줄 것입니다. _ 표시는 워닝이나 에러를 막기 위한 코드
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            /*
             플레이스 마크 값의 첫 부분만 pm상수로 받는다.
             country 나라
             locality 지역
             thoroughfare 도로
             
             나라 지역 도로 --> 공백넣어 읽기 쉽게하기
             */
            
            (placemarks, error) -> Void in
            let pm = placemarks!.first // 플레이스마크 값의 첫 부분만 pm상수로 대입한다
            let country = pm!.country // pm상수에서 나라 값을 컨트로 상수에 대입
            var address: String = country! // 문자열 address에 country 상수의 값을 대입합니다.
            if pm!.locality != nil { // pm 상수에서 도로 값이 존재하면 adress 문자열에 추가합니다
                address += " " // 공백넣어서 읽기 쉽게 하려고.
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재위치"
            self.lblLocationInfo2.text = address
            
        }) // 위도와 경도값을 갖고 역으로 주소를 찾아보겠다. 핸들러의 익명함수를 추가로 준비해고 익명함수로 처리한다
        
        locationManager.stopUpdatingLocation() // 마지막으로 위치가 업데이트되는 것을 멈추게 한다.
    }
    
    func setAnnotation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double, title strTitle : String, subtitle strSubtitle : String) {
        let annotation = MKPointAnnotation() // 핀을 설취하기 위해 mk포인트어노테이션 함수 호출하여 리턴 값을 받는다.
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span) // 어노테이션의 쿠디네이트 값을 고로케이션 함수로부터 2D형태로 받어야하는데, 이를 위해서는 goLocation 함수에 리턴값이 있게 수정해야 한다.
        
        //annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle // 핀의 타이틀
        annotation.subtitle = strSubtitle // 핀의 서브타이틀
        myMap.addAnnotation(annotation) // 맵 뷰에 변수 어노테이션 값을 추가
        
    }

    
}
