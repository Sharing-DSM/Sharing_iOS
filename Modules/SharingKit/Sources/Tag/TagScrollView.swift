import UIKit
import SnapKit
import Then

public class TagScrollView: UIScrollView {

    public var tags: [String]? {
        didSet {
            tagStackView.arrangedSubviews.forEach {
                tagStackView.removeArrangedSubview($0)
            }
            tags?.forEach {
                let tagView = RoundTagView(tag: $0)
                tagStackView.addArrangedSubview(tagView)
            }
        }
    }

    private let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
    }

    public init() {
        super.init(frame: .zero)
        showsHorizontalScrollIndicator = false
        bounces = false
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(tagStackView)
        tagStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}
