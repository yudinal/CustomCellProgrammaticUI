import UIKit

class RandomUserViewController: UIViewController {
    
    private let randomUserView = RandomUserView()
    
    private var users = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.randomUserView.collectionView.reloadData()
            }
            
        }
    }
    
    override func loadView() {
        view = randomUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Users"
        
        randomUserView.collectionView.dataSource = self
        randomUserView.collectionView.delegate = self
        
        randomUserView.collectionView.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "userCell")
        
        fetchUsers()
    }
    
    private func fetchUsers(_ name: String = "swift") {
        RandomUserAPIClient.fetchRandomUser(with: name) { (result) in
            switch result {
            case .failure(let appError):
                print("error fetching podcasts: \(appError)")
            case .success(let users):
                self.users = users
                dump(users)
            }
        }
    }
    
    
}

extension RandomUserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? UserCell else {
            fatalError("could not downcast to UserCell")
        }
        cell.backgroundColor = .white
        return cell
    }
}

extension RandomUserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95
        return CGSize(width: itemWidth, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let userInformationStoryboard = UIStoryboard(name: "UserInformation", bundle: nil)
        guard let detailUserViewController = userInformationStoryboard.instantiateViewController(identifier: "DetailUserViewController") as? DetailUserViewController else {
            fatalError("could not downcast to DetailUserViewController")
        }
        detailUserViewController.user = user
        navigationController?.pushViewController(detailUserViewController, animated: true)
    }
    
}
