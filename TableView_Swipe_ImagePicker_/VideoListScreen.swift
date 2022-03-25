
import UIKit
import SwipeCellKit


//Defacto ViewController
class VideoListScreen: UIViewController{
    var imageName = ""
    var imagePath = URL(string: "")
    var videos: [Video] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videos = createArray()
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        videos = createArray()
//    }
    
    func createArray() -> [Video] {
        var tempVideos: [Video] = []
                
        let video01 = Video(image: #imageLiteral(resourceName: "thumb_01") , title: "Your First App", isThumbsUp: false)
        let video02 = Video(image: #imageLiteral(resourceName: "thumb_04") , title: "Sapolsky Aggression", isThumbsUp: false)
        let video03 = Video(image: #imageLiteral(resourceName: "thumb_02") , title: "Laghlimi calling sala3ima", isThumbsUp: false)
        let video04 = Video(image: #imageLiteral(resourceName: "thumb_05") , title: "Sapolsky Languages", isThumbsUp: false)
        let video05 = Video(image: #imageLiteral(resourceName: "thumb_06") , title: "Your App Portfolio", isThumbsUp: false)
        let video06 = Video(image: #imageLiteral(resourceName: "thumb_03") , title: "Fusion Reactor", isThumbsUp: false)
        
        tempVideos.append(video01)
        tempVideos.append(video02)
        tempVideos.append(video03)
        tempVideos.append(video04)
        tempVideos.append(video05)
        tempVideos.append(video06)
        
        return tempVideos
    }

    @IBAction func AddItem(_ sender: Any) { //++++++
        
        print("ADD New Item, Image picker start")
        print("Calling showImagePickerOptions(): ")
        showImagePickerOptions() // nothing returned
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
}


//MARK: - SwipeTableViewCellDelegate
extension VideoListScreen: UITableViewDataSource, UITableViewDelegate {
    
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let video = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        
        cell.delegate = self
        
        cell.setVideo(video: video)
        
        return cell
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //___________________________________________________________________
        
        func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController{
            let imagePicker = UIImagePickerController()
                imagePicker.sourceType = sourceType
                imagePicker.allowsEditing = true
            return imagePicker
        }

        func showImagePickerOptions(){
            let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose a picture from Library, camera or convert a URL to QR Code", preferredStyle: .actionSheet)
            
            //Image picker for camera  📸 📸 📸 📸 📸 📸 📸 📸 📸 📸 📸 📸 📸 📸 📸 📸
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
                //Capture self to avoid retain cycles
                guard let self = self else {
                    return
                }
                let cameraImagePicker = self.imagePicker(sourceType: .camera)
                cameraImagePicker.delegate = self
                self.present(cameraImagePicker, animated: true) {
                    //Todo
                }
            }
            
                //Image Picker for Library 📚 📚 📚 📚 📚 📚 📚 📚 📚 📚 📚 📚 📚 📚 📚
                let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
                    //Capture self to avoid retain cycles
                    guard let self = self else {
                        return
                    }
                    let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
                    libraryImagePicker.delegate = self
                    self.present(libraryImagePicker, animated: true) {
                        //TODO
                    }
                }
            
            //Convert URL To QR Code Here 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹 🎹
            let URL_Action = UIAlertAction(title: "From URL", style: .default) { [weak self] (action) in
                //Capture self to avoid retain cycles
                guard let self = self else {
                    return
                }

                print("URL to QR Code Conversion")
                
            }
            
                // Image Picker Buttons
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertVC.addAction(cameraAction)
                alertVC.addAction(libraryAction)
                alertVC.addAction(URL_Action)
                alertVC.addAction(cancelAction)
                self.present(alertVC, animated: true, completion: nil)
        }
    //___________________________________________________________________
    
    
} //viewcontroller bottom

extension VideoListScreen: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        let image = info[.originalImage] as! UIImage  //User selects image
        imagePath = saveJpg(image)                    //save image to disk, give it a name and get back its url

        //let imagePathString = imagePath?.description
        let image2   = UIImage(contentsOfFile: imagePath!.path) //Get Image from file path
        let video01 = Video(image: image2! , title: (imagePath?.description)!, isThumbsUp: false)

        videos.append(video01)
        tableView.reloadData()
        
        self.dismiss(animated: true, completion: nil)
    }// Image pikcer controller
}//Extension

//MARK: - SwipeTableViewCellDelegate
extension VideoListScreen: SwipeTableViewCellDelegate {
    
    //
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath:
         IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let dataItem = videos[indexPath.row] as Video
        let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        
        
        switch orientation {
        case .left:
            let thumbsUpAction = SwipeAction(style: .default, title: nil , handler: {
                action, indexPath in
                print("Run thumbsUp Action code") //update model with favotrite
                let updateStatus = !dataItem.isThumbsUp
                dataItem.isThumbsUp = updateStatus
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
                tableView.reloadRows(at: [indexPath], with: .none)
                })
            })
            
            thumbsUpAction.title = !dataItem.isThumbsUp ? "Like":"Unlike"
            thumbsUpAction.image = UIImage(systemName: dataItem.isThumbsUp ? "hand.thumbsup" : "hand.thumbsup.fill")
            thumbsUpAction.backgroundColor = dataItem.isThumbsUp ? .systemGray2 : #colorLiteral(red: 0, green: 0.2314, blue: 0.8784, alpha: 1) /* #003be0 */

            
            
            //new stuff here
            let closure: (UIAlertAction) -> Void = { (action: UIAlertAction) in
                //not sure about this
                //cell.hideSwipe(animated: true) //????????????????????
                
                if let selectedTitle = action.title {
                    print("selectedTitle: \(selectedTitle)")
                    let alertController = UIAlertController(title: selectedTitle,
                    message: "Some Message", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Option Alert Message", style: .cancel, handler: nil))
                   
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            
            //MoreItems Action
            let moreAction = SwipeAction(style: .default, title: nil, handler: {
                action, indexPath in
                print("Run MoreItems Action Code")
                
                let bottomAlertController = UIAlertController(title: nil,
                    message: nil, preferredStyle: .actionSheet)
                
                bottomAlertController.addAction(UIAlertAction(title: "Option 1", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "Option 2", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "Option 3", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: closure))
                                                
               self.present(bottomAlertController, animated: true, completion: nil)
            })
            
            //moreACtion stuff
            moreAction.title = "More Action"
            moreAction.image = UIImage(systemName: "ellipsis.circle")
            moreAction.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            
    
        return [moreAction, thumbsUpAction]

            
            
        case .right:
            let deleteAction = SwipeAction(style: .destructive, title: nil, handler:{
                action, indexPath in
                print("Run Delete Action Code")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
                    self.videos.remove(at: indexPath.row)   // handle action by updating model with deletion
                    tableView.reloadData()
                })
            })
            
            deleteAction.title = "Delete" // customize the action appearance
            deleteAction.image = UIImage(systemName: "trash.fill")
            deleteAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            
        return [deleteAction]
        }
        
    }
    
    //
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath:
         IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        //
        options.expansionStyle = .selection
        options.transitionStyle = .drag
        
        return options
    }
    
}
