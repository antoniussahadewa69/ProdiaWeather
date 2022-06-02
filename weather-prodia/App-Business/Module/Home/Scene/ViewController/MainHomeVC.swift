//
//  MainHomeVC.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import UIKit

class MainHomeVC: UIViewController {
    
    @IBOutlet weak var lblValueLat: UILabelBarlowRegular!
    @IBOutlet weak var lblValueLong: UILabelBarlowRegular!
    @IBOutlet weak var lblValueTimezone: UILabelBarlowRegular!
    @IBOutlet weak var lblValuePressure: UILabelBarlowRegular!
    @IBOutlet weak var lblValueHumidity: UILabelBarlowRegular!
    @IBOutlet weak var lblValueWindSpeed: UILabelBarlowRegular!
    @IBOutlet weak var cvHomeMenu: UICollectionView!
    @IBOutlet weak var btnLogout: UIButton!
    
    
    
    struct VCProperty {
        static let storyboard : String = "Home"
        static let identifier : String = "mainHomeVCIdentifier"
        static let errMsg : String = "Internal Server Err"
        static let zeroInt : Int = 0
    }
    
    var router : HomeRouter?
    var vm = MainHomeVM()
    
    var flagRouterHome : Int = VCProperty.zeroInt
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVM()
        self.setupRouter()
        self.setupView()
        self.setupAction()
    }
    
    func setupVM(){
        self.vm.delegate = self
        self.vm.getDataWeather()
    }
    
    func setupRouter(){
        self.router = HomeRouter(viewController: self)
    }
    
    func setupAction(){
        self.btnLogout.addTarget(self, action: #selector(btnLogoutClick(button:)), for: .touchUpInside)
    }
    
    func setupView(){
        self.setupCollectionView()
    }
}

extension MainHomeVC {
    
    @objc func btnLogoutClick(button: UIButton) {
        if flagRouterHome == 0 {
            print("ini logout")
            Prefs.removeSession()
            AppRouter.switchToLoginPin(completion: nil)
            flagRouterHome = 1
            return
        }
    }
    
    func setupCollectionView(){
        self.setupCollectionViewCell()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (width-30) / 2, height: 100)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        
        cvHomeMenu!.collectionViewLayout = layout
        self.cvHomeMenu.delegate = self
        self.cvHomeMenu.dataSource = self
        self.cvHomeMenu.showsVerticalScrollIndicator = false
    }
    
    func setupCollectionViewCell(){
        let nib = UINib(nibName: HomeMenuCVCell.nibName, bundle: nil)
        self.cvHomeMenu.register(nib, forCellWithReuseIdentifier: HomeMenuCVCell.identifier)
    }
        
}

extension MainHomeVC : MainHomeVMProtocol {
    
    func didSuccesHomeGetData(rep: DataWeatherResp) {
        DispatchQueue.main.async {
            self.lblValueLat.text = "\(self.vm.dataLat)"
            self.lblValueLong.text = "\(self.vm.dataLong)"
            self.lblValuePressure.text = "\(self.vm.dataPressure)"
            self.lblValueTimezone.text = "\(self.vm.dataTimezone)"
            self.lblValueHumidity.text = "\(self.vm.dataHumidity)"
            self.lblValueWindSpeed.text = "\(self.vm.dataWindSpeed)"
            self.cvHomeMenu.reloadData()
        }
    }
    
    func didErrHomeGetData() {
        DispatchQueue.main.async {
            self.showToast(message: VCProperty.errMsg)
        }
    }
}

extension MainHomeVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.menuHomeSetup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier:HomeMenuCVCell.identifier , for: indexPath)  as! HomeMenuCVCell
        cell.setupView(payload: HomeMenuCVCellPayload(
            isWindSpeed: self.vm.menuHomeSetup[indexPath.row].isWindSpeed,
            isHumidity: self.vm.menuHomeSetup[indexPath.row].isHumidity,
            isPressure: self.vm.menuHomeSetup[indexPath.row].isPressure,
            isTimezone: self.vm.menuHomeSetup[indexPath.row].isTimezone,
            isLong: self.vm.menuHomeSetup[indexPath.row].isLong,
            isLat: self.vm.menuHomeSetup[indexPath.row].isLat,
            dataLat: self.vm.menuHomeSetup[indexPath.row].dataLat,
            dataLong: self.vm.menuHomeSetup[indexPath.row].dataLong,
            dataTimezone: self.vm.menuHomeSetup[indexPath.row].dataTimezone,
            dataPressure: self.vm.menuHomeSetup[indexPath.row].dataPressure,
            dataHumidity: self.vm.menuHomeSetup[indexPath.row].dataHumidity,
            dataWindSpeed: self.vm.menuHomeSetup[indexPath.row].dataWindSpeed))
        return cell
    }
}
