import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger
import Domain

class ProfileDataSource {
    private let provider = MoyaProvider<ProfileAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared: ProfileDataSource = ProfileDataSource()

    func fetchUserProfile() -> Single<Response> {
        return provider.rx.request(.fetchUserProfile)
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(ProfileError.self))}
    }
    func patchUserProfile(name: String, id: String, age: Int) -> Completable {
        return provider.rx.request(.patchUserProfile(name: name, id: id, age: age))
            .asCompletable()
            .catch { .error($0.toError(ProfileError.self))}
    }

    //schedules
    func postScheduls(title: String, date: Date) -> Completable {
        return provider.rx.request(.postSchedules(title: title, date: date))
            .asCompletable()
            .catch { .error($0.toError(ProfileError.self))}
    }
    func fetchCompleteSchedules(id: String) -> Single<Response> {
        return provider.rx.request(.fetchCompleteSchedules(id: id))
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(ProfileError.self))}
    }
    func patchSchedules(id: String) -> Completable {
        return provider.rx.request(.patchSchedules(id: id))
            .asCompletable()
            .catch { .error($0.toError(ProfileError.self))}
    }
    func deleteSchedules(id: String) -> Completable {
        return provider.rx.request(.deleteSchedules(id: id))
            .asCompletable()
            .catch { .error($0.toError(ProfileError.self))}
    }
    func completeSchedules(id: String) -> Completable {
        return provider.rx.request(.completScheules(id: id))
            .asCompletable()
            .catch { .error($0.toError(ProfileError.self))}
    }
}
