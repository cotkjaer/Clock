//
//  CountdownViewController.swift
//  Clock
//
//  Created by Christian Otkjær on 05/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit
import Clock

class CountdownViewController: UIViewController
{
    @IBOutlet weak var label: UILabel?

    let countdown = Countdown(seconds: 10)
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        countdown.delegate = self
        
        updateUI()
    }
    
    func updateUI()
    {
        updateLabel()
        updateButtons()
    }

    func updateLabel()
    {
        label?.text = (countdown.seconds - countdown.countedSeconds).description
    }
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    func updateButtons()
    {
        update(button: startButton, enabled: countdown.canStart())

        update(button: stopButton, enabled: countdown.canStop())
        
        update(button: resetButton, enabled: countdown.canReset())
    }
    
    func update(button: UIButton, enabled: Bool)
    {
        button.layer.cornerRadius = min(button.bounds.width, button.bounds.height) / 2
        
        button.isEnabled = enabled
        button.alpha = enabled ? 1 : 0.25
        
    }

    @IBAction func start()
    {
        countdown.start()
    }
    
    @IBAction func stop()
    {
        countdown.stop()
    }
    
    @IBAction func reset()
    {
        countdown.reset()
    }
}

// MARK: - CountdownListener

extension CountdownViewController: CountdownDelegate
{
    func countdownDidStop(_ countdown: Countdown)
    {
        updateUI()
    }
    
    func countdownDidStart(_ countdown: Countdown)
    {
        updateUI()
    }
    
    func countdownDidTick(_ countdown: Countdown)
    {
        updateUI()
    }
    
    func countdownDidReset(_ countdown: Countdown)
    {
        updateUI()
    }
}
