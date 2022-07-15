import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistrarReunionesViewController: UIViewController {
    
    @IBOutlet weak var DiaPicker: UIPickerView!
    @IBOutlet weak var horaPicker: UIPickerView!
    @IBOutlet weak var trabajadorSegment: UISegmentedControl!
    
    var lista = [Reuniones]()
    var db:Firestore!
    
    var dia:String=""
    var hora:String=""
    var trabajador:String=""
    var estado:String="pendiente"
    var correo:String=""
    
    private let semana = [
        "Lunes",
        "Martes",
        "Miércoles",
        "Jueves",
        "Viernes",
        "Sábado"
    ]

    
    private let horarios = [
        "10:00",
        "12:00",
        "14:00",
        "16:00",
        "18:00",
        "20:00"
    ]
    
    private let trabajadores = [
        "Juan M.",
        "Carlos M.",
        "Pedro M."
    ]
    

    
    
    @IBAction func listarButton(_ sender: UIButton){
//        let reunionStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//        let reunionesView = reunionStoryBoard.instantiateViewController(withIdentifier: "MisReunionesViewController") as? MisReunionesViewController
//        reunionesView?.correo = correo
        navigationController?.popViewController(animated: true)
    }
    
    
    
//    @IBAction func listaButton(_ sender: UIButton) {
//        print("se presionoooooooooooooooooooooooooo")
////
////       let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MisReunionesViewController") as? MisReunionesViewController else {
////            print("no se encontró viewcontroller")
////            return
////                     }
////       self.navigationController?.pushViewController(viewController, animated: true)
//        self.navigationController?.popViewController(animated: true)
////        //    }
    
    
//    @IBAction func listaButton(_ sender: UIButton) {
//                print("GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
////                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MisReunionesViewController") as! MisReunionesViewController
////               let reunionStoryBoard = UIStoryboard(name: "Main", bundle: nil)
////   guard let reunionesView = reunionStoryBoard.instantiateViewController(withIdentifier: "MisReunionesViewController") as? MisReunionesViewController else {
////                                   fatalError("error")
////                                }
////        reunionesView.correo = self.correo
////                self.navigationController?.popViewController(animated: true)
//                self.present(MisReunionesViewController(), animated: true, completion: nil)
//
//    }
    
    

    @IBAction func guardarButton(_ sender: Any) {
        trabajador = (trabajadorSegment.titleForSegment(at: trabajadorSegment.selectedSegmentIndex) as String?)!
        
        let campo : [String:Any] = ["dia":dia,"hora": hora,"trabajador":trabajador,"estado":estado,"correo":correo]
        db.collection("Reuniones").addDocument(data: campo) { (error) in
            if let error=error{
                print("fallo al guardar", error.localizedDescription)
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()

        DiaPicker.dataSource = self
        DiaPicker.delegate = self

        horaPicker.dataSource = self
        horaPicker.delegate = self
        
//        llenar el segment control
        trabajadorSegment.removeAllSegments()
        for (index, value) in
               trabajadores.enumerated(){
            trabajadorSegment.insertSegment(withTitle: value, at: index, animated: true)
        }
    }

}





extension RegistrarReunionesViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == DiaPicker {
            return semana.count
        }
        else {
            return horarios.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == DiaPicker {
            return semana[row]
        }
        else {
            return horarios[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch pickerView {
        
    case DiaPicker :
            print("diass seleccionado \(semana[row])")
            self.dia=semana[row]
        
    case horaPicker :
            print("horario seleccionado \(horarios[row])")
            self.hora=horarios[row]
       
        default:
            print("No seleccionaste nadaa")
        }
    }
    

    
}
