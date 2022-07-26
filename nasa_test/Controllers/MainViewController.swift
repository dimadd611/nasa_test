//
//  MainViewController.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: UI Elements
    private lazy var roverTypeCV: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 370, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(RoverTypeCell.self, forCellWithReuseIdentifier: RoverTypeCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    //MARK: Variables
    var curiosity: [Rover]?
    var opportunity: [Rover]?
    var spirit: [Rover]?
    static var photos = [Rover]()
    
    var roverType = [
    "Curiosity",
    "Opportunity",
    "Spirit"
    ]
    //MARK: Functions
    func setupUI(){
        view.addSubviews(roverTypeCV)
        
        roverTypeCV.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    
    private func updateCoreData(photos: RoverPhoto, type: String) {
      let rover = photos.photos.prefix(100)
      for i in rover {
        let newRover = CoreDataManager.shared.createNote()

        newRover.roverType = type
        newRover.id = Int64(i.id)
        newRover.earthDate = i.earthDate
        newRover.image = i.imgSrc
        CoreDataManager.shared.save()
      }
        fetchNotesFromStorage()
    }
    private func fetchCuriosity() {
      APICaller.shared.getCuriosityRovers{ [weak self] result in
        DispatchQueue.main.async { [self] in
          switch result {
          case .success(let model):
  //          self?.curiosity = model




            self?.updateCoreData(photos: model, type: "Curiosity")

            CoreDataManager.shared.save()
              
          case .failure(let error):
            print("Parsing Error: \(error.localizedDescription)")
            //          self?.failedToGetProfile()
          }
        }
      }
    }

    private func fetchSpirit() {
      APICaller.shared.getSpiritRovers{ [weak self] result in
        DispatchQueue.main.async { [self] in
          switch result {
          case .success(let model):

            self?.updateCoreData(photos: model, type: "Spirit")

            CoreDataManager.shared.save()
              
          case .failure(let error):
            print("Parsing Error: \(error.localizedDescription)")
            //          self?.failedToGetProfile()
          }
        }
      }
    }
    private func fetchOpportunity() {
      APICaller.shared.getOpportunityRovers{ [weak self] result in
        DispatchQueue.main.async { [self] in
          switch result {
          case .success(let model):
            self?.updateCoreData(photos: model, type: "Opportunity")

            CoreDataManager.shared.save()
  //          print(model.photos.count)
              
          case .failure(let error):
            print("Parsing Error: \(error.localizedDescription)")
            //          self?.failedToGetProfile()
          }
        }
      }
    }
    
    func fetchNotesFromStorage() {
      MainViewController.photos = CoreDataManager.shared.fetchRovers()
      curiosity = MainViewController.photos.filter{$0.roverType == "Curiosity" }
      opportunity = MainViewController.photos.filter{ $0.roverType == "Opportunity"}
      spirit = MainViewController.photos.filter{$0.roverType == "Spirit"}
      }

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchCuriosity()
        fetchSpirit()
        fetchOpportunity()
        fetchNotesFromStorage()
        roverTypeCV.delegate = self
        roverTypeCV.dataSource = self
        setupUI()
    }
}
extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverTypeCell.identifier, for: indexPath) as? RoverTypeCell else {return UICollectionViewCell()}
        cell.setup(title: roverType[indexPath.row])
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      switch indexPath.row{
      case 0:
        if let photos = curiosity {
          self.navigationController?.pushViewController(RoverViewController(photos: photos, rootOption: .curiosity), animated: true)
        }
      case 1:
        if let photos = opportunity {
          self.navigationController?.pushViewController(RoverViewController(photos: photos, rootOption: .opportunity), animated: true)
        }
      case 2:
        if let photos = spirit {
          self.navigationController?.pushViewController(RoverViewController(photos: photos,  rootOption: .spirit), animated: true)
        }
      default:
        break
      }
    }
}
