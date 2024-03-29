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
    @IBOutlet weak var viewHomeMenu: UIView!
    @IBOutlet weak var btnLogout: UIButton!
    
    struct VCProperty {
        static let storyboard : String = "Home"
        static let identifier : String = "mainHomeVCIdentifier"
        static let errMsg : String = "Internal Server Err"
        static let zeroInt : Int = 0
        static let err : String = "Err--"
    }
    
    var router : HomeRouter?
    var vm = MainHomeVM()
    
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
        Prefs.removeSession()
        AppRouter.switchToLoginPin(completion: nil)
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
            self.cvHomeMenu.isHidden = false
            self.viewHomeMenu.isHidden = true
            
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
            self.cvHomeMenu.isHidden = true
            self.viewHomeMenu.isHidden = false
            
            self.lblValueLat.textColor = .red
            self.lblValueLong.textColor = .red
            self.lblValuePressure.textColor = .red
            self.lblValueTimezone.textColor = .red
            self.lblValueHumidity.textColor = .red
            self.lblValueWindSpeed.textColor = .red
            
            self.lblValueLat.text = VCProperty.err
            self.lblValueLong.text = VCProperty.err
            self.lblValuePressure.text = VCProperty.err
            self.lblValueTimezone.text = VCProperty.err
            self.lblValueHumidity.text = VCProperty.err
            self.lblValueWindSpeed.text = VCProperty.err
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
