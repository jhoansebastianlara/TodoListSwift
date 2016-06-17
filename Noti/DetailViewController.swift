//
//  DetailViewController.swift
//  Noti
//
//  Created by Sebastián  Lara on 6/6/16.
//  Copyright © 2016 Sebastián  Lara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var item: String?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("item: \(item)")
        self.descriptionLabel.text = item
        
        // para detectar el toque del label de fecha
        let tapGestureRecognizer = UITapGestureRecognizer()
        // toca una vez
        tapGestureRecognizer.numberOfTapsRequired = 1
        // se especifica que cuando toque con un dedo (max 4 es permitido)
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.addTarget(self, action: "toogleDatePicker")
        self.dateLabel.addGestureRecognizer(tapGestureRecognizer)
        // activamos para que detecte el toque
        self.dateLabel.userInteractionEnabled = true
    }
    
    func toogleDatePicker() {
        self.imageView.hidden = self.datePicker.hidden
        self.datePicker.hidden = !self.datePicker.hidden
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateSelected(sender: UIDatePicker) {
        print("fecha selecionada \(sender.date)")
        self.dateLabel.text = formatDate(sender.date)
        self.datePicker.hidden = true
        self.imageView.hidden = false
    }
    
    @IBAction func addImage(sender: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.delegate = self
        // imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // todos los ui tienen el sgte metodo
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func addNotification(sender: UIBarButtonItem) {
        if let dateString = self.dateLabel.text {
            if let date = parseDate(dateString) {
                scheduleNotification(self.item!, date: date)
            }
        }
    }
    
    func scheduleNotification(message: String, date: NSDate) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = message
        localNotification.alertTitle = "Recuerda tu tarea: "
        localNotification.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func formatDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.stringFromDate(date)
    }
    
    func parseDate(string: String) -> NSDate? {
        let parser = NSDateFormatter()
        parser.dateFormat = "dd/MM/yyyy HH:mm"
        return parser.dateFromString(string)!
    }
    
    // MARK: Image picker controller methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // en lugar de enviarnos una imagen, envia un diccionario (porque se puede meter cualquier cosa: img, videos)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        }
        // cerramos el componente
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
