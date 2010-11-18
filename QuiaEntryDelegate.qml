import Qt 4.7

Rectangle {
    id: rectangle1
    width: 284
    height: 106
    radius: 7
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#d5d2d2"
        }

        GradientStop {
            position: 0.99
            color: "#7e7b7b"
        }
    }
    border.color: "#7c7a7a"

    property string entryTitle
    //property string entryDescription
    property string entryDate
    property color backColor
    property string iconSource

    Image {
        id: sportLogo
        x: 14
        y: 12
        //source: "sports_icons/sport1.png"
        height: 44
        anchors.verticalCenterOffset: -19
        anchors.verticalCenter: parent.verticalCenter
        z: 3
        width: 43
        source: iconSource

            //mapSportIcon(entryTitle)




    }

    Text {
        id: textEntryTitle
        x: 72
        y: 12
        width: 200
        height: 40
        text: entryTitle
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        style: Text.Normal
        font.bold: false
        font.pointSize: 12
        z: 3
    }

    Text {
        id: textEntryDate
        x: 72
        y: 63
        width: 200
        height: 40
        color: "#07314b"
        text: "Date: " + entryDate
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        z: 3
        font.strikeout: false
        font.bold: false
        styleColor: "#b8e4f1"
        style: Text.Normal
        font.pointSize: 10
        font.family: "Tahoma"
    }

    Image {
        id: imageStripes
        x: 0
        y: 0
        width: 284
        height: 106
        clip: false
        opacity: 0.11
        smooth: false
        fillMode: Image.Tile
        source: "images/stripes.png"
    }

    Image {
        id: imageGloss
        opacity: 0.37
        anchors.fill: parent
        smooth: false
        z: 2
        source: "images/gloss.png"
    }


}
