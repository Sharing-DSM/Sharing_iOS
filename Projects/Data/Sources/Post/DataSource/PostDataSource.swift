import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger
import Domain

class PostDataSource {
    private let provider = MoyaProvider<PostAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = PostDataSource()
    private init() {}

    func fetchPopularityPost() -> Single<Response> {
        return provider.rx.request(.fetchPopularityPost)
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(PostError.self)) }
    }

    func fetchDetailPost(id: String) -> Single<Response> {
        return provider.rx.request(.fetchPostDetail(id: id))
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(PostError.self)) }
    }

    func createPost(
        title: String,
        content: String,
        addressName: String,
        roadAddressName: String,
        xCos: Double,
        yCos: Double,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    ) -> Completable {
        return provider.rx.request(.createPost(
            title: title,
            content: content,
            addressName: addressName,
            roadAddressName: roadAddressName,
            xCos: xCos,
            yCos: yCos,
            recruitment: recruitment,
            type: type,
            volunteerTime: volunteerTime,
            isEmergency: isEmergency
        ))
        .asCompletable()
        .catch { .error($0.toError(PostError.self)) }
    }

    func deletePost(id: String) -> Completable {
        return provider.rx.request(.deletePost(id: id))
            .asCompletable()
            .catch { .error($0.toError(PostError.self)) }
    }
//
//    func editPost() -> Completable {
//        return provider.rx.request(.editPost(id: ""))
//            .asCompletable()
//            .catch { .error($0.toError(PostError.self)) }
//    }
}
