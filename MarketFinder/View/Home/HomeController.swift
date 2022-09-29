//
//  HomeController.swift
//  MarketFinder
//
//  Created by User on 2022/08/09.
//

import UIKit
import NMapsMap
import Alamofire
import RxSwift
import RxCocoa
import CoreLocation

struct Market: Decodable {
    let martCode:Int
    let name:String
    let number:String
    let lat:Double
    let lng:Double

    // 위경도를 NMGLatLng 형식으로 변환
    func convertNMGLatLng() -> NMGLatLng {
        return NMGLatLng(lat: self.lat, lng: self.lng)
    }
    
    // 마커 생성
    func createMarker() -> NMFMarker {
        return NMFMarker(position: convertNMGLatLng(), iconImage: NMFOverlayImage(image: UIImage.image(image: .homeplus)))
    }
}

enum MarketOpenStatus {
    case open, close
}

class HomeController: BaseController {
    
    // MARK: - Properties
    private lazy var mapView:NMFMapView = NMFMapView(frame: self.view.frame)
    
    private let manager:CLLocationManager = CLLocationManager()
    
    private let marker:NMFMarker = NMFMarker(position: NMGLatLng(lat: 37.3592, lng: 127.1048), iconImage: NMFOverlayImage(image: UIImage.image(image: .homeplus)))
    
    private let infoWindow = NMFInfoWindow()
    
    private let menuButton:BaseButton = BaseButton(fontIcon: .alignJustify, style: .solid, fontSize: 25)
    
    private let filterButton:BaseButton = {
        let button:BaseButton = BaseButton(fontIcon: .filter, style: .solid, fontSize: 25)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private let myLocationButton:BaseButton = {
        let button:BaseButton = BaseButton(fontIcon: .crosshairs, style: .solid, fontSize: 25)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private var isShowingMenuOb:BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    private lazy var handler = { [weak self] (overlay: NMFOverlay) -> Bool in
        guard let marker:NMFMarker = overlay as? NMFMarker,
                let self:HomeController = self else { return true }
        
        self.martInfoView.isHidden = false
        
        return true
    }
    
    private let martInfoView:MartInfoView = MartInfoView()
    
    private let notSupportServiceView:NotSupportServiceView = NotSupportServiceView()
    
    private let requestLocationView:RequestLocationView = RequestLocationView()
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.view.addSubviews(views: [
            self.mapView
        ])
        
        self.martInfoView.isHidden = true
        self.mapView.touchDelegate = self
        
        self.notSupportServiceView.isHidden = true
        
        self.marker.mapView = mapView
        self.marker.touchHandler = self.handler
        
        self.view.addSubviews(views: [
            self.menuButton,
            self.filterButton,
            self.myLocationButton,
            self.martInfoView,
            self.notSupportServiceView,
            self.requestLocationView
        ])
        
        self.setupLayouts()
        
        self.bindUI()

//        let dataSource:NMFInfoWindowDefaultTextSource = NMFInfoWindowDefaultTextSource.data()
//
//        dataSource.title = "정보 창 내용"
//        infoWindow.dataSource = dataSource

//        self.fetchMarketInfo()
//            .flatMap { (markets:[Market]) -> Observable<[NMFMarker]> in
//                return .just(markets.map { $0.createMarker()} )
//            }
//            .asDriver(onErrorJustReturn: [])
//            .drive(onNext: { (markers:[NMFMarker]) in
//                for marker in markers {
//                    marker.mapView = self.mapView
//                    marker.
//                }
//            }).disposed(by: self.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        self.myLocationButton.rx.tap
            .compactMap { self.manager.location?.coordinate }
            .map { NMGLatLng(lat: $0.latitude, lng: $0.longitude) }
            .flatMap({ (latLng:NMGLatLng) -> Observable<NMFCameraUpdate> in
                let camera:NMFCameraUpdate = NMFCameraUpdate(scrollTo: latLng, zoomTo: 15)
                camera.animation = .fly
                
                return .just(camera)
            })
            .bind { (camera:NMFCameraUpdate) in
                self.mapView.moveCamera(camera)
            }.disposed(by: self.disposeBag)
        
        self.menuButton.rx.tap
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { _ in
                let menuController:MenuController = MenuController()
                menuController.modalTransitionStyle = .crossDissolve
                menuController.modalPresentationStyle = .overFullScreen
                self.present(menuController, animated: true, completion: nil)
            }).disposed(by: self.disposeBag)
    }
    
    func fetchMarketInfo() -> Observable<[Market]> {
        return Observable.create { (observer:AnyObserver) -> Disposable in
            AF.request("").responseDecodable(of: [Market].self) { (response) in
                switch response.result {
                    case .success(let market):
                        observer.onNext(market)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.menuButton.widthAnchor.constraint(equalToConstant: 50),
            self.menuButton.heightAnchor.constraint(equalTo: self.menuButton.widthAnchor),
            self.menuButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            self.menuButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            self.filterButton.widthAnchor.constraint(equalToConstant: 50),
            self.filterButton.heightAnchor.constraint(equalTo: self.filterButton.widthAnchor),
            self.filterButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25),
            self.filterButton.bottomAnchor.constraint(equalTo: self.myLocationButton.topAnchor, constant: -15),
            
            self.myLocationButton.widthAnchor.constraint(equalToConstant: 50),
            self.myLocationButton.heightAnchor.constraint(equalTo: self.myLocationButton.widthAnchor),
            self.myLocationButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25),
            self.myLocationButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            
            self.martInfoView.heightAnchor.constraint(equalToConstant: 225),
            self.martInfoView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.martInfoView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.martInfoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 25),
            
            self.notSupportServiceView.heightAnchor.constraint(equalToConstant: 225),
            self.notSupportServiceView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.notSupportServiceView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.notSupportServiceView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 25),
            
            self.requestLocationView.heightAnchor.constraint(equalToConstant: 275),
            self.requestLocationView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.requestLocationView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.requestLocationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 25)
        ])
    }
}

extension HomeController: NMFMapViewTouchDelegate {
    
    // 맵 터치 시
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        if !self.martInfoView.isHidden {
            self.martInfoView.isHidden = true
        }
    }
}
