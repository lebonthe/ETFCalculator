//
//  ViewController.swift
//  ETFCalculator
//
//  Created by Min Hu on 2023/9/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lowestFeeTextField: UITextField!
    
    @IBOutlet weak var interestTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    
    @IBOutlet weak var feeDiscountSlider: UISlider!
    
    @IBOutlet weak var feeDiscountLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var unitSwitch: UISwitch!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var explainDiscountButton: UIButton!
    
    @IBOutlet weak var explainLabel: UILabel!
   
    @IBOutlet var tapGesture01: UITapGestureRecognizer!
    
    @IBOutlet var tapGesture02: UITapGestureRecognizer!
    
    @IBOutlet var tapGesture03: UITapGestureRecognizer!
    
    @IBOutlet var tapGesture04: UITapGestureRecognizer!
    
    @IBOutlet var prices: [UILabel]!
    
    @IBOutlet var fees: [UILabel]!
    
    @IBOutlet var profitsOrLosses: [UILabel]!
    
    @IBOutlet weak var interestByYear: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        lowestFeeTextField.text = "0"
        // 設定 slider 初始值
        feeDiscountSlider.value = 100
        // 設定 slider 的極大值與極小值
        feeDiscountSlider.maximumValue = 100
        feeDiscountSlider.minimumValue = 0
        // 設定 slider 從 tint 到極小值條狀的顏色
        feeDiscountSlider.minimumTrackTintColor = UIColor(red: 84/255, green: 73/255, blue: 75/255, alpha: 1)
        // 設定 slider 從 tint 到極大值條狀的顏色
        feeDiscountSlider.maximumTrackTintColor = UIColor(red: 179/255, green: 57/255, blue: 81/255, alpha: 1)

        // 設定一個圖片與其大小，放到 tint 上
        let thumbImage = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        // tint 不移動時的圖片
        feeDiscountSlider.setThumbImage(thumbImage, for: .normal)
        // tint 移動時的圖片
        feeDiscountSlider.setThumbImage(thumbImage, for: .highlighted)
        // 設定 Segmented Control 的字體大小
        segmentedControl.setTitleTextAttributes([.font:  UIFont.systemFont(ofSize: 17)], for: .normal)
        // 設定 Segmented Control 的字體顏色
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 84/255, green: 73/255, blue: 75/255, alpha: 1)], for: .normal)
        // 設定被選到的 Segmented Control 的背景顏色
        segmentedControl.selectedSegmentTintColor = UIColor(cgColor: CGColor(red: 241/255, green: 241/255, blue: 237/255, alpha: 1))
        // 設定 Switch 狀態為 On ，並開啟動畫效果
        unitSwitch.setOn(true, animated: true)
        // 設定 Switch 滑塊顏色
        unitSwitch.thumbTintColor = UIColor(named: "accentColor")
        // 設定 Switch On 狀態的顏色
        unitSwitch.onTintColor = UIColor(cgColor: CGColor(red: 145/255, green: 199/255, blue: 177/255, alpha: 1))
        // 折數解釋 Label 隱藏
        explainLabel.isHidden = true
        // 問號預設為 Accent Color 顏色
        explainDiscountButton.tintColor = UIColor(named: "accentColor")
        
        lowestFee = "0" // 最低手續費
        interest = "" // 配息
        buyprice = "" // 價格
        amount = "" // 數量
        
        lowestFeeTextField.delegate = self
        interestTextField.delegate = self
        priceTextField.delegate = self
        amountTextField.delegate = self
        
    }
    // 點一下收鍵盤
    @IBAction func closeKeyboard(_ sender: Any) {
        // 收起 view 中所有正在編輯的textField 的鍵盤
        view.endEditing(true)
    }
    
    @IBAction func closeKeyboard2(_ sender: UITextField) {
    }
    
    
    
    var feeDiscountToInt = 100
    // 拖曳 slider 邊顯示數值
    @IBAction func dragFeeDiscountSlider(_ sender: UISlider) {
        // 將 slider 數值轉換為整數
        feeDiscountToInt = Int(sender.value)
        // label 顯示已轉換為文字的 feeDiscountToInt
        feeDiscountLabel.text = String(feeDiscountToInt)
    }
    // 改變數量用 張數/股數計算
    @IBAction func changeUnit(_ sender: UISwitch) {
        if unitSwitch.isOn == true{
            unitLabel.text = "張"
        }else{
            unitLabel.text = "股"
        }
    }
    // 點擊問號的動作
    @IBAction func explainButtonTapped(_ sender: UIButton) {
        // 如果手續費折數 Label 隱藏
        if explainLabel.isHidden == true {
            // 手續費折數 Label 改為顯示
            explainLabel.isHidden = false
            // 更改問號顏色
            explainDiscountButton.tintColor = UIColor(cgColor: CGColor(red: 203/255, green: 133/255, blue: 105/255, alpha: 1))
            // 如果手續費折數 Label 顯示
        }else{
            // 手續費折數 Label 改為隱藏
            explainLabel.isHidden = true
            // 更改問號顏色
            explainDiscountButton.tintColor = UIColor(named: "accentColor")
        }
    }
    // 點擊最低手續費 TextField
    @IBAction func tapGesture01Tapped(_ sender: UITapGestureRecognizer) {
        lowestFeeTextField.becomeFirstResponder()
    }
    // 點擊配息 TextField
    @IBAction func tapGesture02Tapped(_ sender: UITapGestureRecognizer) {
        interestTextField.becomeFirstResponder()
    }
    // 點擊價格 TextField
    @IBAction func tapGesture03Tapped(_ sender: UITapGestureRecognizer) {
        priceTextField.becomeFirstResponder()
    }
    // 點擊數量 TextField
    @IBAction func tapGesture04Tapped(_ sender: UITapGestureRecognizer) {
        amountTextField.becomeFirstResponder()
    }
    var lowestFee = "0" // 最低手續費
    var interest = "" // 配息
    var buyprice = "" // 價格
    var amount = "" // 數量
    // 點擊數字鍵盤
    @IBAction func clickNumber(_ sender: UIButton) {
        
        // 將數字 button 的 tag 存到 number 中
        let number = sender.tag
        
        // 如果最低手續費 TextField 是 FirstResponder
        if lowestFeeTextField.isFirstResponder == true{
            // 將數字變成字串
            lowestFee += String(number)
            // 將字串加入 TextField
            lowestFeeTextField.text = lowestFee
            // 如果配息 TextField 是 FirstResponder
        }else if interestTextField.isFirstResponder == true{
            interest += String(number)
            interestTextField.text = interest
            // 如果價格 TextField 是 FirstResponder
        }else if priceTextField.isFirstResponder == true{
            buyprice += String(number)
            priceTextField.text = buyprice
            print(number)
            // 如果數量 TextField 是 FirstResponder
        }else if amountTextField.isFirstResponder == true{
            amount += String(number)
            amountTextField.text = amount
        }
    }
    // 點擊倒退鍵
    @IBAction func clickReturn(_ sender: UIButton) {
        if lowestFeeTextField.isFirstResponder == true{
            // 如果最低手續費內有字元
            if lowestFee.count > 0 {
                // 移除最後一個字元
                lowestFee.removeLast()
            }
            lowestFeeTextField.text = lowestFee
        }else if interestTextField.isFirstResponder == true{
            if interest.count > 0 {
                interest.removeLast()
            }
            interestTextField.text = interest
        }else if priceTextField.isFirstResponder == true{
            if buyprice.count > 0 {
                buyprice.removeLast()
            }
            priceTextField.text = buyprice
        }else if amountTextField.isFirstResponder == true{
            if amount.count > 0 {
                amount.removeLast()
            }
            amountTextField.text = amount
        }
    }
    // 點擊小數點 Button
    @IBAction func clickDecimalPoint(_ sender: UIButton) {
        // 如果最低手續費 TextField 是 FirstResponder 且 字串中不包含 "."
        if interestTextField.isFirstResponder == true && interest.contains(".") == false{
            // 如果字串是空的
            if interest.isEmpty{
                // 出現 "0."
                interest += "0."
                // 如果字串不是空的
            }else{
                // 出現 "."
                interest += "."
            }
        }else if priceTextField.isFirstResponder == true && buyprice.contains(".") == false {
            if buyprice.isEmpty{
                buyprice += "0."
            }else{
                buyprice += "."
            }
        }
    }
    
    
    @IBAction func calculate(_ sender: UIButton) {
        print("Price before conversion: \(buyprice)")
        if let priceDouble = Double(buyprice) {
                // Perform calculations with priceDouble
                // Example: prices[7].text = String(priceDouble)
                print(priceDouble)
            print("Price after conversion: \(priceDouble)")
            } else {
                // Handle the case where the price is not a valid number
                print("Invalid price value")
            }
        
        // 如果有空白欄位，則跳出提示窗
        if interestTextField.hasText == false{
            let controller = UIAlertController(title: "請輸入配息", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true)
        }else if priceTextField.hasText == false{
            let controller = UIAlertController(title: "請輸入買進價格", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true)
        }else if amountTextField.hasText == false{
            let controller = UIAlertController(title: "請輸入張數/股數", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true)
        }else if lowestFeeTextField.hasText == false{
            let controller = UIAlertController(title: "請輸入最低手續費", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true)
        }else{
            // 將買進價格放在第 6 欄數字
            prices[5].text = buyprice
            // 設定兩個變數用以指定不同的 prices label
            var i = 4, j = 6
            // 設定兩個變數用來運算不同的賣出價格
            var priceDownDouble: Double = 0, priceUpDouble: Double = 0
            // 迴圈五次，設定常數k
            for k in 1...5{
                // 買進價格往低價的 label 更改
                // 將使用者輸入的買進價格變成 Doubel 型別
                priceDownDouble = Double(buyprice)!
                // 將賣出價格減去0.05 * k
                priceDownDouble = priceDownDouble - 0.05 * Double(k)
                prices[i].text = String(priceDownDouble)
                // 往前一個 label
                i -= 1
                // 買進價格往高價的 label 更改
                priceUpDouble = Double(buyprice)!
                // 將賣出價格加上0.05 * k
                priceUpDouble = priceUpDouble + 0.05 * Double(k)
                prices[j].text = String(priceUpDouble)
                // 往後一個 label
                j += 1
            }
            // 宣告常數 feeOringinal 以儲存買賣手續費
            let feeOringinal = 0.285/100
            // 宣告常數 amountDouble 將數量由 String 轉成 Double
            let amountDouble = Double(amount)!
            // 宣告常數 feeDiscountToIntDouble 將手續費折數由 String 轉成 Double
            let feeDiscountToIntDouble = Double(feeDiscountToInt)
            
            // 宣告常數 interestDouble 將配息 interest 轉為 Double 型別
            let interestDouble = Double(interest)!
            // 宣告變數 interestByYearDouble 為 Double 型別
            var interestByYearDouble:Double = 0
            // 如果為季配息
            if segmentedControl.selectedSegmentIndex == 0{
                // 儲存年化配息的 Double 型別常數
                interestByYearDouble = interestDouble/Double(buyprice)! * 4 * 100
                // 將 interestByYearDouble 變為字串放入年化配息率的 Label 中
                interestByYear.text =  String(format: "%.2f",interestByYearDouble)
                // 如果為月配息
            }else if segmentedControl.selectedSegmentIndex == 1{
                // 儲存年化配息的 Double 型別常數
                interestByYearDouble = interestDouble/Double(buyprice)! * 12 * 100
                // 將 interestByYearDouble 變為字串放入年化配息率的 Label 中
                interestByYear.text =  String(format: "%.2f",interestByYearDouble)
                // 如果為半年配息
            }else if segmentedControl.selectedSegmentIndex == 2{
                // 儲存年化配息的 Double 型別常數
                interestByYearDouble = interestDouble/Double(buyprice)! * 2 * 100
                // 將 interestByYearDouble 變為字串放入年化配息率的 Label 中
                interestByYear.text =  String(format: "%.2f",interestByYearDouble)
                // 如果為年配息
            }else if segmentedControl.selectedSegmentIndex == 3{
                // 儲存年化配息的 Double 型別常數
                interestByYearDouble = interestDouble/Double(buyprice)! * 100
                // 將 interestByYearDouble 變為字串放入年化配息率的 Label 中
                interestByYear.text =  String(format: "%.2f",interestByYearDouble)
            }
            let buypriceDouble = Double(buyprice)!
            
            // 如果單位轉換的開關為開
            if unitSwitch.isOn{
                // 手續費使用張數計算
                let feeDouble = Double(buyprice)! * 1000 * feeOringinal * amountDouble * (feeDiscountToIntDouble/100)
                // 如果手續費大於等於最低手續費
                if feeDouble >= Double(lowestFee)! * 2{
                    // 全部手續費欄位的文字儲存為 String 型別的 feeDouble
                    for i in 0...10{
                        fees[i].text = String(format: "%.2f", feeDouble)
                    }
                    // 用手續費計算損益
                    for i in 0...10{
                        let priceDouble = Double(prices[i].text!)
                        let gain = (priceDouble! + interestByYearDouble) * amountDouble * 1000
                        let loss = (buypriceDouble * amountDouble * 1000 + feeDouble)
                        let profitOrLossDouble = gain - loss
                        profitsOrLosses[i].text = String(format: "%.2f", profitOrLossDouble)
                    }
                // 如果手續費小於最低手續費
                }else{
                    // 全部手續費欄位的文字儲存為最低手續費
                    for i in 0...10{
                        fees[i].text = String(Double(lowestFee)! * 2)
                    }
                    // 用最低手續費計算損益
                    for i in 0...10{
                        let priceDouble = Double(prices[i].text!)
                        let gain = (priceDouble! + interestByYearDouble) * amountDouble * 1000
                        let loss = (buypriceDouble * amountDouble * 1000 + Double(lowestFee)!)
                        let profitOrLossDouble = gain - loss
                        profitsOrLosses[i].text = String(format: "%.2f", profitOrLossDouble)
                    }
                }
                
            // 如果單位轉換的開關為關
            }else{
                // 手續費使用股數計算
                let feeDouble = Double(buyprice)! * feeOringinal * amountDouble * (feeDiscountToIntDouble/100)
                // 如果手續費大於等於最低手續費
                if feeDouble >= Double(lowestFee)! * 2{
                    // 全部手續費欄位的文字儲存為 String 型別的 feeDouble
                    for i in 0...10{
                        fees[i].text = String(format: "%.2f", feeDouble)
                    }
                    // 用手續費計算損益
                    for i in 0...10{
                        let priceDouble = Double(prices[i].text!)
                        let gain = (priceDouble! + interestByYearDouble) * amountDouble
                        let loss = (buypriceDouble * amountDouble + feeDouble)
                        let profitOrLossDouble = gain - loss
                        profitsOrLosses[i].text = String(format: "%.2f", profitOrLossDouble)
                    }
                    // 如果手續費小於最低手續費
                }else{
                    // 全部手續費欄位的文字儲存為最低手續費
                    for i in 0...10{
                        fees[i].text = String(Double(lowestFee)! * 2)
                    }
                    // 用最低手續費計算損益
                    for i in 0...10{
                        let priceDouble = Double(prices[i].text!)
                        let gain = (priceDouble! + interestByYearDouble) * amountDouble
                        let loss = (buypriceDouble * amountDouble + Double(lowestFee)!)
                        let profitOrLossDouble = gain - loss
                        profitsOrLosses[i].text = String(format: "%.2f", profitOrLossDouble)
                    }
                }
            }
        }
    }
    }
    


extension ViewController: UITextFieldDelegate {
    // 實現 textField 的代理方法，以獲取 textField 的變化
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 檢查哪個 textField 正在編輯
        if textField == priceTextField {
            // 獲取當前 textField 的文本
            if let text = textField.text {
                // 更新 price 變量
                buyprice = text
            }
        }
        return true
    }
}
