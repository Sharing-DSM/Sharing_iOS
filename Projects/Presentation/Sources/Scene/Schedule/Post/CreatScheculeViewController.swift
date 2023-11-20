import UIKit
import SnapKit
import Then
import SharingKit
import Core

public class CreatScheculeViewController: BaseVC<CreateSheduleViewModel> {

    private let headerLabel = UILabel().then {
        $0.text = "일정 작성"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }
    private let titleTextField = SharingTextField(title: "제목").then {
        $0.placeholder = "10자까지 입력해주세요."
    }
    private let dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.font = .bodyB2Medium
        $0.textColor = .black900
    }
    private let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
    }
    private let completeButton = FillButton(type: .system).then {
        $0.setTitle("작성 완료", for: .normal)
    }

    public override init(viewModel: CreateSheduleViewModel) {
        super.init(viewModel: viewModel)
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func bind() {
        let input = CreateSheduleViewModel.Input(
            titleText: titleTextField.rx.text.orEmpty.asObservable(),
            dateText: datePicker.rx.date.asObservable(),
            completeButtonDidTap: completeButton.rx.tap.asObservable()
        )
        _ = viewModel.transform(input: input)
    }

    public override func addView() {
        [
            headerLabel,
            titleTextField,
            dateLabel,
            datePicker,
            completeButton
        ].forEach { view.addSubview($0) }
    }
    public override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(48)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(20)
        }
        datePicker.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(100)
        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
    }
}
