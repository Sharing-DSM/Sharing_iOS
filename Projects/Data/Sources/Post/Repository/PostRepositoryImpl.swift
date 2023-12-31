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
    ) -> Completable {
        return remoteDataSource.editPost(
            id: id,
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

    func fetchAreaOfInterestPost() -> Single<CommonPostEntity> {
        return remoteDataSource.fetchAreaOfInterestPost()
                .map(CommonPostDTO.self)
                .map { $0.toDomain() }
    }

    func fetchSurroundingPost(x: Double, y: Double) -> Single<CommonPostEntity> {
        return remoteDataSource.fetchSurroundingPost(x: x, y: y)
            .map(CommonPostDTO.self)
            .map { $0.toDomain() }
    }

    func fetchEmergencyPost() -> Single<CommonPostEntity> {
        return remoteDataSource.fetchEmergencyPost()
            .map(CommonPostDTO.self)
            .map { $0.toDomain() }
    }

    func fetchApplicantList(id: String) -> Single<ApplicantListEntity> {
        return remoteDataSource.fetchApplicantList(id: id)
            .map(ApplicantListDTO.self)
            .map { $0.toDomain() }
    }

    func postApplicationVolunteer(id: String) -> Completable {
        return remoteDataSource.postApplicationVolunteer(id: id)
            .asCompletable()
    }

    func searchInMap(keyword: String, x: Double, y: Double) -> Single<CommonPostEntity> {
        return remoteDataSource.searchInMap(keyword: keyword, x: x, y: y)
            .map(CommonPostDTO.self)
            .map { $0.toDomain() }
    }

    func searchInPostTitle(keyword: String) -> Single<CommonPostEntity> {
        return remoteDataSource.searchInPostTitle(keyword: keyword)
            .map(CommonPostDTO.self)
            .map { $0.toDomain() }
    }
}
