import UIKit
import Then
import SnapKit
import SharingKit
import Core
import RxCocoa

public class ProfileEditViewController: BaseVC<ProfileEditViewModel> {

    private let imageData = PublishRelay<Data>()
    public var currentImage: UIImage?

    private let headerLabel = UILabel().then {
        $0.text = "프로필 정보 수정"
        $0.font = .headerH1SemiBold
        $0.textColor = .main
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 45
        $0.clipsToBounds = true
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
    private let imagePicker = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
    }
    public let idTextField = SharingTextField(title: "아이디").then {
        $0.placeholder = "아이디"
    }
    public let nameTextField = SharingTextField(title: "이름").then {
        $0.placeholder = "이름"
    }
    public let ageTextField = SharingTextField(title: "나이").then {
        $0.placeholder = "나이"
    }
    private let editCompleteButton = FillButton(type: .system).then {
        $0.setTitle("수정 완료", for: .normal)
    }

    public override init(viewModel: ProfileEditViewModel) {
        super.init(viewModel: viewModel)
//        self.profileImageView.image = currentImage
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func attribute() {
        imagePicker.delegate = self
        profileChangeButton.rx.tap
            .subscribe(onNext: {
                self.present(self.imagePicker, animated: true)
            }).disposed(by: disposeBag)
        profileImageView.image = currentImage
    }
    public override func bind() {
        let input = ProfileEditViewModel.Input(
            editCompleteButtonSignal: editCompleteButton.rx.tap.asObservable(),
            idText: idTextField.rx.text.orEmpty.asObservable(),
            nameText: nameTextField.rx.text.orEmpty.asObservable(),
            ageText: ageTextField.rx.text.orEmpty.asObservable().map { Int($0) ?? 0 },
            profileChangeButtonDidTap: imageData.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.nameErrorDescription.asObservable()
            .bind(to: self.nameTextField.errorMessage)
            .disposed(by: disposeBag)
        output.idErrorDescription.asObservable()
            .bind(to: self.idTextField.errorMessage)
            .disposed(by: disposeBag)
        output.ageErrorDescription.asObservable()
            .bind(to: self.ageTextField.errorMessage)
            .disposed(by: disposeBag)
    }
    public override func addView() {
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
    public override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
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
            $0.top.equalTo(profileChangeButton.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(35)
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

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            let imageData = image?.jpegData(compressionQuality: 0.7)
            self.imageData.accept(imageData ?? Data())
            self.profileImageView.image = image
        }
    }
}
