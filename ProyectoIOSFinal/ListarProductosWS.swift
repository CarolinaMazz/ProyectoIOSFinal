//
//  ListarProductosWS.swift
//  ProyectoIOSFinal
//
//  Created by Carolina Mazzaglia on 28/04/17.
//  Copyright © 2017 Carolina Mazzaglia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ListarProductosWS: NSObject {
    
    static func ListarTodos(completion: @escaping (_ result: Array<ProductosEnt>) -> Void) {
        
        var resultado = Array<ProductosEnt>()
        
        let url = URL(string: "https://mobile.consorciohbo.com.pe/testservice/TestService.svc/ListarProductos")
        
        Alamofire.request(url!, method:.post, parameters:nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            let json = JSON(response.result.value)
            
            for i in 0..<json.count{
                let listproductos = ProductosEnt()
                
                listproductos.nombre = json[i]["Nombre"].string
                listproductos.precio = json[i]["Precio"].int
                listproductos.lstimg = "producto"
                //listproductos.lstimg = json[i]["lstImagenes"][0].string
                
                resultado.append(listproductos)
            }
            //TERMINO
            //print("resultado")
            //print(resultado)
            completion(resultado)
        }
        
    }

}
