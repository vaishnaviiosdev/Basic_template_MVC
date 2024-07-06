//
//  NetworkManager.swift
//  RFIDDemoProj1
//
//  Created by YASAR B on 06/07/24.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager: NSObject {
    
    class func sendRequestToServer(urlString:String, method: HTTPMethod? = .post, params : [String:Any]?, completion:@escaping (NetworkManagerResponse)->Void){
        guard Connectivity.isConnectedToInternet else {
            completion(.init(response: nil, statusCode: nil, status: false, error: "Please check your internet connection and try again!"))
            return
        }
        
        var headers: [String:String] = ["Content-Type": "application/json"]
        
        print("Check Received Params: ---> \(JSON(params))")
        print("Check ValidJSON Object :---> \(JSONSerialization.isValidJSONObject(JSON(params)))")
        
        let urlStr = URL(string: urlString)
        var request = URLRequest(url: urlStr!)
        if method != nil {
            request.httpMethod = method!.rawValue
        }
       
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(JSON(params))
            if params != nil {
                request.httpBody = jsonData
            }
        }
        catch {
            print("Check Error :---> \(error)\n Description:---> \(error.localizedDescription)")
        }
        
        //request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON(completionHandler:{  response in
            print("\n\n~~~~~ DebugConsole ~~~~\n--> HTTPStatusCode: \(response.response?.statusCode ?? 100) <-- \(urlString)\nCheck Params :--> \(JSON(params))\nCheck Response :--> \(JSON(response.data ?? Data()))\n~~~~~ End DebugConsole ~~~~\n\n")
            print("The response is \((JSON(response.value ?? "<null>")))")
            switch response.result {
                case .success(let data):
                    if response.response?.statusCode == 200 {
                        guard response.response != nil else {
                            completion(.init(response: nil, statusCode: response.response?.statusCode, status: false, error: nil))
                            fatalError("No internet connection")
                        }
                        let json = JSON(data)
                        completion(.init(response: json, statusCode: response.response?.statusCode, status: json["status"].boolValue, error: json["message"].stringValue))
                        
                    }else{
                        let json = JSON(data)
                        completion(.init(response: nil, statusCode: response.response?.statusCode, status: false, error: json["message"].stringValue))
                    }
                    break
                case .failure(let error):
                    completion(.init(response: nil, statusCode: response.response?.statusCode, status: false, error: "Something went wrong. Please try again later!"))
                    break
            }
        })
    }
    
}

public struct NetworkManagerResponse {
    
    /// The server's response to the URL request.
    public let responseJson: JSON?
    
    /// The error encountered while executing or validating the request.
    public let message: String?
    
    /// Status of the request.
    public let success: Bool?
    
    /// ResponseCode of the request.
    public let serverResponseCode: Int?
    
    
    init(response: JSON?,statusCode: Int?, status: Bool?,error: String?) {
        self.message = error
        self.responseJson = response
        self.success = status
        self.serverResponseCode = statusCode
    }
}

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}


