import Foundation
import RxSwift
import Domain
import AppNetwork
import Core
import Moya

class PostRepositoryImpl: PostRepository {

    let remoteDataSource = PostDataSource.shared

    func fetchPopularityPost() -> Single<PopularityPostEntity> {
       return remoteDataSource.fetchPopularityPost()
            .map(PopularityPostDTO.self)
            .map { $0.toDomain() }
    }

    func fetchDetailPost(id: String) -> Single<PostDetailEntity> {
        return remoteDataSource.fetchDetailPost(id: id)
            .map(PostDetailDTO.self)
            .map { $0.toDomain() }
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
    ) -> RxSwift.Completable {
        return remoteDataSource.createPost(
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
        )
    }

    func deletePost(id: String) -> Completable {
        return remoteDataSource.deletePost(id: id)
    }
//    
//    func editPost(id: String) -> Completable {
//        return remoteDataSource.editPost()
//    }
}
