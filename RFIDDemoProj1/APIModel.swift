//
//  APIModel.swift
//  RFIDDemoProj1
//
//  Created by YASAR B on 06/07/24.
//

import Foundation
import SwiftyJSON

class ChatModel  {
    
    var message:String?
    var messages: [MessagesModel]!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        message = json["message"].stringValue
        messages = [MessagesModel]()
        let messageArray = json["messages"].arrayValue
        for item in messageArray {
            let messageModal =  MessagesModel(fromJson: item)
            messages.append(messageModal)
        }
    }
}

class MessagesModel {
    
    //var message:MessageDataModel!
    //var user:MessageUserModel!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        //message = MessageDataModel(fromJson: json["message"])
        //user = MessageUserModel(fromJson: json["user"])
    }
}

class dataModel {
    
    var id: Int
    var userId: Int
    var titleStr: String
    var bodyStr: String
    
    init(json: JSON) {
        id = json["id"].intValue
        userId = json["userId"].intValue
        titleStr = json["title"].stringValue
        bodyStr = json["body"].stringValue
    }
}

class employeeModel {
    
    var dataArr: [employeedataModel]
    var message: String
    var status: String
    
    init(json: JSON) {
        
        message = json["message"].stringValue
        status = json["status"].stringValue
        dataArr = [employeedataModel]()
        let dataArray = json["data"].arrayValue
        for item in dataArray {
            let dataModel =  employeedataModel(json: item)
            dataArr.append(dataModel)
        }
    }
}

class employeedataModel {
    
    var id: Int
    var employeeAge: Int
    var employeeName: String
    var employeeSalary: Double
    var profileImage: String
    
    init(json: JSON) {
        id = json["id"].intValue
        employeeAge = json["employee_age"].intValue
        employeeName = json["employee_name"].stringValue
        employeeSalary = json["employee_salary"].doubleValue
        profileImage = json["profile_image"].stringValue
    }
}


