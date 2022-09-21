//
//  POIViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/9/13.
//

import UIKit

class POIViewController: UIViewController {
    
    private var pois = [["不显示位置", ""]]
    //private var pois = [Array(repeating: "", count: 2)]
    private let locationManager = AMapLocationManager()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    
        //带逆地理信息的一次定位（返回坐标和地址信息）
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //定位超时时间，最低2s，此处设置为2s
        locationManager.locationTimeout = 5
        //逆地理请求超时时间，最低2s，此处设置为2s
        locationManager.reGeocodeTimeout = 5
        
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                    
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            guard let poivc = self else { return }
            
            if let location = location {
                print("location:", location)
            }
            
            if let reGeocode = reGeocode {
                print("reGeocode:", reGeocode)
                //1.直辖市的province和city是一样的
                //2.偏远乡镇的street等小范围的东西都可能是nil
                //3.用户在海上或海外,若未开通‘海外LBS服务’,则都返回nil
                //AMapLocationReGeocode:{formattedAddress:四川省成都市武侯区建国巷靠近锦官城; country:中国;province:四川省; city:成都市; district:武侯区; citycode:028; adcode:510107; street:建国巷; number:8号; POIName:锦官城; AOIName:锦官城;}
                //如果是海外地址可以在else做些提示
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else { return }
                //判断直辖市
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province!
                //print("\(province)\(reGeocode.city!)\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")")
                let currentPOI = [reGeocode.poiName!, "\(province)\(reGeocode.city!)\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")"]
                poivc.pois.append(currentPOI)
                
                DispatchQueue.main.async {
                    poivc.tableView.reloadData()
                }
            }
        })

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension POIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POITableViewCell
        
        let poi = pois[indexPath.row]
        cell.poi = poi
        
        return cell
    }
    
    
}
