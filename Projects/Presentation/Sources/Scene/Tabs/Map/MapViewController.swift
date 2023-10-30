import UIKit
import SharingKit
import MapKit
import SnapKit
import Then
import FloatingPanel

public class MapViewController: BaseVC<MapViewModel> {

    private let locationManager = CLLocationManager() // 자기 위치 표시
    private let mapView = CoustomMapView()
    private let mapPostVC: MapPostViewController
    private let postSheetController = FloatingPanelController()

    private let searchBar = SearchBarTextField().then {
        $0.placeholder = "게시글 검색"
    }

    private let writePostButton = UIButton(type: .system).then {
        $0.setImage(.pencil.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        $0.setBackgroundImage(.writeBackground, for: .normal)
        $0.layer.cornerRadius = 35
    }

    public init(viewModel: MapViewModel, mapPostVC: MapPostViewController) {
        self.mapPostVC = mapPostVC
        super.init(viewModel: viewModel)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        mapView.delegate = self
        locationManager.delegate = self
        postSheetController.delegate = self

        locationSetting()
        postBottomSeetSetting()

        addAnnotation() // dummy
    }

    public override func viewDidAppear(_ animated: Bool) {
        postSheetController.show(animated: true)
        postSheetController.loadViewIfNeeded()
    }

    public override func addView() {
        [
            mapView,
            searchBar,
            postSheetController.view,
            writePostButton
        ].forEach {
            view.addSubview($0)
        }
        addChild(postSheetController)
    }

    public override func setLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        postSheetController.view.snp.makeConstraints {
            $0.height.greaterThanOrEqualToSuperview()
            $0.left.right.equalToSuperview()
        }
        searchBar.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(25)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        writePostButton.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    public override func bind() {
        searchBar.searchButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.postSheetController.move(to: .half, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationSetting() {
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

    // MARK: this function is Dummy Data
    private func addAnnotation() {
        let statueOfLibery = CustomAnnotation(coordinate: CLLocationCoordinate2D(
            latitude: 40.689167,
            longitude: -74.044444
        ))
        let meteoHouse = CustomAnnotation(coordinate: CLLocationCoordinate2D(
            latitude: 36.316941168642,
            longitude: 127.34772361173
        ))
        let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(
            latitude: 36.390906587662,
            longitude: 127.36218898382
        ))

        mapView.addAnnotations([annotation, meteoHouse, statueOfLibery])
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
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition = .bottom

    var initialState: FloatingPanelState = .half

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 120.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 40.0, edge: .bottom, referenceGuide: .safeArea),
    ]
}
