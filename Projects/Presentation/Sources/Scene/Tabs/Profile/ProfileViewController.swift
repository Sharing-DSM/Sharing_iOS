import UIKit
import SnapKit
import SharingKit
import Then
import RxFlow
import RxCocoa
import Core
import RxSwift
import Kingfisher

public class ProfileViewController: BaseVC<ProfileViewModel> {

    private let viewDidLoadRelay = PublishRelay<Void>()
    private let imageData = PublishRelay<Data>()
    private var currentImage: UIImage = UIImage()

    private let profileBackgroundView = UIView().then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 30
        $0.setShadow()
    }
    private let profileImageView = UIImageView().then {
        $0.image = SharingKitAsset.Image.profileImage.image
        $0.layer.cornerRadius = 45
        $0.clipsToBounds = true
    }
    private let imageAddButton = UIButton(type: .system).then {
        $0.setImage(SharingKitAsset.Image.profilePlus.image, for: .normal)
        $0.tintColor = .black900
        $0.backgroundColor = .black200
        $0.layer.cornerRadius = 10
    }
    private let imagePicker = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
    }
    private let nameLabel = UILabel().then {
        $0.text = ""
        $0.font = .headerH1Bold
    }
    private let idLabel = UILabel().then {
        $0.text = ""
        $0.font = .bodyB1Regular
        $0.textColor = .black600
    }
    private let ageText: String = ""
    private let editButton = UIButton(type: .system).then {
        $0.setTitle("내 정보 수정하기", for: .normal)
        $0.setTitleColor(.black900, for: .normal)
        $0.titleLabel?.font = .bodyB2Medium
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.main?.cgColor
        $0.backgroundColor = .white
    }
    private let addressButton = FillButton(type: .system).then {
        $0.setTitle("관심지역 설정하기", for: .normal)
    }
    private let applyHistoryView = UIButton(type: .system).then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 10
        $0.setShadow()
    }
    private let profilIcon = UIImageView().then {
        $0.image = UIImage(systemName: "person.crop.circle")
        $0.tintColor = .main
    }
    private let applyHistoryLabel = UILabel().then {
        $0.text = "신청 내역"
        $0.font = .bodyB1Medium
    }
    private let applyButton = UIButton(type: .system)
    private let writtenHistoryView = UIButton(type: .system).then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 10
        $0.setShadow()
    }
    private let folderIcon = UIImageView().then {
        $0.image = SharingKitAsset.Image.folderIcon.image
    }
    private let writtenHistoryLabel = UILabel().then {
        $0.text = "작성글"
        $0.font = .bodyB1Medium
    }
    private let myPostButton = UIButton(type: .system)
    private let scheduleView = UIButton(type: .system).then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 10
        $0.setShadow()
    }
    private let scheduleIcon = UIImageView().then {
        $0.image = SharingKitAsset.Image.calendarIcon.image
    }
    private let scheduleLabel = UILabel().then {
        $0.text = "일정"
        $0.font = .bodyB1Medium
    }
    private let scheduleButton = UIButton(type: .system)
    private let logoutButton = UIButton(type: .system).then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.black900, for: .normal)
        $0.titleLabel?.font = .bodyB2Medium
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.main?.cgColor
        $0.backgroundColor = .black50
    }
    private let outOfMemberButton = UIButton(type: .system).then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setTitleColor(.error, for: .normal)
        $0.titleLabel?.font = .bodyB2Medium
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.error?.cgColor
        $0.backgroundColor = .black50
    }

    public override func attribute() {
        imagePicker.delegate = self
        viewDidLoadRelay.accept(())
        imageAddButton.rx.tap
            .subscribe(onNext: {
                self.present(self.imagePicker, animated: true)
            }).disposed(by: disposeBag)
    }
    public override func viewWillAppear(_ animated: Bool) {
        viewDidLoadRelay.accept(())
    }
    public override func bind() {

        let input = ProfileViewModel.Input(
            viewWillApear: viewDidLoadRelay.asObservable(),
            applyButtonDidTap: applyButton.rx.tap.asObservable(),
            addressButtonDidTap: addressButton.rx.tap.asObservable(),
            scheduleButtonDidTap: scheduleButton.rx.tap.asObservable(),
            profileEditButtonDidTap: editButton.rx.tap.asObservable(),
            myPostButtonDidTap: myPostButton.rx.tap.asObservable(),
            logoutButtonDidTap: logoutButton.rx.tap.asObservable(),
            imageData: imageData.asObservable(),
            currentImage: currentImage
        )
        let output = viewModel.transform(input: input)
        output.userProfileData.asObservable().subscribe(onNext: { [self] in
            self.nameLabel.text = $0.name
            self.idLabel.text = "@\($0.accountId)"
            if $0.profileImageURL != "" {
                let url = URL(string: $0.profileImageURL)
                print($0.profileImageURL)
                self.profileImageView.kf.setImage(with: url)
                self.imageAddButton.isHidden = true
                self.currentImage = profileImageView.image ?? SharingKitAsset.Image.profileImage.image
            } else {
                self.profileImageView.image = SharingKitAsset.Image.profileImage.image
            }
        }).disposed(by: disposeBag)
        output.imageUrl.asObservable()
            .subscribe(onNext: { image in
                let url = URL(string: image.imageUrl)
                self.profileImageView.kf.setImage(with: url)
                self.currentImage = self.profileImageView.image ?? UIImage()
            }).disposed(by: disposeBag)
    }

    public override func addView() {
        view.addSubview(profileBackgroundView)
        [
            profileImageView,
            imageAddButton,
            nameLabel,
            idLabel,
            editButton,
            addressButton,
        ].forEach { profileBackgroundView.addSubview($0) }
        [
            applyHistoryView,
            profilIcon,
            applyHistoryLabel,
            applyButton,
            writtenHistoryView,
            folderIcon,
            writtenHistoryLabel,
            myPostButton,
            scheduleView,
            scheduleIcon,
            scheduleLabel,
            scheduleButton,
            logoutButton,
            outOfMemberButton
        ].forEach { view.addSubview($0) }
    }
    public override func setLayout() {
        profileBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(75)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(226)
        }
        profileImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
            $0.width.height.equalTo(90)
        }
        imageAddButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).offset(67)
            $0.leading.equalTo(profileImageView.snp.leading).offset(67)
            $0.width.height.equalTo(20)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33)
            $0.left.equalTo(profileImageView.snp.right).offset(21)
            $0.height.equalTo(30)
        }
        idLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.left.equalTo(nameLabel.snp.left)
            $0.height.equalTo(22)
        }
        editButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        addressButton.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        writtenHistoryView.snp.makeConstraints {
            $0.top.equalTo(profileBackgroundView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(99)
        }
        folderIcon.snp.makeConstraints {
            $0.top.equalTo(writtenHistoryView.snp.top).offset(16)
            $0.centerX.equalTo(writtenHistoryView)
            $0.width.height.equalTo(35)
        }
        writtenHistoryLabel.snp.makeConstraints {
            $0.top.equalTo(folderIcon.snp.bottom).offset(10)
            $0.centerX.equalTo(writtenHistoryView)
            $0.height.equalTo(22)
        }
        myPostButton.snp.makeConstraints {
            $0.top.equalTo(profileBackgroundView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(99)
        }
        applyHistoryView.snp.makeConstraints {
            $0.top.equalTo(profileBackgroundView.snp.bottom).offset(16)
            $0.right.equalTo(writtenHistoryView.snp.left).offset(-17)
            $0.width.height.equalTo(99)
        }
        profilIcon.snp.makeConstraints {
            $0.top.equalTo(applyHistoryView.snp.top).offset(16)
            $0.centerX.equalTo(applyHistoryView)
            $0.width.height.equalTo(35)
        }
        applyHistoryLabel.snp.makeConstraints {
            $0.top.equalTo(profilIcon.snp.bottom).offset(10)
            $0.centerX.equalTo(applyHistoryView)
            $0.height.equalTo(22)
        }
        applyButton.snp.makeConstraints {
            $0.top.equalTo(profileBackgroundView.snp.bottom).offset(16)
            $0.right.equalTo(writtenHistoryView.snp.left).offset(-17)
            $0.width.height.equalTo(99)
        }
        scheduleView.snp.makeConstraints {
            $0.top.equalTo(profileBackgroundView.snp.bottom).offset(16)
            $0.left.equalTo(writtenHistoryView.snp.right).offset(16)
            $0.height.width.equalTo(99)
        }
        scheduleIcon.snp.makeConstraints {
            $0.top.equalTo(scheduleView.snp.top).offset(16)
            $0.centerX.equalTo(scheduleView)
            $0.width.height.equalTo(35)
        }
        scheduleLabel.snp.makeConstraints {
            $0.top.equalTo(scheduleIcon.snp.bottom).offset(10)
            $0.centerX.equalTo(scheduleView)
            $0.height.equalTo(22)
        }
        scheduleButton.snp.makeConstraints {
            $0.top.equalTo(profileBackgroundView.snp.bottom).offset(16)
            $0.left.equalTo(writtenHistoryView.snp.right).offset(16)
            $0.height.width.equalTo(99)
        }
        outOfMemberButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        logoutButton.snp.makeConstraints {
            $0.bottom.equalTo(outOfMemberButton.snp.top).offset(-8)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { 
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            let imageData = image?.jpegData(compressionQuality: 0.7)
            self.imageData.accept(imageData ?? Data())
            self.profileImageView.image = image
            self.imageAddButton.isHidden = true
        }
    }
}
