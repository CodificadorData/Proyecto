import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    var lista = [Reuniones]()
    
    
    
    
    @IBAction func accederButton(_ sender: Any) {
        if let email = txtCorreo.text, let contrasena = txtContrasena.text{
            Auth.auth().signIn(withEmail: email, password: contrasena) { (result, error) in
                
                if error == nil{
                    print("LOGEADOOOOOOOOOOOOOOOOOOOOOOO")
                    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MisReunionesViewController") as! MisReunionesViewController
                    vc.correo = self.txtCorreo.text!
                    self.navigationController?.pushViewController(vc, animated: true)
//                    self.navigationController?.pushViewController(MisReunionesViewController(email: result.user.email!), animated: true)
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

    }
}
