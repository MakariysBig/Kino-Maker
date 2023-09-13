import UIKit

final class MovieSelectionViewController: UIViewController {

    private let viewModel: MovieSelectionViewModel
    private let repository = Repository()
    private var films = [FilmInfo]()
    
    // MARK: - UI
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .yellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialize
    
    init(viewModel: MovieSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getServiceStatus()
        view.backgroundColor = .white
        getRandomFilm()
        setupLayout()
    }
    
    private func setupLayout() {
        [posterImage, descriptionLabel].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            posterImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            posterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 100),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
}

// MARK: - Private functions

private extension MovieSelectionViewController {
    
    func getServiceStatus() {
        repository.getServiceStatus { result in
            RequestTracker.shared.trackRequest()
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("error getServiceStatus: \(failure.localizedDescription)")
            }
        }
    }
    
    func getRandomFilm() {
        
        if UserDefaultsManager.filmArray.isEmpty {
            print("from Network")
            repository.getRandomFilm { result in
                RequestTracker.shared.trackRequest()
                
                switch result {
                case .success(let model):
                    UserDefaultsManager.filmArray = model.docs
                    print(model.docs.count)
                    print(model.limit)
                    //                let array = model.docs[0].poster.previewURL
                    let path = model.docs[0].poster.previewURL
                    self.posterImage.loadImageFromUrl(path: path)
                    self.descriptionLabel.text = model.docs[0].description
                    
                case .failure(let failure):
                    print("error getRandomFilm: \(failure.localizedDescription)")
                }
            }
        } else {
            print("from DB")
            films = UserDefaultsManager.filmArray
            
            let path = films[0].poster.previewURL
            self.posterImage.loadImageFromUrl(path: path)
            self.descriptionLabel.text = films[0].description
        }
    }
    
}
