//
//  ViewController.swift
//  DemoApp
//
//  Created by Leonardo Geus on 26/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Coxswain

class ViewController: UIViewController, CoxswainDelegate {


    @IBOutlet weak var waveForm: WaveformView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let cox = Coxswain(idToSpeech: "ea9bed37-b941-42fe-aab3-c13b2f1a0ec8",textToSpeech: "{diler}Ola Diler{changeBackground3}. Vou te mostrar as possibilidades desta ferramenta chamada Coxwain{waveform}, primeiramente vou contar até quatro. Vamos lá{changeBackground}, um{1}, dois{2}, três{3}, quatro{4}. Estes foram meus primeiros passos para eu dominar{changeBackground2} o mundo{end}.")
        let cox2 = Coxswain(textToSpeech: "{diler}Ola Murilo{changeBackground3}. Vou te mostrar as possibilidades desta ferramenta chamada Coxwain{waveform}, primeiramente vou contar até quatro. Vamos lá{changeBackground}, um{1}, dois{2}, três{3}, quatro{4}. Estes foram meus primeiros passos {changeBackground2}para eu dominar{end} o mundo{end}.", voice: .PtBrFemale)
        cox2.delegate = self
        cox2.addWaveform(view:waveForm)
        cox2.play()
        //let cox = Coxswain(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol{1}")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didFoundedActionInSpeech(actionText: String) {
        print(actionText)
        switch actionText {
        case "diler":
            appearLabel(label: labelTitle)
            break
        case "1":
            appearLabel(label: labelOne)
            break
        case "2":
            appearLabel(label: labelTwo)
            break
        case "3":
            appearLabel(label: labelThree)
            break
        case "4":
            appearLabel(label: labelFour)
            break
        case "waveform":
            UIView.animate(withDuration: 0.5) {
                self.waveForm.alpha = 1
            }
            break
        case "changeBackground":
            changeBackground()
        case "changeBackground2":
            changeBackground2()
        case "changeBackground3":
            changeBackground2()
        case "end":
            performSegue(withIdentifier: "segueToOne", sender: self)
            break
        default:
            break
        }
        
        
    }
    
    func changeBackground() {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor(red: 142/255, green: 186/255, blue: 210/255, alpha: 1)
        }
    }
    
    func changeBackground2() {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor(red: 238/255, green: 83/255, blue: 129/255, alpha: 1)
        }
    }
    
    func changeBackground3() {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor(red: 172/255, green: 135/255, blue: 244/255, alpha: 1)
        }
    }
    
    func appearLabel(label:UILabel) {
        UIView.animate(withDuration: 0.2) {
            label.alpha = 1
        }
    }


}

