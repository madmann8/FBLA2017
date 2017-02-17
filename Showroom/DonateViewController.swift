import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import SwiftyFORM



extension PrecisionSliderFormItem {
    func getString()->String {
        switch self.actualValue {
        case 0:
            return "00"
        case 1:
            return "01"
        case 2:
            return "02"
        case 3:
            return "03"
        case 4:
            return "04"
        case 5:
            return "05"
        case 6:
            return "06"
        case 7:
            return "07"
        case 8:
            return "08"
        case 9:
            return "09"
            
        default:
            return String(format: "%.0f", self.actualValue)
        }
        
    }
}


class DonateViewController: FormViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let ref=FIRDatabase.database().reference(fromURL: "https://fbla-c1a3b.firebaseio.com/")
    let item = FIRDatabase.database().reference(fromURL: "https://fbla-c1a3b.firebaseio.com/").child("items").childByAutoId()
    
    var storeItem:StoreItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        storeItem=StoreItem(image: nil, title: nil, description: nil, price: nil, condition: nil,ownerName:nil)
        ref.child("ItemUID").child(item.key).setValue(item.key)
       
    }
    
    
    override func populate(_ builder: FormBuilder) {
        self.view.backgroundColor=UIColor.darkGray
        
        builder.navigationTitle="Donate Item"
        builder+=itemName
        builder+=itemDescription
        builder+=dollarSlider
        builder+=centSlider
        builder += summary
        builder += imagePresenter
        builder.suppressHeaderForFirstSection=true
        builder+=conditionSlider
        builder+=button0
        navigationController?.isNavigationBarHidden=true
        
    }
    
    lazy var imagePresenter:ButtonFormItem = {
        let instance = ButtonFormItem()
        instance.title("Select Image")
        instance.action = {
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
            
        }
        return instance
        
        
    }()
    
    
    lazy var itemName: TextFieldFormItem = {
        let instance=TextFieldFormItem()
        instance.title="Item Name"
        instance.autocorrectionType = .no
        instance.submitValidate(CountSpecification.min(4), message: "Length must be minimum 4 Characters")
        instance.textDidChangeBlock = {[weak self] _ in
            self?.changeTitle(title: (self?.title)!)
        }
        return instance
        
    }()
    
    lazy var itemDescription: TextFieldFormItem = {
        let instance=TextFieldFormItem()
        instance.title="Item Description"
        instance.autocorrectionType = .no
        instance.submitValidate(CountSpecification.max(4), message: "Length must be maximum of 4 Characters")
        instance.textDidChangeBlock = {[weak self] _ in
            self?.changeDescription(description: (self?.title)!)
        }
        return instance
        
    }()
    
    lazy var dollarSlider: PrecisionSliderFormItem = {
        let instance = PrecisionSliderFormItem().decimalPlaces(0).minimumValue(0).maximumValue(100).value(0)
        instance.title = "Dollars"
        instance.sliderDidChangeBlock = { [weak self] _ in
            self?.updateSummary()
        }
        return instance
    }()
    
    lazy var conditionSlider: PrecisionSliderFormItem = {
        let instance = PrecisionSliderFormItem().decimalPlaces(1).minimumValue(0).maximumValue(50).value(0)
        instance.title = "Condition Rating"
        instance.sliderDidChangeBlock = { [weak self] _ in
            
            
            self?.updateSummary()
        }
        return instance
    }()
    
    lazy var summary: StaticTextFormItem = {
        return StaticTextFormItem().title("USD").value("-")
    }()
    
    lazy var centSlider: PrecisionSliderFormItem = {
        let instance = PrecisionSliderFormItem().decimalPlaces(0).minimumValue(0).maximumValue(99).value(99)
        instance.title = "Cents"
        instance.sliderDidChangeBlock = { [weak self] _ in
            self?.updateSummary()
        }
        return instance
    }()
    
    
    
    func updateSummary() {
        let temp=(dollarSlider.actualValue)+centSlider.actualValue/100
        self.changePrice(price: temp)
        summary.value="$\(String(format: "%.0f", dollarSlider.actualValue)).\(centSlider.getString())"
        self.changeCondtion(condition: conditionSlider.actualValue)
    }
    
    lazy var button0: ButtonFormItem = {
        let instance = ButtonFormItem()
        instance.title = "Submit"
        instance.action = { [weak self] in
            if (self?.checkForSubmit())!{
                self?.submitToFirebase()
                self?.exit()}
        }
        return instance
    }()
    
    func exit() {
        dismiss(animated: true, completion: nil)
        
    }
    
    func submitToFirebase() {
        self.item.child("title").setValue(self.storeItem?.title)
        self.item.child("description").setValue(self.storeItem?.description)
        self.item.child("price").setValue(self.storeItem?.price)
        self.item.child("condition").setValue(self.storeItem?.condition)
        ref.child("users").observeSingleEvent(of: .value, with: { snapshot in
            self.item.child("username").setValue(snapshot.childSnapshot(forPath: (FIRAuth.auth()?.currentUser?.uid)!).childSnapshot(forPath: "name").value)
        })
        uploadImage()

        
        
    }
    
    
    func checkForSubmit()->Bool {
        var check=true
        if self.storeItem?.title==nil {
            presentAlert(title: "Missing Item Title", body: "Form must include a title for the item.")
            check=false
        }
        if self.storeItem?.description==nil {
            presentAlert(title: "Missing Item Description", body: "Form must include a description of the item.")
            check=false
        }
        if self.storeItem?.image==nil {
            presentAlert(title: "Missing Item Image", body: "Form must include an image of the item.")
            check=false
            
        }
        if self.storeItem?.condition==nil {
            presentAlert(title: "Missing Item Condition", body: "Form must include a condition rating of the item.")
            check=false
        }
        if self.storeItem?.price==nil {
            presentAlert(title: "Missing Item Price", body: "From must include a price for the item.")
            check=false
        }
        return check
        
    }
    
    func changeTitle(title:String){
        self.storeItem?.title=self.itemName.value
    }
    
    func changeDescription(description:String){
        self.storeItem?.description=self.itemDescription.value
    }
    
    func changeImage(image:UIImage){
        self.storeItem?.image=image
    }
    
    func changeCondtion(condition:Double){
        self.storeItem?.condition=condition
    }
    
    func changePrice(price:Double){
        self.storeItem?.price=price
    }
    
    func presentAlert (title:String, body:String){
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func  imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.storeItem?.image = image
            
        }
        else
        {
            
        }
        dismiss(animated: true, completion: nil)
    }
    func uploadImage() {
        let saveImage = self.storeItem?.image
        let imageData:NSData = UIImagePNGRepresentation(saveImage!)! as NSData
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("item_images").child("\(imageName).png")
        
        storageRef.put(imageData as Data, metadata: nil, completion:   { (metadata, error) in
            
            if error != nil {
                print(error)
                return
            }else {
                
                self.item.child("imageURL").setValue(metadata?.downloadURL()?.absoluteString)
            }
        }
            )
        }
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    print("canceled picker")
    dismiss(animated: true, completion: nil)
}
}



