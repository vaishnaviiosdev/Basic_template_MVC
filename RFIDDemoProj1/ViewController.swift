
import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    var responseData:[dataModel] = []
    var employeeData:[employeedataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callAPI()
        self.employeeAPI()
    }
    
    func callAPI() { //Without response key
        //var params: [String : Any] = [:]
        
        let url = "https://jsonplaceholder.typicode.com/posts"
    
        self.startActivityIndicator()
        NetworkManager.sendRequestToServer(urlString: url, method: nil, params: nil) { (response) in
            self.stopActivityIndicator()
            if let jsonResponse = response.responseJson {
                let resArray = jsonResponse.arrayValue
                if resArray.count > 0 {
                    self.responseData = resArray.map { dataModel(json: $0) }
                    print("Check first value is \(self.responseData.count > 0 ? self.responseData.first!.titleStr : "NoData")")
                }
                else {
                    
                }
            }
            else {
                print("Error Occurred")
            }
        }
    }
    
    func employeeAPI() {
        //var params: [String : Any] = [:]
        
        let url = "https://dummy.restapiexample.com/api/v1/employees"
        
        self.startActivityIndicator()
        NetworkManager.sendRequestToServer(urlString: url, method: .get, params: nil) { (response) in
            self.stopActivityIndicator()
            if let jsonResponse = response.responseJson {
                let resData = employeeModel(json: jsonResponse)
                
                let resArray = resData.dataArr
                if resArray.count > 0 {
                    self.employeeData = resArray
                    print("Check first employee value is \(self.employeeData.count > 0 ? self.employeeData.first!.employeeName : "NoData")")
                }
                else {
                    
                }
            }
            else {
                print("Error Occurred")
            }
        }
    }
}

//MARK: --- DATA LOAD FROM LOCAL JSON FILE
/*func fetchDatafromJSON() {
    if let batch = self.parseJSONFromFile(named: "shopping") {
        for dict in batch.categories {
            let newProduct = ProductTable(context: DB_Context)
            newProduct.product_id = dict.id
            newProduct.product_name = dict.name
            newProduct.product_items = "\(dict.itemArr ?? [])"
            COREDATA_MANAGER.savedata()
        }
        self.retrieveData()
    }
}

//MARK: --- PARSING LOCAL JSON INTO JSONOBJECT
func parseJSONFromFile(named fileName: String) -> dataModel? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSON(data: data)
            return dataModel(fromJson: json)
        } catch {
            print("Error reading JSON file:", error.localizedDescription)
            return nil
        }
    } else {
        print("JSON file not found.")
        return nil
    }
}*/



