import UIKit

final class MovieSelectionViewController: UIViewController {

    private let viewModel: MovieSelectionViewModel
    private let repository = Repository()
    
    // MARK: - UI
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .yellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
            descriptionLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20)
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
        repository.getRandomFilm { result in
            RequestTracker.shared.trackRequest()

            switch result {
            case .success(let success):
                print(success.docs.count)
//                let path = success.logo?.url
//                self.posterImage.loadImageFromUrl(path: path)
//                self.descriptionLabel.text = String(success.id ?? 0)

            case .failure(let failure):
                print("error getRandomFilm: \(failure.localizedDescription)")
            }
        }
    }
    
}

import UIKit

extension UIImageView {
    func loadImageFromUrl(path: String?) {
        guard let path = path else {
//            self.image = UIImage(systemName: "photo.circle")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
            return
        }

        let urlString = path
//        let placeholder = UIImage(systemName: "photo.circle")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
//        self.image = placeholder

        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
//                DispatchQueue.main.async {
////                    self.image = placeholder
//                }
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }
        task.resume()
    }
}

enum CoverSize: String {
    case m = "M"
    case l = "L"
}
