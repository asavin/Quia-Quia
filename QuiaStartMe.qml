import Qt 4.7

Rectangle {
    width: 800
    height: 480
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#000000"
        }

        GradientStop {
            position: 0.45
            color: "#807c7c"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    Flipable {
        id: flipable
        x: 0
        y: 0

        property bool flipped: false

        width: parent.width
        height: parent.height

        front: QuiaLoginScreen { id: loginScreen }
        back: QuiaMainView { id: mainView }

         transform: Rotation {
             id: rotation
             origin.x: flipable.width/2
             origin.y: flipable.height/2
             axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
             angle: 0    // the default angle
         }

         states: State {
             name: "back"
             PropertyChanges { target: rotation; angle: 180 }
             when: flipable.flipped
         }

         transitions: Transition {
             NumberAnimation { target: rotation; property: "angle"; duration: 1000 }
         }

         /*MouseArea {
             anchors.fill: parent
             onClicked: flipable.flipped = !flipable.flipped
         }*/
    }


}
