//
//
//  Created by TuyenBQ on 7/7/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

typealias TextPickerResponse = (index: Int, stringValue: String)

class TextPicker: UIView {
    
    // MARK: - Variable
    var pickerData = [String]()
    
    // MARK: - Closures
    var didScrollToRow: ((TextPickerResponse?) -> Void)?
    var didSelectText: ((TextPickerResponse?) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPickerView()
    }
    
    // MARK: - Actions
    @IBAction func btnCancel(_ sender: Any) {
       self.removeFromSuperview()
    }
    @IBAction func btnSave(_ sender: Any) {
        let index = pickerView.selectedRow(inComponent: 0)
        didSelectText?((index: index, stringValue: pickerData[index]))
        self.removeFromSuperview()
    }
    
    // MARK: - Support Method
    func setupPickerView() {
        pickerView.alpha = 0
        pickerView.dataSource = self
        pickerView.delegate = self
        self.addTapGesture(blurView)
    }
    
    func configData(_ data: [String]) {
        pickerData = data
        pickerView.reloadAllComponents()
    }
    
    func showPickerView() {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.frame = UIApplication.shared.keyWindow?.bounds ?? .zero
        var containerFrame = containerView.frame
        containerFrame.origin.y = (SystemInfo.screenHeight + containerFrame.size.height)
        containerView.frame = containerFrame
        UIView.animate(withDuration: 0.4, animations: {
            containerFrame.origin.y = SystemInfo.screenHeight - containerFrame.size.height
            self.containerView.frame = containerFrame
            self.pickerView.alpha = 1
            self.containerView.alpha = 1
        })
    }
    
   @objc func hidePickerView() {
        self.removeFromSuperview()
    }
    
    func addTapGesture(_ inView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TextPicker.hidePickerView))
        inView.addGestureRecognizer(tapGesture)
    }

}

extension TextPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let itemValue = self.pickerData[row]
        return itemValue
    }
}

extension TextPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itemValue = pickerData[row]
        didScrollToRow?((index: row, stringValue: itemValue))
    }
}
