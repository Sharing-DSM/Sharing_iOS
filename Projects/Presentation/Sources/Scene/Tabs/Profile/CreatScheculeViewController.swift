import UIKit
import SnapKit
import Then
import SharingKit

public class CreatScheculeViewController: UIViewController {

    public override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        addView()
        setLayout()
    }

    private let headerLabel = UILabel().then {
        $0.text = "일정 작성"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }
    private let titleTextField = SharingTextField(title: "제목").then {
        $0.placeholder = "10자까지 입력해주세요."
    }
    private let yearTextField = SharingTextField(title: "날짜").then {
        $0.placeholder = "년도"
        $0.keyboardType = .numberPad
    }
    private let monthTextField = SharingTextField().then {
        $0.placeholder = "월"
        $0.keyboardType = .numberPad
    }
    private let dayTextField = SharingTextField().then {
        $0.placeholder = "일"
        $0.keyboardType = .numberPad
    }
    private let completeButton = FillButton(type: .system).then {
        $0.setTitle("작성 완료", for: .normal)
    }

    private func addView() {
        [
            headerLabel,
            titleTextField,
            yearTextField,
            monthTextField,
            dayTextField,
            completeButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(75)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        yearTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(50)
            $0.width.greaterThanOrEqualTo(150)
        }
        monthTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(24)
            $0.left.equalTo(yearTextField.snp.right).offset(8)
            $0.height.equalTo(50)
            $0.width.greaterThanOrEqualTo(80)
        }
        dayTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(24)
            $0.left.equalTo(monthTextField.snp.right).offset(8)
            $0.height.greaterThanOrEqualTo(50)
            $0.right.equalToSuperview().inset(25)
            $0.width.equalTo(80)
        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(yearTextField.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
    }
}
