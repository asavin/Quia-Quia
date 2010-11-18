import Qt 4.7

Rectangle {
    id: photoItem

    property string thumbUrl
    property string bigUrl
    property int imageWidth
    property int imageHeight

    width: imageWidth
    height: imageHeight

    /*{
        //return Math.floor((100-50)*Math.random()) + 51;
        return 200;
    }*/

    height:  170
    color:  "lightgrey"

    Image {
        id: currentImage
        width:  parent.width-10
        height: parent.height-10
        source:  thumbUrl
        onProgressChanged:
            {
            loadingImage.opacity = 1-currentImage.progress;
        }
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

    states: [
        State {
            name:  "bigImage"
            PropertyChanges {
                target: currentImage
                source: bigUrl
            }
        }
    ]



}
