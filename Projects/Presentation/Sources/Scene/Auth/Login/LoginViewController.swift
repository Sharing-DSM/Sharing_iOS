import UIKit
import SnapKit
import Then
import RxCocoa
import SharingKit

public class LoginViewController: BaseVC<LoginViewModel>, ViewModelTransformable {
    private let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .headerH1SemiBold
        $0.textColor = .main
    }
    private let idTextField = SharingTextField().then {
        $0.placeholder = "아이디"
    }
    private let passwordTextField = SharingTextField().then {
        $0.placeholder = "비밀번호"
    }
    private let signupButton = UIButton().then {
        let buttonText = NSMutableAttributedString(
            string: "회원이 아니신가요? ",
            attributes: [
                .foregroundColor: UIColor.black900!,
                .font: UIFont.bodyB2Medium
            ]
        )

        buttonText.append(
            NSAttributedString(
                string: "회원가입",
                attributes: [
                    .foregroundColor: UIColor.main!,
                    .font: UIFont.bodyB2Bold,
                    .underlineStyle : NSUnderlineStyle.single.rawValue
                ]
            )
        )
        $0.setAttributedTitle(buttonText, for: .normal)
    }
    private let loginButton = FillButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
    }

    public lazy var input: LoginViewModel.Input = LoginViewModel.Input(
        signupButtonSignal: signupButton.rx.tap.asObservable()
    )
    public lazy var output: LoginViewModel.Output = viewModel.transform(input: input)

    public override func addView() {
        [
            loginLabel,
            idTextField,
            passwordTextField,
            signupButton,
            loginButton
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(263)
            $0.leading.equalToSuperview().inset(35)
            $0.height.equalTo(30)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(50)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(35)
            $0.height.equalTo(20)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(40)
        }
    }
}
