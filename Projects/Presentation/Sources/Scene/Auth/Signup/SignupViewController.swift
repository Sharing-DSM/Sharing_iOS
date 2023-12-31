import UIKit
import SnapKit
import Then
import SharingKit
import Core

public class SignupViewController: BaseVC<SignupViewModel> {

    private let signupLabel = UILabel().then {
        $0.text = "회원가입"
        $0.font = .headerH1SemiBold
        $0.textColor = .main
    }
    private let idTextField = SharingTextField().then {
        $0.placeholder = "아이디"
    }
    private let passwordTextField = SharingTextField().then {
        $0.isSecurity = true
        $0.placeholder = "비밀번호"
    }
    private let nameTextField = SharingTextField().then {
        $0.placeholder = "이름"
    }
    private let ageTextField = SharingTextField(keyboardType: .asciiCapableNumberPad).then {
        $0.placeholder = "나이"
    }
    private let signupButton = FillButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
    }

    public lazy var input = SignupViewModel.Input(
        idText: idTextField.rx.text.orEmpty.asObservable(),
        passwordText: passwordTextField.rx.text.orEmpty.asObservable(),
        nameText: nameTextField.rx.text.orEmpty.asObservable(),
        ageText: ageTextField.rx.text.orEmpty.asObservable(),
        signupButtonSignal: signupButton.rx.tap.asObservable()
    )
    public lazy var output = viewModel.transform(input: input)

    public override func bind() {
        output.idErrorDescription.asObservable()
            .bind(to: idTextField.errorMessage)
            .disposed(by: disposeBag)
        
        output.passwordErrorDescription.asObservable()
            .bind(to: passwordTextField.errorMessage)
            .disposed(by: disposeBag)
        
        output.nameErrorDescription.asObservable()
            .bind(to: nameTextField.errorMessage)
            .disposed(by: disposeBag)
        
        output.ageErrorDescription.asObservable()
            .bind(to: ageTextField.errorMessage)
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            signupLabel,
            idTextField,
            passwordTextField,
            nameTextField,
            ageTextField,
            signupButton
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        signupLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(230)
            $0.leading.equalToSuperview().inset(35)
            $0.height.equalTo(30)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(50)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(50)
        }
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(50)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(33)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(40)
        }
    }
}
