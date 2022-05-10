import Igis
import Scenes
import Foundation

class Paddle: RenderableEntity {
    var rectangle: Rectangle
    let playerImage : Image
    var rect = Rect()

    init(rect:Rect, playerURL: String) {
        rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)
        guard let playerURL = URL(string: playerURL) else {
            fatalError()
        }
        playerImage = Image(sourceURL: playerURL)
        // Using a meaningful name can be helpful for debugging
        super.init(name: "Paddle")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(playerImage)
    }

    override func render(canvas:Canvas) {
        let strokeStyle = StrokeStyle(color:Color(.black))
        let fillStyle = FillStyle(color:Color(.white))
        let lineWidth = LineWidth(width:2)
        canvas.render(strokeStyle, fillStyle, lineWidth, rectangle)

        if playerImage.isReady {
            playerImage.renderMode = .destinationRect(rect)
            canvas.render(playerImage)
        }
    }

    func move(to point:Point) {
        rectangle.rect.topLeft = point
    }

    override func boundingRect() -> Rect {
        return rectangle.rect

    }

    override func calculate(canvasSize:Size) {
        let canvasBoundingRect = Rect(size:canvasSize)

        let paddleBoundingRect = Rect(topLeft:Point(x:rectangle.rect.center.x,y:rectangle.rect.center.y), size:Size(width:rectangle.rect.width,height:rectangle.rect.height))

        let tooFarUp = paddleBoundingRect.topLeft.y < canvasBoundingRect.topLeft.y
        let tooFarDown = paddleBoundingRect.bottomLeft.y > canvasBoundingRect.bottomLeft.y

        rect = Rect(topLeft: rectangle.rect.topLeft, size: Size(width: 100, height: 100))

        //if tooFarUp {
        //self.move(to: Point(x:paddleBoundingRect.topLeft.x,y:paddleBoundingRect.topLeft.y))
        //} else if tooFarDown {
        //self.move(to: Point(x:canvasBoundingRect.topLeft.x,y:canvasBoundingRect.bottomLeft.y))
        //}
    }

}
