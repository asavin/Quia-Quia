import Qt 4.7

Rectangle {
    width: 516
    height: 134
    color: "#a2a0a0"

    property string flickrUrl
    property string ownerId
    property string setId

    ListView {
        id: imageListView
        /*width: 516
        height: 134*/
        anchors.fill: parent
        z: 2
        orientation: ListView.Horizontal
        model: flickrRssModel//flickrRssModel
        delegate: QuiaMiniFlickrDelegate {
            imageSource: {
                //now we have to parse html content
                //to find link to the thumbnail
                //and not to the original sized HUGE image
                return content.slice(content.indexOf(".static.flickr.com")-12, content.indexOf("_m.jpg")+6);
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    imageListView.currentIndex = index;
                    changeStateToPhotoView();
                    bigImageRectangle.opacity = 1;
                    bigImage.opacity = 1;
                    loadingIndicator.opacity=1;
                    loadingIndicatorDark.opacity=1;
                    loadingIndicatorDark.width=0;

                    bigImage.source = flickrRssModel.get(imageListView.currentIndex).hq;
                    //testText.text = bigImage.source

                    var content = flickrRssModel.get(imageListView.currentIndex).content;
                    biggerThumb.source = content.slice(content.indexOf(".static.flickr.com")-12, content.indexOf("_m.jpg")+6);
                    biggerThumb.visible = true;
                    biggerThumb.scale = 0.6;
                }
        }


        }

        Image {
            id: filmStripOverlay
            anchors.fill: parent
            source: "images/filmstrip_overlay.png"
        }



            /*Image {
                width:  140
                height: 120

                source: {
                    //now we have to parse html content
                    //to find link to the thumbnail
                    //and not to the original sized HUGE image
                    return content.slice(content.indexOf(".static.flickr.com")-12, content.indexOf("_m.jpg")+6);

                }


            }*/
    }


    RssModel {
        id: flickrRssModel
        ownerId: ownerId
        setId: setId
        onStatusChanged: {
            if(flickrRssModel.status == XmlListModel.Loading) {
                //text1.text = "loading";
                loadingImage.visible = true;
                //loadingImage.opacity = 1-flickrRssModel.progress;
            }
            else if(flickrRssModel.status == XmlListModel.Ready) {
                //text1.text = "ready";
                loadingImage.visible = false;
                loadingImage.opacity = 1;
            }
            else if(flickrRssModel.status == XmlListModel.Error) {
                //text1.text = flickrRssModel.errorString();
            }
            //else {text1.text = "don't know";}
        }
    }

    Image {
        id: loadingImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 50
        height: 50
        z: 11
        opacity: 1
        source: "images/loading.png"
        smooth: true
        visible: false

        SequentialAnimation on rotation {
                        loops: Animation.Infinite
                        NumberAnimation {
                            from: 0
                            to: 360
                            //easing.type: Easing.InOutBounce
                            duration: 1000
                        }
                        //PauseAnimation { duration: 3000 }

                    }
    }

    Text {
        id: text1
        x: 37
        y: 61
        width: 400
        height: 40
        text: ""
        wrapMode: Text.WrapAnywhere
        z: 3
    }

    function reloadFlickrModel() {
        flickrRssModel.setId = setId;
        flickrRssModel.ownerId = ownerId;
        flickrRssModel.source = "http://api.flickr.com/services/feeds/photoset.gne?set="+setId+"&nsid="+ownerId;
        flickrRssModel.reload();
    }

    Rectangle {
        id: bigImageRectangle
        width: 800
        height: 480
        anchors.fill: screen
        opacity:  0
        color: "darkgrey"
        z: 10
        property string imageSource: ""

        MouseArea {
            anchors.fill:  parent
            onClicked: { changeStateToBasicView();
                bigImageRectangle.opacity = 0;
                bigImage.opacity=  0;
                bigImage.source="";
                //width 516
                //height: 134
                //flickrRssModel.reload()
                }

        }

        Image {
            id: bigImage
            width:  800
            height:  480
            //anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            //source: parent.imageSource
            onProgressChanged:
                {
                //loadingImage.opacity = 1-bigImage.progress;
                loadingIndicatorDark.width = bigImage.progress*400;
                var mydelta = 0.1 * bigImage.progress;
                biggerThumb.scale = biggerThumb.scale+mydelta;
                if(bigImage.progress==1) {
                    loadingIndicator.opacity=0;
                    loadingIndicatorDark.opacity=0;
                    //biggerThumb.opacity =0;
                    biggerThumb.visible=false;
                    biggerThumb.scale = 0.6;
                }

            }

            z: 25;

        }

        Image {
            id: biggerThumb
            width: 600
            height:  300
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity:  0.4
            z: 14

            /*SequentialAnimation on scale {
                loops: Animation.Infinite
                NumberAnimation {
                    from: 0.7
                    to: 1.2
                    easing.type: Easing.InOutBounce
                    duration: 10000
                }
                PauseAnimation { duration: 3000 }

            }*/
        }

        Rectangle {
            id: loadingIndicator
            width:  410
            height:  100
            radius: 12
            color: "lightgray"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            z: 11
        }

        Rectangle {
            id: loadingIndicatorDark
            width:  0
            height:  90
            radius:  12
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#181717";
                }
                GradientStop {
                    position: 0.52;
                    color: "#455dd5";
                }
                GradientStop {
                    position: 1.00;
                    color: "#1c3bd7";
                }
            }
            color: "#443f3f"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            z: 12
        }

        /*Text {
            id: testText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pointSize: 12
            z: 20
        }*/

    }
}


