//
//  Annotation.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import MapKit
import UIKit

class Annotation: NSObject, MKAnnotation {
    /// 식당 ID
    var restaurantID: Int
    
    /// AnotationType
    var type: AnnotationType
    
    /// 좌표
    var coordinate: CLLocationCoordinate2D
    
    /// 선택 유무
    var isSelected: Bool
    
    init(
        restaurantID: Int,
        coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525),
        type: AnnotationType
    ) {
        self.restaurantID = restaurantID
        self.coordinate = coordinate
        self.type = type
        self.isSelected = false
    }
    
    enum AnnotationType {
        case yellow
        case red
    }
}

