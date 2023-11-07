import Foundation
import RxSwift

public protocol PostRepository {
    func fetchTotalPost() -> Single<TotalPostEntity>
    func fetchDetailPost(id: String) -> Single<PostDetailEntity>
    func createPost(
        title: String,
        content: String,
        addressData: AddressEntityElement,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    ) -> Completable
//    func deletePost(id: String) -> Completable
//    func editPost(id: String) -> Completable
}
