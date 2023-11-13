import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxCocoa
import Core
import RxSwift

public class ScheduleViewController:  UIViewController {

    public let steps = PublishRelay<SharingStep>()
    public let disposeBag = DisposeBag()

    public override func viewDidLoad() {
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        completScheduleTableView.delegate = self
        completScheduleTableView.dataSource = self
        view.backgroundColor = .systemBackground
        addView()
        setLayout()
        postWriteButton.rx.tap
            .map{SharingStep.postDetailsRequired}
            .bind(to: steps)
            .disposed(by: disposeBag)
    }

    private let contentView = UIView()
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
    }
    private let scheduleLabel = UILabel().then {
        $0.text = "일정"
        $0.font = .headerH1SemiBold
        $0.textColor = .main
    }
    private let scheduleTableView = UITableView().then {
        $0.rowHeight = 91
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
    }
    private let completScheduleLabel = UILabel().then {
        $0.text = "완료된 일정"
        $0.font = .headerH1SemiBold
        $0.textColor = .black900
    }
    private let completScheduleTableView = UITableView().then {
        $0.rowHeight = 91
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
    }
    private let postWriteButton = GradationButton(type: .system).then {
        $0.setImage(.pencil.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }

    private func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            scheduleLabel,
            scheduleTableView,
            completScheduleLabel,
            completScheduleTableView,
            postWriteButton
        ].forEach { contentView.addSubview($0) }
    }
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(completScheduleTableView.snp.bottom).offset(10)
        }
        scheduleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        scheduleTableView.snp.makeConstraints {
            $0.top.equalTo(scheduleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(self.scheduleTableView.numberOfRows(inSection: 0) * 91)
        }
        completScheduleLabel.snp.makeConstraints {
            $0.top.equalTo(scheduleTableView.snp.bottom).offset(32)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        completScheduleTableView.snp.makeConstraints {
            $0.top.equalTo(completScheduleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(self.completScheduleTableView.numberOfRows(inSection: 0) * 91)
        }
        postWriteButton.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }

//    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//        let verticalPadding: CGFloat = 5
//
//        let maskLayer = CALayer()
//        maskLayer.cornerRadius = 10    //if you want round edges
//        maskLayer.backgroundColor = UIColor.black.cgColor
//        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
//        cell.layer.mask = maskLayer
//    }
}
