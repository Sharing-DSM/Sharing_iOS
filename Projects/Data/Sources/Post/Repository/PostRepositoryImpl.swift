import Foundation
import RxSwift
import Domain
import AppNetwork
import Core
import Moya

class PostRepositoryImpl: PostRepository {

    let remoteDataSource = PostDataSource.shared

    func fetchTotalPost() -> Single<TotalPostEntity> {
       return remoteDataSource.fetchTotalPost()
            .map(TotalPostDTO.self)
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
        addressData: AddressEntityElement,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    ) -> RxSwift.Completable {
        return remoteDataSource.createPost(
            title: title,
            content: content,
            addressData: addressData,
            recruitment: recruitment,
            type: type,
            volunteerTime: volunteerTime,
            isEmergency: isEmergency
        )
    }

//    func registerPost() -> Completable {
//        return remoteDataSource.registerPost()
//    }
//    
//    func deletePost(id: String) -> Completable {
//        return remoteDataSource.deletePost()
//    }
//    
//    func editPost(id: String) -> Completable {
//        return remoteDataSource.editPost()
//    }
}
