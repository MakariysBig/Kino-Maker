import Foundation

protocol RepositoryProtocol {
    func getServiceStatus(completion: @escaping (Result< ServiceStatus, Error >) -> Void)
    func getRandomFilm(completion: @escaping (Result< RandomFilmModel, Error >) -> Void)
}

final class Repository: RepositoryProtocol {
    
    // MARK: - Private properties
    
    private let networkEngine: NetworkEngine
    
    //MARK: - Initialise

    init(networkEngine: NetworkEngine = NetworkEngine()) {
        self.networkEngine = networkEngine
    }
    
    //MARK: - Methods
    
    func getServiceStatus(completion: @escaping (Result<ServiceStatus, Error>) -> Void) {
        networkEngine.request(endpoint: ServiceStatusEndpoint.getData, completion: completion)
    }
    
    func getRandomFilm(completion: @escaping (Result<RandomFilmModel, Error>) -> Void) {
        networkEngine.request(endpoint: RandomFilmEndpoint.getData, completion: completion)
    }
    
}
