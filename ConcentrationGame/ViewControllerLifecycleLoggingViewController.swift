//
//  ViewControllerLifecycleLoggingViewController.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 8/25/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import UIKit

class ViewControllerLifecycleLoggingViewController: UIViewController {
    
    private struct LogGlobals {
        var prefix = ""
        var instanceCounts = [String:Int]()
        var lastLogTime = Date()
        var indentationInterval: TimeInterval = 1
        var indentationString = "__"
    }
    
    private static var logGlobals = LogGlobals()
    
    private static func logPrefix(for loggingName: String) -> String {
        if logGlobals.lastLogTime.timeIntervalSinceNow < -logGlobals.indentationInterval {
            logGlobals.prefix += logGlobals.indentationString
            print("")
        }
        
        logGlobals.lastLogTime = Date()
        return logGlobals.prefix + loggingName
        
    }
    
    private static func bumpInstanceCount(for loggingName: String) -> Int {
        logGlobals.instanceCounts[loggingName] = (logGlobals.instanceCounts[loggingName] ?? 0) + 1
        return logGlobals.instanceCounts[loggingName]!
    }
    
    private var instanceCount: Int!
    
    var vclLoggingName: String {
        return String(describing: type(of: self))
    }
    
    private func logVcl(_ msg: String){
        if instanceCount == nil {
            instanceCount = ViewControllerLifecycleLoggingViewController.bumpInstanceCount(for: vclLoggingName)
        }
        print("\(ViewControllerLifecycleLoggingViewController.logPrefix(for: vclLoggingName)) (\(instanceCount!)) \(msg)")
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        logVcl("init(coder: ) - created via Interface Builder ")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logVcl("init(nibName:bundle: ) - create in code")
    }
    
    deinit {
        logVcl("Left the heap")
    }
    
    
    override func awakeFromNib(){
        logVcl("awakeFromNib()")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        logVcl("viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        logVcl("viewWillAppear(animated = \(animated))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logVcl("viewDidAppear(animated = \(animated))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVcl("viewWillDisappear(animated = \(animated))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logVcl("viewDidDisappear(animated = \(animated))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logVcl("didRecieveMemoryWarning()")
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        logVcl("viewWillLayoutSubviews() bounds.size=\(view.bounds.size)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVcl("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        logVcl("viewWillTransition(to: \(size), with: coordinator)")
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.logVcl("begin animate(alongSideTransition:completition:)")
        }, completion: { (context) -> Void in
            self.logVcl("end animate(alongsideTransition:completition:)")
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
