import Igis
import Scenes

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */
class InteractionLayer : Layer, KeyDownHandler {

    static var players = 0
    let player : Int
   static let ball = Ball()
   static let paddleLeft = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/5/Lionel-Messi.png")
   static let paddleRight = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/4/Cristiano-Ronaldo-Transparent.png")
   static let paddleLeft2 = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/5/Lionel-Messi.png")
   static let paddleRight2 = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/4/Cristiano-Ronaldo-Transparent.png")
   static let paddleLeft3 = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/5/Lionel-Messi.png")
   static let paddleRight3 = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/4/Cristiano-Ronaldo-Transparent.png")
   static let paddleLeft4 = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/5/Lionel-Messi.png")
   static let paddleRight4 = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pngall.com/wp-content/uploads/4/Cristiano-Ronaldo-Transparent.png")
   
   init() {
       self.player = InteractionLayer.players
       InteractionLayer.players += 1
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: InteractionLayer.ball, at: .front)
        InteractionLayer.ball.changeVelocity(velocityX: 20, velocityY: 20)

        insert(entity: InteractionLayer.paddleLeft, at: .front)
        insert(entity: InteractionLayer.paddleRight, at: .front)
        insert(entity: InteractionLayer.paddleLeft2, at: .front)
        insert(entity: InteractionLayer.paddleRight2, at: .front)
        insert(entity: InteractionLayer.paddleLeft3, at: .front)
        insert(entity: InteractionLayer.paddleRight3, at: .front)
        insert(entity: InteractionLayer.paddleLeft4, at: .front)
        insert(entity: InteractionLayer.paddleRight4, at: .front)
   }

    override func preSetup(canvasSize: Size, canvas: Canvas) {
        let canvasBoundingRect = Rect(size:canvasSize)
        InteractionLayer.paddleLeft.move(to:Point(x: 40, y: canvasSize.center.y))
        InteractionLayer.paddleRight.move(to:Point(x: (canvasBoundingRect.size.width - 120), y: canvasSize.center.y))
        InteractionLayer.paddleLeft2.move(to:Point(x: 200, y: canvasSize.center.y))
        InteractionLayer.paddleRight2.move(to:Point(x: (canvasBoundingRect.size.width - 300), y: canvasSize.center.y))
        InteractionLayer.paddleLeft3.move(to:Point(x: 400, y: canvasSize.center.y))    
        InteractionLayer.paddleRight3.move(to:Point(x: (canvasBoundingRect.size.width - 450), y: canvasSize.center.y))
        InteractionLayer.paddleLeft4.move(to:Point(x: 600, y: canvasSize.center.y))
        InteractionLayer.paddleRight4.move(to:Point(x: (canvasBoundingRect.size.width - 700), y: canvasSize.center.y))
        dispatcher.registerKeyDownHandler(handler: self)
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        print(key)

        let height = 800
        //if player == 0 {
            if key == "q" && InteractionLayer.paddleLeft.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleLeft.rectangle.rect.topLeft.y -= 20
            } else if key == "a" && InteractionLayer.paddleLeft.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleLeft.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleLeft.rectangle.rect.topLeft.y)")
            }
        //} else if player == 1 {
            if key == "o" && InteractionLayer.paddleRight.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleRight.rectangle.rect.topLeft.y -= 20
            } else if key == "l" && InteractionLayer.paddleRight.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleRight.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleRight.rectangle.rect.topLeft.y)")
            }
        //}
            if key == "w" && InteractionLayer.paddleLeft2.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleLeft2.rectangle.rect.topLeft.y -= 20
            } else if key == "s" && InteractionLayer.paddleLeft2.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleLeft2.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleLeft2.rectangle.rect.topLeft.y)")
            }

            if key == "i" && InteractionLayer.paddleRight2.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleRight2.rectangle.rect.topLeft.y -= 20
            } else if key == "k" && InteractionLayer.paddleRight2.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleRight2.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleRight2.rectangle.rect.topLeft.y)")
            }
            if key == "e" && InteractionLayer.paddleLeft3.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleLeft3.rectangle.rect.topLeft.y -= 20
            } else if key == "d" && InteractionLayer.paddleLeft3.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleLeft3.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleLeft3.rectangle.rect.topLeft.y)")
            }
            if key == "u" && InteractionLayer.paddleRight3.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleRight3.rectangle.rect.topLeft.y -= 20
            } else if key == "j" && InteractionLayer.paddleRight3.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleRight3.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleRight3.rectangle.rect.topLeft.y)")
            }
            if key == "r" && InteractionLayer.paddleLeft4.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleLeft4.rectangle.rect.topLeft.y -= 20
            } else if key == "f" && InteractionLayer.paddleLeft4.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleLeft4.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleLeft4.rectangle.rect.topLeft.y)")
            }
            if key == "y" && InteractionLayer.paddleRight4.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleRight4.rectangle.rect.topLeft.y -= 20
            } else if key == "h" && InteractionLayer.paddleRight4.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleRight4.rectangle.rect.topLeft.y += 20
                print("\(InteractionLayer.paddleRight4.rectangle.rect.topLeft.y)")
            }
            

            }
            

    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }

    override func preCalculate(canvas:Canvas) {
        let ballBoundingRect = InteractionLayer.ball.boundingRect()
        let leftPaddleBoundingRect = InteractionLayer.paddleLeft.boundingRect()
        let leftPaddleContainment = leftPaddleBoundingRect.containment(target: ballBoundingRect)
        let leftPaddleTargetContainmentSet : ContainmentSet = [.overlapsRight, .contact]
        if leftPaddleTargetContainmentSet.isSubset(of: leftPaddleContainment) {
            print("LEFT PADDLE IMPACTED")
            InteractionLayer.ball.velocityX = -InteractionLayer.ball.velocityX
        }
        let rightPaddleBoundingRect = InteractionLayer.paddleRight.boundingRect()
        let rightPaddleContainment = rightPaddleBoundingRect.containment(target: ballBoundingRect)
        let rightPaddleTargetContainmentSet : ContainmentSet = [.overlapsRight, .contact]
        if rightPaddleTargetContainmentSet.isSubset(of: rightPaddleContainment) {
            print("RighT PADDLE IMPACTED")
            InteractionLayer.ball.velocityX = -InteractionLayer.ball.velocityX
        }
        let ballBoundingRect2 = InteractionLayer.ball.boundingRect()
        let left2PaddleBoundingRect = InteractionLayer.paddleLeft2.boundingRect()
        let left2PaddleContainment = left2PaddleBoundingRect.containment(target: ballBoundingRect)
        let left2PaddleTargetContainmentSet : ContainmentSet = [.overlapsRight, .contact]
        if left2PaddleTargetContainmentSet.isSubset(of: left2PaddleContainment) {
            print("LEFT PADDLE 2 IMPACTED")
            InteractionLayer.ball.velocityX = -InteractionLayer.ball.velocityX
        }

        
    }
}

