import UIKit
import FirebaseFirestore
import SwiftUI
import SpriteKit
import FirebaseAuth
struct Reuniones {
    let dia:String
    let hora:String
    let id:String
    let estado:String
    let trabajador:String
    let correo:String
}


class MisReunionesViewController: UIViewController {

    var lista = [Reuniones]()
    var db:Firestore!
    var correo :String = ""
    
    @IBOutlet weak var tabla: UITableView!
    
    
    @IBAction func backButton(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "r") as! RegistrarReunionesViewController
        vc.correo = correo
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func cerrarsSesionButton(_ sender: Any) {
        do{
        try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
            }
        catch{
                print("Se ha producido un error")
                }
    }
    
    
//    init(email:String){
//        self.correo = email
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        tabla.delegate = self
        tabla.dataSource = self
        
        print("###########################")
        print(correo)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        traerDatos()
    }
    
}


extension MisReunionesViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCell
        
        let reunion = lista[indexPath.row]
//        cell.textLabel?.text = reunion.dia
//        cell.detailTextLabel?.text = reunion.hora
//        cell.detailTextLabel?.text = reunion.estado
        cell.lblDia.text = reunion.dia
        cell.lblHora.text = reunion.hora
        cell.lblTrabajador.text = reunion.trabajador
        cell.lblEstado.text = reunion.estado
        return cell
    }
    
    func traerDatos (){
        self.db.collection("Reuniones").whereField("correo", isEqualTo: self.correo).addSnapshotListener{ (QuerySnapshot, Error )in
            if let Error = Error{
                print("Error",Error.localizedDescription)
            }
            
            else{
                self.lista.removeAll()
                for document in QuerySnapshot!.documents{
                    let valores = document.data()
                    let id = document.documentID
                    let dia = valores["dia"] as? String ?? "NA"
                    let email = valores["correo"] as? String ?? "NA"
                    let hora = valores["hora"] as? String ?? "NA"
                    let trabajador = valores["trabajador"] as? String ?? "NA"
                    let estado = valores["estado"] as? String ?? "NA"
                    let reunion = Reuniones(dia: dia, hora: hora, id:id,estado: estado,trabajador:trabajador,correo: email)
                    self.lista.append(reunion)
                    DispatchQueue.main.async {
                        self.tabla.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
            let reunion : Reuniones
            reunion = self.lista[indexPath.row]
            let id = reunion.id
            self.db.collection("Reuniones").document(id).delete()
            
        }
        let configuracion = UISwipeActionsConfiguration(actions: [delete])
        return configuracion
    }
    
}
