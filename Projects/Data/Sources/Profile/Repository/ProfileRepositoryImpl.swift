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

    //Schedules
    func postSchedules(title: String, date: Date) -> RxSwift.Completable {
        return remoteDataSource.postScheduls(title: title, date: date)
    }
    func fetchCompleteSchedules(id: String) -> RxSwift.Single<[Domain.CompleteScheduleEntity]> {
        return remoteDataSource.fetchCompleteSchedules(id: id)
            .map(CompleteScheduleListDTO.self)
            .map { $0.toDomain()}
    }
    func patchSchedules(id: String) -> RxSwift.Completable {
        return remoteDataSource.patchSchedules(id: id)
    }
    
    func deleteSchedules(id: String) -> RxSwift.Completable {
        return remoteDataSource.deleteSchedules(id: id)
    }
    
    func completSchedules(id: String) -> RxSwift.Completable {
        return remoteDataSource.completeSchedules(id: id)
    }
}
