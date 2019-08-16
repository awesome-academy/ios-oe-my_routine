//
//  DatePicker.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/8/19.
//  Copyright © 2019 huy. All rights reserved.
//

class DatePicker: UIView {
    
    // MARK: - Closures
    var didSelectText: ((Date) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Actions
    @IBAction func btnCancel(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func btnChoose(_ sender: Any) {
        didSelectText?(pickerView.date)
        self.removeFromSuperview()
    }
    
    // MARK: - Support Method
    func setupPickerView(_ type: UIDatePicker.Mode, title: String) {
        pickerView.datePickerMode = type
        pickerView.alpha = 0
        lblTitle.text = title
        self.addTapGesture(blurView)
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
    func addTapGesture(_ inView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DatePicker.hidePickerView))
        inView.addGestureRecognizer(tapGesture)
    }
    @objc func hidePickerView() {
        self.removeFromSuperview()
    }
}
