import Qt 4.7

Rectangle {
    id: loginScreen
    width: 800
    height: 480

    property bool readyToFlip

    Image {
        id: backgroundImage
        x: 0
        y: 0
        width: 800
        height: 480
        anchors.fill: parent
        source: "images/quia-quia-intro-screen.jpg"

        Rectangle {
            id: rectangle1
            x: 490
            y: 182
            width: 250
            height: 44
            color: "#ffffff"
            radius: 12
            z: 2


            TextInput {
                id: textEditUsername
                x: 18
                y: 9
                width: 223
                height: 26
                text: "username"
                font.pointSize: 15
                horizontalAlignment: TextEdit.AlignHCenter
                onFocusChanged: {
                    if( textEditUsername.focus==true) {
                        textEditUsername.text="";
                    }
                }
                KeyNavigation.tab: textEditPassword

            }
        }

        Rectangle {
            id: rectanglePassword
            x: 490
            y: 256
            width: 250
            height: 44
            color: "#ffffff"
            radius: 12
            TextInput {
                id: textEditPassword
                x: 18
                y: 9
                width: 223
                height: 26
                text: "password"
                echoMode: TextInput.Password
                font.pointSize: 15
                horizontalAlignment: TextInput.AlignHCenter
                onFocusChanged: {
                    if( textEditPassword.focus==true) {
                        textEditPassword.text="";
                    }
                }
            }
            z: 2
        }

        Rectangle {
            id: rectangleRss
            x: 245
            y: 336
            width: 495
            height: 44
            color: "#ffffff"
            radius: 12
            TextInput {
                id: textEditRss
                x: 15
                y: 9
                width: 466
                height: 26
                text: "33370921"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 15
                horizontalAlignment: TextInput.AlignHCenter
                /*onFocusChanged: {
                    if( textEditRss.focus==true) {
                        textEditRss.text="";
                    }
                }*/
                onAccepted: { flipable.flipped = !flipable.flipped;
                              mainView.heiaRssFeed = textEditRss.text;}
            }
            z: 2

        }
    }
}
