//
//  StopwatchViewController.swift
//  Clock
//
//  Created by Christian Otkjær on 06/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit
import Clock

class StopwatchViewController: UIViewController
{
    @IBOutlet weak var label: UILabel?
    
    let stopwatch = Stopwatch()
    var metronome = Metronome(interval: 0.1, closure: { })
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        metronome = Metronome(interval: 0.01, closure: { self.updateUI() })
        
        updateUI()
    }
    
    func updateUI()
    {
        updateLabel()
        updateButtons()
    }
    
    func updateLabel()
    {
        label?.text = String(format: "%.2f", stopwatch.elapsed)
    }
    
    // MARK: - Buttons
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    func updateButtons()
    {
        update(button: startButton, enabled: !stopwatch.isRunning)
        
        update(button: stopButton, enabled: stopwatch.isRunning)
        
        update(button: resetButton, enabled: stopwatch.isResettable && !stopwatch.isRunning)
    }
    
    func update(button: UIButton, enabled: Bool)
    {
        button.layer.cornerRadius = min(button.bounds.width, button.bounds.height) / 2
        
        button.isEnabled = enabled
        button.alpha = enabled ? 1 : 0.25
    }
    
    @IBAction func start()
    {
        stopwatch.start()
        metronome.start()
    }
    
    @IBAction func stop()
    {
        metronome.stop()
        stopwatch.stop()
        updateUI()
    }
    
    @IBAction func reset()
    {
        stopwatch.reset()
        updateUI()
    }
}
