//
//  GatershoppingList.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/8/1.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import Foundation


struct APIProduct : Decodable {
    
    
    var MemberInfo : String?
    var MemberAge : String?
    var Data : [APIProductDetail]?

}


struct APIProductDetail : Decodable {
    var ProductName : String?
    var ProductPrice : Float?
    var IsPay : String?
    var IsTake : String?
    var IsArrive : String?
    var Image : String?
    var QTY : Int?
}



struct APIShopMoney : Decodable {
    var RestOfShopMoney : Float
    var Data : [APIShopMoneyDetail]
}


struct APIShopMoneyDetail : Decodable {
    var SysRemark : String?
    var HPay : Float?
    var IOKind :  String?
    var SetData : String?
}


struct APISaleProductDetail : Decodable {
    var ProductName : String?
    var ProductPrice : Float?
    var ProductLink : String?
    var ProductPic :String?
    var Productabndat:String?
}


struct APISaleProducts : Decodable {
    var Data : [APISaleProductDetail]
    

}
