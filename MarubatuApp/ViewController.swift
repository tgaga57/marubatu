//
//  ViewController.swift
//  MarubatuApp
//
//  Created by 志賀大河 on 2019/08/03.
//  Copyright © 2019 志賀大河. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isHint: Bool = false
    
    var result: [Bool] = []
    
    // クイズ結果を表示
    @IBOutlet weak var resultLabel: UILabel!
    //クイズの問題を表示
    @IBOutlet weak var kuizulabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var reset: UIButton!

    
    // 問題を管理
    let questions: [[String: Any]] = [
        [ "question": "iphoneアプリを開発する統合環境はzcodeである","answer": false,
          "hint": "知"
            
        ], ["question": "ドラえもんは常に浮いている","answer": true,
            "hint": "知りません"
        ],
    ]
    
    var currentQuestionNum: Int = 0
    
    /// lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
        resultLabel.isHidden = true
        reset.isHidden = true
    }
    
    /// function
    
    //問題を表示する関数
    func showQuestion() {
        // currentQuestionNum(問題番号)の問題を取得
        let quetion = questions[currentQuestionNum]
        
        // 問題(辞書型)からKeyを指定して内容を取得
        if let que = quetion["question"] as? String {
            // question Key の中身をLabelに代入
            //textにはString のみ
            kuizulabel.text = que
        }
    }
    
    // 回答をチェックする関数
    // 正解なら次の問題を表示します
    func checkAnswer(yourAnswer: Bool) {
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool {
            
            if yourAnswer == ans {
                
                if currentQuestionNum >= questions.count - 1 {
                    resultLabel.text =  "\(questions.count)問中\(result.count)問正解しました"
                    // view.isHidden = true
                    resultLabel.isHidden = false
                    hintButton.isHidden = true
                    reset.isHidden = false
                    
                    return
                } else {
                // 正解
                // currentQuestionNumを1足して次の問題に進む
                currentQuestionNum += 1
                showAlert(mesage: "天才だ")
                result.append(true)
                }
                
            }else {
                
                if currentQuestionNum >= questions.count - 1 {
                    resultLabel.text =  "\(questions.count)問中\(result.count)問正解しました"
                    //       view.isHidden = true
                    resultLabel.isHidden = false
                    hintButton.isHidden = true
                    reset.isHidden = false
                    return
                } else {
                // 不正解
                currentQuestionNum += 1
                showAlert(mesage: "残念。。。。")
                }
            }
        }else{
            print("答えが入ってません")
            return
        }
        // currentQuestionNumの値が問題数以上だったら最初の問題に戻す
        
        // 問題を表示します。
    //正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
       }
    
    func showAlert(mesage: String) {
        //アラートの作成
        let alert = UIAlertController(title: nil, message: mesage,preferredStyle: .alert)
        //アラートのアクション
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        //作成したアラートに閉じるボタンを追加
        alert.addAction(close)
        //アラート表示
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        currentQuestionNum = 0
        resultLabel.isHidden = true
        hintButton.isHidden = false
        isHint = false
        reset.isHidden = true
        showQuestion()
    }
    
    
    
    
    @IBAction func hinto(_ sender: Any) {
        if !isHint {
            let question = questions[currentQuestionNum]
            if let que = question["hint"] as? String {
            showAlert(mesage: que)
                isHint = true
            }
        }else {
            showAlert(mesage: "出ません")
        }
    }
    
    //バツボタン
    @IBAction func nobuttom(_ sender: Any) {
        //バツボタンの動作
        checkAnswer(yourAnswer: false)
    }
    
    //まるボタン
    @IBAction func yesButton(_ sender: Any){
        //まるボタンの動作
        checkAnswer(yourAnswer: true)
    }
}

