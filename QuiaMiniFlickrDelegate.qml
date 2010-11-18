import Qt 4.7

Rectangle {
    id: mainFilmStrip
    width:  125
    height: 134
    color: "darkgrey"

    property string imageSource

    Rectangle {
        id: rectangle1
        width: 120
        height: 100
        radius: 9
        anchors.centerIn: parent
        border.width: 1
        border.color: "#c0bfbf"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#5e5959"
            }

            GradientStop {
                position: 0.5
                color: "#b7b6b6"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }

        Image {
            id: thumbImage

            x: 13
            y: 12
            width: 98
            height: 80
            anchors.centerIn: parent
            smooth: true
            source: imageSource
            onProgressChanged:
                {
                loadingImage.opacity = 1-thumbImage.progress;
            }
        }

        Image {
            id: thumbImageGloss
            x: 13
            y: 12
            width: 94
            height: 77
            z: 2
            opacity: 0.83
            source: "images/gloss.png"
            smooth: true
        }

        Image {
            id: loadingImage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            z: 2
            opacity: 1
            source: "images/loading.png"
            smooth: true
        }
    }

    Rectangle {
        id: rectangle2
        x: 3
        y: 3
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle3
        x: 20
        y: 3
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle4
        x: 37
        y: 3
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle5
        x: 54
        y: 3
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle6
        x: 71
        y: 3
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle7
        x: 88
        y: 3
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle8
        x: 105
        y: 3
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle9
        x: 3
        y: 121
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle10
        x: 20
        y: 121
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle11
        x: 37
        y: 121
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle12
        x: 54
        y: 121
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle13
        x: 71
        y: 121
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle14
        x: 88
        y: 121
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }

    Rectangle {
        id: rectangle15
        x: 105
        y: 121
        width: 10
        height: 10
        color: "#363434"
        radius: 3
    }
}


