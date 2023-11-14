import Foundation
import RxSwift

public protocol PostRepository {
    func fetchPopularityPost() -> Single<PopularityPostEntity>
    func fetchDetailPost(id: String) -> Single<PostDetailEntity>
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
    ) -> Completable
    func deletePost(id: String) -> Completable
    func editPost(
        id: String,
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
    ) -> Completable
    func fetchSurroundingPost(x: Double, y: Double) -> Single<SurroundPostEntity>
}
