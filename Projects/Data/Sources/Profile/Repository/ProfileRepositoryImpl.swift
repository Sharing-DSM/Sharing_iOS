import Foundation
import Domain
import RxSwift

class ProfileRepositoryImpl: ProfileRepository {

    let remoteDataSource = ProfileDataSource.shared

    func fetchUserProfile() -> RxSwift.Single<Domain.UserProfileEntity> {
        return remoteDataSource.fetchUserProfile()
            .map(UserProfileDTO.self)
            .map { $0.toDomain()}
    }
    func patchUserProfile(name: String, id: String, age: Int) -> Completable {
        return remoteDataSource.patchUserProfile(name: name, id: id, age: age)
    }
    func fetchMyPost() -> Single<MyPostEntity> {
        return remoteDataSource.fetchMyPost()
            .map(MyPostDTO.self)
            .map { $0.toDomain()}
    }
    func fetchApplyHistory() -> RxSwift.Single<Domain.ApplyHistoryEntity> {
        return remoteDataSource.fetchApplyHistory()
            .map(ApplyHistoryDTO.self)
            .map { $0.toDomain() }
    }

    //Schedules
    func postSchedules(title: String, date: String) -> RxSwift.Completable {
        return remoteDataSource.postScheduls(title: title, date: date)
    }
    func fetchCompleteSchedules() -> RxSwift.Single<[Domain.CompleteScheduleEntity]> {
        return remoteDataSource.fetchCompleteSchedules()
            .map(CompleteScheduleListDTO.self)
            .map { $0.toDomain()}
    }
    func fetchUnCompleteSchedules() -> Single<[UncompleteScheduleEntity]> {
        return remoteDataSource.fetchUnCompleteSchedules()
            .map(UnCompleteScheduleListDTO.self)
            .map { $0.toDomain() }
    }
    func patchSchedules(id: String, title: String, date: String) -> RxSwift.Completable {
        return remoteDataSource.patchSchedules(id: id, title: title, date: date)
    }
    
    func deleteSchedules(id: String) -> RxSwift.Completable {
        return remoteDataSource.deleteSchedules(id: id)
    }
    
    func completSchedules(id: String) -> RxSwift.Completable {
        return remoteDataSource.completeSchedules(id: id)
    }
}
