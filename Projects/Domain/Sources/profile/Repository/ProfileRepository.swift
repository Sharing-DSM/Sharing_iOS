import Foundation
import RxSwift

public protocol ProfileRepository {

    func fetchUserProfile() -> Single<UserProfileEntity>
    func patchUserProfile(name: String, id: String, age: Int) -> Completable
    func fetchMyPost() -> Single<MyPostEntity>
    func fetchApplyHistory() -> Single<ApplyHistoryEntity>

    //Schedules
    func postSchedules(title: String, date: String) -> Completable
    func fetchCompleteSchedules() -> Single<[CompleteScheduleEntity]>
    func fetchUnCompleteSchedules() -> Single<[UncompleteScheduleEntity]>
    func patchSchedules(id: String, title: String, date: String) -> Completable
    func deleteSchedules(id: String) -> Completable
    func completSchedules(id: String) -> Completable
}
