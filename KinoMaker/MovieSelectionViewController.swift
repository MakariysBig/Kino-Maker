import UIKit

final class MovieSelectionViewController: UIViewController {

    private let viewModel: MovieSelectionViewModel
    private let repository = Repository()
    private var films = [FilmInfo]()
    
    // MARK: - UI
    
    let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.backgroundColor = .white
        getRandomFilm()
        setupLayout()
        setupGesture()
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
    
    func setupLayout() {
        view.addSubview(coverView)
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            coverView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
        
        [posterImage, descriptionLabel].forEach { coverView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            posterImage.centerYAnchor.constraint(equalTo: coverView.centerYAnchor),
            posterImage.centerXAnchor.constraint(equalTo: coverView.centerXAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 100),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: coverView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: -16),
        ])
    }
    
    func setupGesture() {
        let tap = UIPanGestureRecognizer(target: self, action: #selector(didAction))
        coverView.addGestureRecognizer(tap)
        coverView.isUserInteractionEnabled = true
    }
    
    @objc func didAction(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else {
            return
        }
        
        let point = sender.translation(in: card)
        let xFromCenter = card.center.x - self.view.center.x

        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        if xFromCenter > .zero {
            print("right")
        } else {
            print("left")
        }
        
        card.alpha = 1 - (abs(xFromCenter) / abs(self.view.center.x))
        
        if sender.state == UIGestureRecognizer.State.ended {
            UIView.animate(withDuration: 0.3) {
                card.center = self.view.center
                card.alpha = 1
            }
        }
        
        sender.setTranslation(.zero, in: card)
    }
    
}
