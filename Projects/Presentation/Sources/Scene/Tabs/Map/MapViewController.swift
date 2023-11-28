import UIKit
import SharingKit
import MapKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import FloatingPanel
import Core
import CoreLocation

public class MapViewController: BaseVC<MapViewModel> {

    private let searchPost = PublishRelay<(keyword: String, x: Double, y: Double)>()
    private let fetchSurroundingPost = PublishRelay<(x: Double, y: Double)>()
    private let dismissPostDetail = PublishRelay<Void>()

    private let locationManager = CLLocationManager() // 자기 위치 표시
    private let mapView = CoustomMapView()
    private let mapPostVC: MapPostViewController
    private let postSheetController = FloatingPanelController()
    
    private let searchBar = SearchBarTextField().then {
        $0.placeholder = "게시글 검색"
        $0.layer.cornerRadius = 25
    }

    private let detailBackButton = UIButton(type: .system).then {
        let image = UIImage(
            systemName: "arrow.left",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        )
        $0.setImage(image, for: .normal)
        $0.tintColor = .black900
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .white
        $0.setShadow()
        $0.isHidden = true
    }

    private let writePostButton = GradationButton(type: .system).then {
        $0.layer.cornerRadius = 35
        $0.setImage(.pencil.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    public init(viewModel: MapViewModel, mapPostVC: MapPostViewController) {
        self.mapPostVC = mapPostVC
        super.init(viewModel: viewModel)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_ animated: Bool) {
        guard let location = locationManager.location?.coordinate else { return }
        fetchSurroundingPost.accept((x: location.longitude, y: location.latitude))
    }

    public override func attribute() {
        mapView.delegate = self
        locationManager.delegate = self
        postSheetController.delegate = self
        settingDissmissGesture(target: [mapPostVC.view])

        locationSetting()
        postBottomSeetSetting()

        postSheetController.show(animated: true)
    }

    public override func bind() {
        let input = MapViewModel.Input(
            writePostButtonDidClick: writePostButton.rx.tap.asObservable(),
            selectItem: nil,
            fetchSurroundingPost: fetchSurroundingPost.asObservable(),
            dismissPostDetail: dismissPostDetail.asObservable(),
            createChatRoom: nil,
            applicationVolunteer: nil,
            searchPost: searchPost.asObservable()
        )
        let output = viewModel.transform(input: input)

        searchBar.searchButton.rx.tap
            .throttle(.milliseconds(800), latest: false, scheduler: MainScheduler.instance)
            .bind(with: self, onNext: { owner, _ in
                guard let location = owner.locationManager.location?.coordinate else { return }
                owner.searchPost.accept(
                    (
                        keyword: owner.searchBar.text ?? "",
                        x: location.longitude,
                        y: location.latitude
                    )
                )
                owner.postSheetController.move(to: .full, animated: true)
            })
            .disposed(by: disposeBag)

        detailBackButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.detailBackButton.isHidden = true
                    owner.searchBar.isHidden = false
                    owner.dismissPostDetail.accept(())
                }
            )
            .disposed(by: disposeBag)

        output.surroundPostData.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.mapView.removeAnnotations(owner.mapView.annotations)
                    data.forEach {
                        let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(
                            latitude: $0.latitude,
                            longitude: $0.longitude
                        ))
                        owner.mapView.addAnnotation(annotation)
                    }
                }
            )
            .disposed(by: disposeBag)

        output.postDetailData.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.searchBar.isHidden = true
                    owner.detailBackButton.isHidden = false
                    let location: CLLocationCoordinate2D = .init(
                        latitude: data.y,
                        longitude: data.x
                    )
                    owner.mapView.setRegion(
                        .init(center: location, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)),
                        animated: true
                    )
                    owner.postSheetController.move(to: .half, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            mapView,
            detailBackButton,
            searchBar,
            postSheetController.view,
            writePostButton
        ].forEach { view.addSubview($0) }
        addChild(postSheetController)
    }

    public override func setLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        detailBackButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.left.equalToSuperview().inset(15)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        postSheetController.view.snp.makeConstraints {
            $0.height.greaterThanOrEqualToSuperview()
            $0.left.right.equalToSuperview()
        }
        searchBar.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(25)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        writePostButton.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationSetting() {
        guard let location = locationManager.location?.coordinate else { return }
        mapView.setRegion(.init(center: location, span: .init(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
        locationManager.requestWhenInUseAuthorization()
    }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        case .notDetermined, .restricted:
            locationSetting()
        case .denied:
            locationSetting()
        @unknown default:
            debugPrint("‼️ GPS: Defalte")
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }

        var annotationView: MKAnnotationView?

        if let customAnnotation = annotation as? CustomAnnotation {
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(CoustomAnnotationView.self), for: customAnnotation)
        }

        return annotationView
    }
}

extension MapViewController: FloatingPanelControllerDelegate {
    private func postBottomSeetSetting() {
        let surfaceAppearance = SurfaceAppearance()
        surfaceAppearance.cornerRadius = 20
        postSheetController.surfaceView.appearance = surfaceAppearance
        postSheetController.set(contentViewController: mapPostVC)
        postSheetController.isRemovalInteractionEnabled = false
        postSheetController.backdropView.isHidden = true
        postSheetController.layout = MyFloatingPanelLayout()
        postSheetController.track(scrollView: mapPostVC.postTableView)
    }

    public func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        let loc = fpc.surfaceLocation
        let minY = fpc.surfaceLocation(for: .full).y
        let maxY = fpc.surfaceLocation(for: .tip).y
        fpc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else { return }
            if fpc.state != FloatingPanelState.tip {
                mapView.transform = .init(translationX: 0, y: -(view.safeAreaInsets.bottom + 80))
            } else {
                mapView.transform = .identity
            }
        })
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition = .bottom

    var initialState: FloatingPanelState = .tip

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 100.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 80.0, edge: .bottom, referenceGuide: .safeArea),
    ]
}
