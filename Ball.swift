import Scenes
import Igis
import Foundation

class Ball: RenderableEntity, MouseMoveHandler {

    let ellipse = Ellipse(center:Point(x:0, y:0), radiusX:30, radiusY:30, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.orange))
    let fillStyle = FillStyle(color:Color(.black))
    let lineWidth = LineWidth(width:5)

    var velocityX : Int
    var velocityY : Int

    var targetVelocityX: Double
    var targetVelocityY: Double

    var targetRadius: Int
    let scoreLeft: Text
    let scoreRight: Text
    var currentScoreLeft = 0
    var currentScoreRight = 0

    var scoreRectLeft = Rect()
    var scoreRectRight = Rect()
    
    func onMouseMove(globalLocation: Point, movement: Point) {
    }
    let soccerBall : Image    
    
    init() {

    guard let soccerBallURL =
            URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Soccerball.svg/750px-Soccerball.svg.png") else {
        fatalError("failed to create URL for soccerBall")
    }
    soccerBall = Image(sourceURL:soccerBallURL)
    


        velocityX = 0
        velocityY = 0

        targetVelocityX = 0
        targetVelocityY = 0

        targetRadius = ellipse.radiusX
        scoreLeft = Text(location:Point(x:100,y:100), text:"")
        scoreLeft.font = "50pt Times New Roman"
        scoreRight = Text(location:Point(x:100,y:100), text:"")
        scoreRight.font = "50pt Times New Roman"
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Ball")
    }

    func changeVelocity(velocityX:Int, velocityY:Int) {
        self.velocityX = velocityX
        self.velocityY = velocityY
    }

    override func calculate(canvasSize:Size) {
        // First, move to the new position
        ellipse.center += Point(x:velocityX, y:velocityY)

        // Form a bounding rectangle around the canvas
        let canvasBoundingRect = Rect(size:canvasSize)

        // Form a bounding rect around the ball (ellipse)
        let ballBoundingRect = Rect(topLeft:Point(x:ellipse.center.x-ellipse.radiusX, y:ellipse.center.y-ellipse.radiusY),
                                    size:Size(width:ellipse.radiusX*2, height:ellipse.radiusY*2))

        // Determine if we've moved outside of the canvas boundary rect
        let tooFarLeft = ballBoundingRect.topLeft.x < canvasBoundingRect.topLeft.x
        let tooFarRight = ballBoundingRect.topLeft.x + ballBoundingRect.size.width > canvasBoundingRect.topLeft.x + canvasBoundingRect.size.width

        let tooFarUp = ballBoundingRect.topLeft.y < canvasBoundingRect.topLeft.y /***** THIS IS AN EXERCISE LEFT TO THE READER *****/
        let tooFarDown = ballBoundingRect.topLeft.y + ballBoundingRect.size.height > canvasBoundingRect.topLeft.y + canvasBoundingRect.size.height /***** THIS IS AN EXERCISE LEFT TO THE REvADER *****/

        scoreLeft.text = "\(currentScoreLeft)"
        scoreRight.text = "\(currentScoreRight)"
        scoreRight.location.x = canvasSize.width - 100

        // If we're too far to the left or right, we bounce the x velocity
        if tooFarLeft || tooFarRight {
            velocityX = -velocityX*3
            ellipse.radiusX /= 2

            if tooFarLeft {
                currentScoreRight += 1
                ellipse.center = canvasSize.center
            } else if tooFarRight {
                currentScoreLeft += 1
                ellipse.center = canvasSize.center
            }
        }

        if velocityX < -10 {
            velocityX += 1
        } else if velocityX > 10 {
            velocityX -= 1
        }

        if ellipse.radiusX < 30 {
            ellipse.radiusX += 1
        }

        // If we're too far to the top or bottom, we bound the y velocity
        if tooFarUp || tooFarDown {
            velocityY = -velocityY*3
            ellipse.radiusY /= 2
        }

        if velocityY < -10 {
            velocityY += 1
        } else if velocityY > 10 {
            velocityY -= 1
        }

        if ellipse.radiusY < 30 {
            ellipse.radiusY += 1
        }

        /***** THIS IS AN EXERCISE LEFT TO THE READER *****/
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        // Position the ellipse at the center of the canvas
        ellipse.center = canvasSize.center
        dispatcher.registerMouseMoveHandler(handler:self)
        canvas.setup(soccerBall)
        scoreRectLeft = Rect(topLeft: Point 
    }

    override func render(canvas:Canvas) {
        canvas.render(strokeStyle, fillStyle, lineWidth, ellipse)
        canvas.render(scoreLeft)
        canvas.render(scoreRight)
        print(soccerBall.isReady)
        if soccerBall.isReady{soccerBall.renderMode = .destinationRect(Rect(topLeft: ellipse.center - Point(x: ellipse.radiusX*2, y: ellipse.radiusY*2), size: Size(width: 100, height:100)))
                                   canvas.render(soccerBall)
        }
    }

    override func teardown() {
        dispatcher.unregisterMouseMoveHandler(handler:self)
    }
    
    override func boundingRect() -> Rect {
        let topLeft = ellipse.center - Point(x: ellipse.radiusX, y: ellipse.radiusY)
        let size = Size(width:2*ellipse.radiusX, height: 2*ellipse.radiusY)
        return Rect(topLeft: topLeft, size: size)
    }
}
