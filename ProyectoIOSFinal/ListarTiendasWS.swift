//
//  ListarTiendasWS.swift
//  ProyectoIOSFinal
//
//  Created by Carolina Mazzaglia on 30/04/17.
//  Copyright © 2017 Carolina Mazzaglia. All rights reserved.
///

import UIKit
import Alamofire
import SwiftyJSON

class ListarTiendasWS: NSObject {
    static func ListarTiendas(completion: @escaping (_ result: Array<TiendasEnt>) -> Void) {
        
        var resultadoT = Array<TiendasEnt>()
        
        let url = URL(string: "https://mobile.consorciohbo.com.pe/testservice/TestService.svc/ListarPuntosVenta")
        
        Alamofire.request(url!, method:.post, parameters:nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            let json = JSON(response.result.value)
            
            print(json[0]["Latitud"])
            
            for i in 0..<json.count{
                let listTiendas = TiendasEnt()
                
                listTiendas.nombre = json[i]["Nombre"].string
                listTiendas.direccion = json[i]["Direccion"].string
                listTiendas.latitud = json[i]["Latitud"].double
                listTiendas.longitud = json[i]["Longitud"].double
                
                resultadoT.append(listTiendas)
            }
            //TERMINO
            print(resultadoT)
            completion(resultadoT)
        }
        
    }

}
