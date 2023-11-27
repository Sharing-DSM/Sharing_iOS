import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxCocoa
import Core
import RxSwift

public class ScheduleViewController:  BaseVC<ScheduleViewModel>{

    private let viewWillAppear = PublishRelay<Void>()
    private let completSchedule = PublishRelay<Void>()
    let deletePostRelay = PublishRelay<String>()
    let editRequired = PublishRelay<String>()
    let completScheduleRelay = PublishRelay<String>()

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
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 91
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.identifier)
    }
    private let completScheduleLabel = UILabel().then {
        $0.text = "완료된 일정"
        $0.font = .headerH1SemiBold
        $0.textColor = .black900
    }
    private let completScheduleTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.rowHeight = 91
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.identifier)
    }
    private let postWriteButton = GradationButton(type: .system).then {
        $0.setImage(.pencil.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    let deleteAlertController = UIAlertController(
        title: nil,
        message: "일정을 삭제하시겠습니까?",
        preferredStyle: .alert
    )

    public override func viewWillAppear (_ animated: Bool) {
        viewWillAppear.accept(())
    }

    public override func bind() {
        
        let input = ScheduleViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            writeButtonDidTap: postWriteButton.rx.tap.asObservable(),
            deleteSchedule: deletePostRelay.asObservable(),
            completeScheduleRelay: completScheduleRelay.asObservable(),
            editRequired: editRequired.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.unCompleteScheduleList
            .bind(to: scheduleTableView.rx.items(
                cellIdentifier: ScheduleTableViewCell.identifier,
                cellType: ScheduleTableViewCell.self
            )) { [weak self] row, item, cell in
                guard let self = self else { return }
                cell.titleLabel.text = item.title
                cell.dateLabel.text = item.date
                cell.cellId = item.id
                cell.setup()
                cell.delegate = self
                scheduleTableView.snp.updateConstraints {
                    $0.height.greaterThanOrEqualTo(self.scheduleTableView.contentSize.height)
                }
            }.disposed(by: disposeBag)

        output.completeScheduleList
            .bind(to: completScheduleTableView.rx.items(
                cellIdentifier: ScheduleTableViewCell.identifier,
                cellType: ScheduleTableViewCell.self
            )) { [weak self] row, item, cell in
                guard let self = self else { return }
                cell.titleLabel.text = item.title
                cell.dateLabel.text = item.date
                cell.cellId = item.id
                if item.isCompleted == true {
                    cell.checkBoxButton.backgroundColor = .main
                }
                cell.setup()
                cell.delegate = self
                completScheduleTableView.snp.updateConstraints {
                    $0.height.greaterThanOrEqualTo(self.completScheduleTableView.contentSize.height + 5)
                }
            }.disposed(by: disposeBag)

        output.refreshTable
            .bind(to: viewWillAppear)
            .disposed(by: disposeBag)
    }
    
    public override func addView() {
        [
            scrollView,
            postWriteButton
        ].forEach({ view.addSubview($0) })
        scrollView.addSubview(contentView)
        [
            scheduleLabel,
            scheduleTableView,
            completScheduleLabel,
            completScheduleTableView
        ].forEach { contentView.addSubview($0) }
    }
    public override func setLayout() {
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
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        scheduleTableView.snp.makeConstraints {
            $0.top.equalTo(scheduleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.greaterThanOrEqualTo(scheduleTableView.contentSize.height + 5)
        }
        completScheduleLabel.snp.makeConstraints {
            $0.top.equalTo(scheduleTableView.snp.bottom).offset(32)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        completScheduleTableView.snp.makeConstraints {
            $0.top.equalTo(completScheduleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.greaterThanOrEqualTo(self.completScheduleTableView.contentSize.height + 5)
        }
        postWriteButton.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension ScheduleViewController: ScheduleTableViewCellDelegate {
    public func didTapDeleteButton(cellId: String) {
        self.presentedViewController?.dismiss(animated: false)
        let alert = self.deleteAlertController
        let deleteAction = UIAlertAction(
            title: "확인",
            style: .destructive,
            handler: { _ in
                self.deletePostRelay.accept(cellId)
            }
        )
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [
            deleteAction,
            cancelAction
        ].forEach { alert.addAction($0)}
        self.present(alert, animated: true, completion: nil)
    }
    public func didTapEditButton(cellId: String) {
        editRequired.accept(cellId)
    }
    public func checkBoxButtonDidTap(cellId: String) {
        completScheduleRelay.accept(cellId)
    }
}
