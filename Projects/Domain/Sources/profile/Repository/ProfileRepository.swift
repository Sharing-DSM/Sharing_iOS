import Foundation
import RxSwift

public protocol ProfileRepository {

    func fetchUserProfile() -> Single<UserProfileEntity>
    func patchUserProfile(name: String, id: String, age: Int) -> Completable

    //Schedules
    func postSchedules(title: String, date: Date) -> Completable
    func fetchCompleteSchedules(id: String) -> Single<[CompleteScheduleEntity]>
    func patchSchedules(id: String) -> Completable
    func deleteSchedules(id: String) -> Completable
    func completSchedules(id: String) -> Completable
}
