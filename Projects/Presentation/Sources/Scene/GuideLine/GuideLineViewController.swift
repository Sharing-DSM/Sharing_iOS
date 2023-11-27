import UIKit
import SharingKit
import Then
import SnapKit

public class GuideLineViewController: UIViewController {

    private let contentView = UIView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let headerLabel = UILabel().then {
        $0.text = "가이드 라인"
        $0.font = .headerH1SemiBold
        $0.textColor = .main
    }
    private let backgroundView = UIView().then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 10
        $0.setShadow()
    }
    private let volunteerLabel = UILabel().then {
        $0.text = "자원봉사란?"
        $0.font = .bodyB1SemiBold
    }
    private let volunteerDetailLabel = UILabel().then {
        $0.text =   """
        • 개인 또는 단체가 지역사회·국가 및 인류사회를 위하여 대가 없이 자발적으로 시간과 노력을 제공하는 행위입니다
        """
        $0.font = .bodyB3Medium
        $0.numberOfLines = 2
    }
    private let useGuideLabel = UILabel().then {
        $0.text = "사용법 안내"
        $0.font = .bodyB1SemiBold
    }
    private let useGuideDetailLabel = UILabel().then {
        $0.text = """
                • 자원봉사를 보다 쉽게 관리하는 서비스입니다!
                게시글을 올려 방대했던 정보를 한눈에 확인 가능합니다🔥
                
                현재 위치 주변의 게시글을 ‘지도’ 탭에서 확인하실 수 있으며,
                자신이 주로 봉사하러 가는 지역을 관심 지역으로 설정하여
                그 지역의 자원봉사 모집글을 확인 할 수 있습니다! 💙

                • 자신의 자원봉사 일정을 관리해보세요 ⏰
                ’MY’ 탭에서 사용자 정보는 물론 일정을 관리할 수 있습니다!

                • 게시글 작성자에게 모집글 관련 궁금증이 생기셨다면?
                게시글 아래 ‘채팅하기' 버튼을 눌러 채팅을 시작해보세요 💬
                """
        $0.font = .bodyB3Medium
        $0.numberOfLines = 12
    }
    private let fowardLabel = UILabel().then {
        $0.text = "앞으로의 저희 서비스는...?"
        $0.font = .bodyB1SemiBold
    }
    private let fowardDetailLabel = UILabel().then {
        $0.text = """
                • 디자인 개선 🔀 사용자 분들이 더 편리하게 사용하실 수 있도록 UX/UI 계속적으로 개선하며 발전해 나갈 것입니다.

                • 다양한 기능 추가 🌟 알림, 봉사 신청 및 모집 관련 기능, 사용자 정보 관리 기능 등 더 많은 사람들이 사회에 기여할 수 있도록 도울 것입니다.

                • 빠른 피드백 반영 📮 버그 제보 및 피드백 기능을 만들어 사용자의 요구사항을 신속하게 반영하여 불편함을 최소화시킬 것입니다.
                """
        $0.font = .bodyB3Medium
        $0.numberOfLines = 11
    }

    public override func viewDidLoad() {
        view.backgroundColor = .white
        addView()
        setLayout()
    }

    private func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(backgroundView)
        [
            volunteerLabel,
            volunteerDetailLabel,
            useGuideLabel,
            useGuideDetailLabel,
            fowardLabel,
            fowardDetailLabel
        ].forEach { backgroundView.addSubview($0) }
    }
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(backgroundView.snp.bottom).offset(64)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(25)
            $0.bottom.equalTo(fowardDetailLabel.snp.bottom).offset(16)
        }
        volunteerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        volunteerDetailLabel.snp.makeConstraints {
            $0.top.equalTo(volunteerLabel.snp.bottom)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(26)
        }
        useGuideLabel.snp.makeConstraints {
            $0.top.equalTo(volunteerDetailLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        useGuideDetailLabel.snp.makeConstraints {
            $0.top.equalTo(useGuideLabel.snp.bottom)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(13)
        }
        fowardLabel.snp.makeConstraints {
            $0.top.equalTo(useGuideDetailLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        fowardDetailLabel.snp.makeConstraints {
            $0.top.equalTo(fowardLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
        }
        
    }
}
