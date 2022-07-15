import UIKit
import FirebaseFirestore
import FirebaseAuth

class RegistroUsuariosViewController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    
    var lista = [Reuniones]()
    var db:Firestore!
    
    @IBAction func registrarButton(_ sender: Any) {
        
        if let email = txtCorreo.text, let contrasena = txtContrasena.text{
            Auth.auth().createUser(withEmail: email, password: contrasena) { (result, error) in
                
                if let result = result, error == nil{
                    
                    let apellido = self.txtApellidos.text
                    let nombres = self.txtNombres.text
                    let telefono = self.txtTelefono.text
                    
                    let campo : [String:Any] = ["apellido":apellido,"contrasena": contrasena,"correo":email,"nombre":nombres,"telefono":telefono]
                    self.db.collection("Usuarios").addDocument(data: campo) { (error) in
                        if let error=error{
                            print("fallo al guardar", error.localizedDescription)
                        }
                        else{
                            
                            print("AQUIIIIIIIIIIIIIIIIIIIIII")
                            
                            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MisReunionesViewController") as! MisReunionesViewController
                            vc.correo = email
                            self.navigationController?.pushViewController(vc, animated: true)

                        }
                    }
                }
                
                else{
                    let Alert = UIAlertController(title: "Error", message: "Error al registrar", preferredStyle: .alert)
                    Alert.addAction(UIAlertAction(title: "Aceptar", style: .default ))
                    self.present(Alert, animated: true, completion: nil)
                }
                
            }
            
            
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
     
    }

}
