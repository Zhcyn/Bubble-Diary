import Foundation
import SpriteKit
class SpringScene: SKScene {
    var bgNode: SKSpriteNode!
    var imagesName = ["Bubble"]
    let nodeSize = CGSize(width: 50, height: 50)
    override func didMove(to view: SKView) {
        self.createSceneContents()
    }
    func createSceneContents() {
        self.backgroundColor = .clear
        self.scaleMode = .aspectFit
        self.makeBubbles()
    }
    @objc func addHeartNode() {
        let node = SKSpriteNode(imageNamed: randomImageName())
        node.color = UIColor.randomColor(from: 200, to: 250)
        node.colorBlendFactor = 1.0
        node.size = self.nodeSize;
        node.position = CGPoint(x: 0.5 * self.frame.width, y: 0)
        node.name = "test"
        let maxY = self.frame.height
        let width = self.size.width
        var xOffset = CGFloat(arc4random_uniform(UInt32(width))) - 0.5*width
        if (xOffset < -0.5*(width-self.nodeSize.width)) {
            xOffset = -0.5*(width-self.nodeSize.width);
        }
        let actions = SKAction.sequence([SKAction.moveBy(x: xOffset, y: maxY + 50, duration: 5)])
        node.run(actions)
        self.addChild(node)
    }
    func randomImageName() -> String {
        return imagesName[Int(arc4random())%imagesName.count];
    }
    func makeBubbles() {
        let action = SKAction.sequence([SKAction.perform(#selector(addHeartNode), onTarget: self),
                                        SKAction.wait(forDuration: 0.3, withRange: 0.2)])
        self.run(SKAction.repeatForever(action), withKey: "test")
    }
    override func didSimulatePhysics() {
        self.enumerateChildNodes(withName: "test") { (node, stop) in
            let maxX = self.frame.width
            if node.position.x >= 0.8 * maxX {
                node.run(SKAction.fadeOut(withDuration: 1))
            }
            if node.position.x > maxX {
                node.removeFromParent()
            }
            let maxY = self.frame.height
            if node.position.y >= 0.6 * maxY {
                node.run(SKAction.fadeOut(withDuration: 1))
            }
            if node.position.y > maxY {
                node.removeFromParent()
            }
        }
    }
}
