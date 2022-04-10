//
//  PhotoSceneCollectionViewController.swift
//  PhotoApp
//
//  Created by  User on 09.04.2022.
//

import UIKit
import Photos
import CoreData

private let reuseIdentifier = "Cell"

class PhotoSceneCollectionViewController: UICollectionViewController {
    
    var images = [PHAsset()]
    var buttonAvatar: UIBarButtonItem!
    var buttonAccountsList: UIBarButtonItem!
    var userNickname: String!
    var selectedImageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.backgroundColor = .white
        
        buttonAccountsList = UIBarButtonItem(title: "Accounts", style: .plain, target: self, action: #selector(accountsList(parameters:)))
        self.navigationItem.rightBarButtonItem  = buttonAccountsList

        loadPhotos()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        if asset.location != nil {
            manager.requestImage(for: asset, targetSize: CGSize(width: 120, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.image.image = image
            }
        }
        }
    
        // Configure the cell
    
        return cell
    }
    
    func loadPhotos (){
        PHPhotoLibrary.requestAuthorization { [weak self] status in

            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)

                assets.enumerateObjects { (object, _, _) in
                    if object.location != nil {
                        self?.images.append(object)
                    }
                }

                self?.images.reverse()
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }

            }
        }
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedImageIndex = indexPath.row
        self.navigationItem.rightBarButtonItem = nil
        buttonAvatar = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: #selector(addProfilePhoto(parameters:)))
        self.navigationItem.rightBarButtonItem  = buttonAvatar
        return true
    }

    @objc func addProfilePhoto (parameters: UIBarButtonItem){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Account")
        guard let nickname = userNickname else {
            fatalError()
        }
        let predicate = NSPredicate(format: "nickname = '\(String(describing: nickname))'")
        fetchRequest.predicate = predicate
        
        do{
            let object = try context.fetch(fetchRequest)
            let asset = self.images[selectedImageIndex]
            let manager = PHImageManager.default()
            
            if object.count > 0 {
                if asset.location != nil {
                    manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
                    let objectUpdate = object.first as! NSManagedObject
                        objectUpdate.setValue(image?.jpegData(compressionQuality: 1.0), forKey: "image")
                    do{
                        try context.save()
                    } catch {
                        print(error)
                    }
                }
                }
            }
        }
        catch
        {
            print(error)
        }
        
        let vc = AccountsListTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func accountsList (parameters: UIBarButtonItem){
        let vc = AccountsListTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // Uncomment these methods to specify if an action menu should be disped for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
