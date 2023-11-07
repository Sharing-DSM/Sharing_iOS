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

    func fetchTotalPost() -> Single<Response> {
        return provider.rx.request(.fetchTotalPost)
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
        addressData: AddressEntityElement,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    ) -> Completable {
        return provider.rx.request(.createPost(
            title: title,
            content: content,
            addressData: addressData,
            recruitment: recruitment,
            type: type,
            volunteerTime: volunteerTime,
            isEmergency: isEmergency
        ))
        .asCompletable()
        .catch { .error($0.toError(PostError.self)) }
    }

//    // TODO: 명세보고 request 구조체 만들어서 요청하기
//    func deletePost() -> Completable {
//        return provider.rx.request(.deletePost(id: ""))
//            .asCompletable()
//            .catch { .error($0.toError(PostError.self)) }
//    }
//
//    func editPost() -> Completable {
//        return provider.rx.request(.editPost(id: ""))
//            .asCompletable()
//            .catch { .error($0.toError(PostError.self)) }
//    }
}
