//
//  ViewController.swift
//  ProyectoIOSFinal
//
//  Created by Carolina Mazzaglia on 28/04/17.
//  Copyright © 2017 Carolina Mazzaglia. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD
import ReachabilitySwift
var compras = Array<CompraEnt>()
private let reuseIdentifier = "celda"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var productos = Array<ProductosEnt>()
    @IBOutlet weak var UICollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let hud = MBProgressHUD(view: self.view)
        hud.show(animated: true)
        //comprobar si tengo internet
        let reachability = Reachability()!
        
        if reachability.isReachable {
            productos.removeAll()
            ListarProductosWS.ListarTodos { (resultado) in
                //self.productos = resultado
                self.registrarEnCoreData(listado: resultado)
                self.listarDeCoreData()
                self.UICollectionView.reloadData()
            }
        }else{
            self.listarDeCoreData()
            var alertControler:UIAlertController
            //definimos la alerta que se va a mostrar definimos un controler
            alertControler=UIAlertController(title: "Cargar Productos", message: "Debe tener Internet para actualizar el listado de productos", preferredStyle: UIAlertControllerStyle.alert)
            //creamos la accion
            let accionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                print("Ok")})
            //asignamos la accion y motramos
            alertControler.addAction(accionOK)
            self.present(alertControler, animated: true, completion: {})
        }
        
        hud.hide(animated: true)

    }
    
    func registrarEnCoreData (listado: Array<ProductosEnt>) {
        for item in listado {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Productos", in: context)
            let productos = NSManagedObject(entity: entity!, insertInto: context)
            
            //asignamos
            productos.setValue(item.nombre, forKey: "nombre")
            productos.setValue(item.precio, forKey: "precio")
            //registramos el dato manejando errores
            //context.save()
            do {
                try context.save()
                self.productos.append(item)
                print(item.nombre + "se registro correctamnte")
            } catch let error as NSError {
                print("no se registro: \(error.userInfo)")
            }
            
        }
    }
    
    func listarDeCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"Productos")
        
        do {
            let resultado = try context.fetch(fetchRequest)
            for item in resultado {
                //convertir NSmanagedObject a publicacion
                let producto = ProductosEnt()
                
                producto.nombre = item.value(forKey: "nombre") as! String!
                producto.precio = item.value(forKey: "precio") as! Int!
                
                self.productos.append(producto)
                
            }
        } catch let error as NSError {
            print(error.userInfo)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productos.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! itemCell
        
        let indice = indexPath.row
        let producto:ProductosEnt
        producto = productos[indice]
        
        cell.lbNombre.text = producto.nombre
        cell.lbPrecio.text = "S/. \(producto.precio!)"
        cell.img.image = UIImage(named: producto.lstimg)
        cell.tag = indexPath.row
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(long))
        longGestureRecognizer.minimumPressDuration = 1 //segundos
        cell.addGestureRecognizer(longGestureRecognizer)
        return cell
        
    }
    
    func long(sender: UILongPressGestureRecognizer) {
        
        let listdatos = CompraEnt()
        
        let indice = sender.view!.tag
        print(indice)
        
        listdatos.nombre = productos[indice].nombre
        listdatos.precio = productos[indice].precio
        listdatos.imagen = productos[indice].lstimg
        compras.append(listdatos)
        
        var alertControler:UIAlertController
        //definimos la alerta que se va a mostrar definimos un controler
        alertControler=UIAlertController(title: "Agregar al Carrito", message: "Fue Agregado al Carrito", preferredStyle: UIAlertControllerStyle.alert)
        //creamos la accion
        let accionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            print("Ok")})
        //asignamos la accion y motramos
        alertControler.addAction(accionOK)
        self.present(alertControler, animated: true, completion: {})
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }


}

