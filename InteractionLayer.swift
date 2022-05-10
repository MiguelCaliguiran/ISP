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
   static let paddleRight = Paddle(rect:Rect(size:Size(width:10, height:100)), playerURL: "https://www.pikpng.com/pngl/m/68-689456_cristiano-ronaldo-clipart-ronaldo-png-cristiano-ronaldo-no.png")

   init() {
       self.player = InteractionLayer.players
       InteractionLayer.players += 1
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: InteractionLayer.ball, at: .front)
        InteractionLayer.ball.changeVelocity(velocityX: 10, velocityY: 20)

        insert(entity: InteractionLayer.paddleLeft, at: .front)
        insert(entity: InteractionLayer.paddleRight, at: .front)
    }

    override func preSetup(canvasSize: Size, canvas: Canvas) {
        let canvasBoundingRect = Rect(size:canvasSize)
        InteractionLayer.paddleLeft.move(to:Point(x: 25, y: canvasSize.center.y))
        InteractionLayer.paddleRight.move(to:Point(x: (canvasBoundingRect.size.width - 35), y: canvasSize.center.y))

        dispatcher.registerKeyDownHandler(handler: self)
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        print(key)

        let height = 800
        //if player == 0 {
            if key == "w" && InteractionLayer.paddleLeft.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleLeft.rectangle.rect.topLeft.y -= 10
            } else if key == "s" && InteractionLayer.paddleLeft.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleLeft.rectangle.rect.topLeft.y += 10
                print("\(InteractionLayer.paddleLeft.rectangle.rect.topLeft.y)")
            }
        //} else if player == 1 {
            if key == "o" && InteractionLayer.paddleRight.rectangle.rect.topLeft.y >= 0{
                InteractionLayer.paddleRight.rectangle.rect.topLeft.y -= 10
            } else if key == "l" && InteractionLayer.paddleRight.rectangle.rect.topLeft.y <= height{
                InteractionLayer.paddleRight.rectangle.rect.topLeft.y += 10
                print("\(InteractionLayer.paddleRight.rectangle.rect.topLeft.y)")
            }
        //}

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
            InteractionLayer.ball.velocityX = -InteractionLayer.ball.velocityX
        }
        let rightPaddleBoundingRect = InteractionLayer.paddleRight.boundingRect()
        let rightPaddleContainment = rightPaddleBoundingRect.containment(target: ballBoundingRect)
        let rightPaddleTargetContainmentSet : ContainmentSet = [.overlapsRight, .contact]
        if rightPaddleTargetContainmentSet.isSubset(of: rightPaddleContainment) {
            InteractionLayer.ball.velocityX = -InteractionLayer.ball.velocityX
        }
    }
}

