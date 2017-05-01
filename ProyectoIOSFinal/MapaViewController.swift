//
//  MapaViewController.swift
//  ProyectoIOSFinal
//
//  Created by Carolina Mazzaglia on 30/04/17.
//  Copyright © 2017 Carolina Mazzaglia. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var tiendas = Array<TiendasEnt>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListarTiendasWS.ListarTiendas { (resultado) in
            self.tiendas = resultado
            self.mapa.reloadInputViews()
        }
        
        print(tiendas)
            
        //let location = CLLocation(latitude: tiendas[0].latitud, longitude: tiendas[0].longitud)
            
        //centrar(ubicacion: location)
        
        for item in tiendas {
            
            let location = CLLocation(latitude: item.latitud, longitude: item.longitud)
            let marcador = Marcador(title: item.nombre, coordinate: location.coordinate, subtitle:item.direccion)
            mapa.addAnnotation(marcador)

        }

        // Do any additional setup after loading the view.
    }
    
    func centrar(ubicacion: CLLocation) {
        let region = MKCoordinateRegion(center: ubicacion.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        mapa.setRegion(region, animated: true)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marcador"
        var view: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
            dequeuedView.annotation = annotation
            view = dequeuedView as! MKPinAnnotationView
        }else{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView!
            view.detailCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView!
            view.canShowCallout = true
            
        }
        return view
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
