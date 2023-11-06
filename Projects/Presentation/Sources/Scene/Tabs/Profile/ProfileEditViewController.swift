import UIKit
import Then
import SnapKit
import SharingKit

public class ProfileEditViewController: UIViewController {

    public override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        addView()
        setLayout()
    }

    private let headerLabel = UILabel().then {
        $0.text = "프로필 정보 수정"
        $0.font = .headerH1SemiBold
        $0.textColor = .main
    }
    private let profileImageView = UIImageView().then {
        $0.image = SharingKitAsset.Image.profileImage.image
    }
    private let profileChangeButton = UIButton(type: .system).then {
        let title = "프로필사진변경"
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.bodyB3Medium,
            .foregroundColor: UIColor.black
        ])
        $0.setAttributedTitle(attributedTitle, for: .normal)
    }
    private let idTextField = SharingTextField(title: "아이디").then {
        $0.placeholder = "아이디"
    }
    private let nameTextField = SharingTextField(title: "이름").then {
        $0.placeholder = "이름"
    }
    private let ageTextField = SharingTextField(title: "나이").then {
        $0.placeholder = "나이"
    }
    private let editCompleteButton = FillButton(type: .system).then {
        $0.setTitle("수정 완료", for: .normal)
    }
    private func addView() {
        [
            headerLabel,
            profileImageView,
            profileChangeButton,
            idTextField,
            nameTextField,
            ageTextField,
            profileChangeButton,
            editCompleteButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(75)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(90)
        }
        profileChangeButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(18)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(profileChangeButton.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        editCompleteButton.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
    }
}
