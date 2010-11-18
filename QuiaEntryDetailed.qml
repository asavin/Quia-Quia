import Qt 4.7

Rectangle {
    id: entryDetailed
    width: 516
    height: 346
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#090808"
        }

        GradientStop {
            position: 0.32
            color: "#6b6969"
        }

        GradientStop {
            position: 0.5
            color: "#625f5f"
        }

        GradientStop {
            position: 1
            color: "#0d0c0c"
        }
    }

    property string icon
    property string title
    property string description

    Image {
        id: imageSportBigIcon
        x: 28
        y: 26
        width: 218
        height: 218
        opacity: 0.24
        smooth: true
        source: icon

        SequentialAnimation on scale {
            loops: Animation.Infinite
            NumberAnimation {
                from: 0.7
                to: 1.1
                easing.type: Easing.InOutBounce
                duration: 3000
            }
            PauseAnimation { duration: 2000 }

        }
    }

    Text {
        id: textDetailedTitle
        x: 132
        y: 40
        width: 300
        height: 40
        color: "#fdfdfd"
        text: title
        style: Text.Raised
        font.family: "Tahoma"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        styleColor: "#b3aeae"
        font.bold: false
        font.pointSize: 19
        z: 2
    }

    Text {
        id: textDescriptionTitle
        x: 132
        y: 129
        width: 80
        height: 20
        color: "#ffffff"
        text: "Personal notes:"
        font.pointSize: 13
    }

    Flickable {
         id: flick

         width: 300; height: 150;
         x: 132
         y: 164
         contentWidth: edit.paintedWidth
         contentHeight: edit.paintedHeight
         clip: true
         flickableDirection: Flickable.VerticalFlick

         function ensureVisible(r)
         {
             if (contentX >= r.x)
                 contentX = r.x;
             else if (contentX+width <= r.x+r.width)
                 contentX = r.x+r.width-width;
             if (contentY >= r.y)
                 contentY = r.y;
             else if (contentY+height <= r.y+r.height)
                 contentY = r.y+r.height-height;
         }

         TextEdit {
             id: edit
             width: flick.width
             height: flick.height
             focus: true
             wrapMode: TextEdit.Wrap
             onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
             text: { if(description!="") return description;
                 return "There was really nothing to say." }
             font.pointSize: 10
             color:  "#ffffff"
             smooth:  true
             readOnly: true
         }
     }


}

