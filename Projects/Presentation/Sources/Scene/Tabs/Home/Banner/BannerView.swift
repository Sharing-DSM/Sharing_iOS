import UIKit
import Then
import SnapKit
import SharingKit
import Domain

class BannerView: UIScrollView {

    var bannerCount: Int = 0

    var bannerSetter: [CommonPostEntityElement]? {
        didSet {
            guard let bannerSetter = bannerSetter else { return }
            bannerCount = bannerSetter.count - 2
            bannerStackView.arrangedSubviews.forEach {
                bannerStackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            bannerSetter.forEach {
                let input = BannerContentView()
                input.subTitleLabel.text = $0.title
                input.aderessLabel.text = $0.addressName
                bannerStackView.addArrangedSubview(input)
                input.snp.makeConstraints { $0.width.equalTo(self.snp.width) }
            }
        }
    }

    private let bannerStackView = UIStackView().then {
        $0.axis = .horizontal
    }

    init() {
        super.init(frame: .zero)
        showsHorizontalScrollIndicator = false
        bounces = true
        isPagingEnabled = true

        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.error?.cgColor
        backgroundColor = .black50
        setShadow()
        addView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {
        addSubview(bannerStackView)
    }

    func setLayout() {
        bannerStackView.snp.makeConstraints {
            $0.height.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
}
