import Qt 4.7

Rectangle {
    id: mainView
    width: 800
    height: 480
    color: "#979595"

    property string heiaRssFeed
    property string currentIcon
    property string currentTitle
    property string currentDescription

    state: "noImages"

    Rectangle {
        id: rectangleEntryList
        x: 0
        y: 0
        width: 284
        height: 424
        color: "#949595"


    }

    Rectangle {
        id: rectangleLogoutButton
        x: 0
        y: 422
        width: 284
        height: 58
        color: "#949595"
        z: 4
        Button { id: logoutButton; text: "Logout"
            width: parent.width -20
            height: parent.height -10
            anchors.fill: parent
            onClicked: { flipable.flipped = !flipable.flipped; }
            z: 6
        }
    }

    Rectangle {
        id: rectangleEntryDetailed
        x: 284
        y: 0
        width: 516
        height: 346
        color: "#949595"

        QuiaEntryDetailed {
            id: detailedView
            title: xmlModelHeia.get(entryList.currentIndex).heiaTitle
            description: xmlModelHeia.get(entryList.currentIndex).heiaDescription
            icon:  mapSportIcon(title)

        }
    }

    Rectangle {
        id: rectangleFlickrMini
        x: 284
        y: 346
        width: 516
        height: 134
        color: "#949595"

        QuiaMiniFlickr {
            id: miniFlickrList
            width: parent.width
            height: parent.height
            //entryDescription: xmlModelHeia.get(entryList.currentIndex).heiaDescription
        }

        /*MouseArea {
            anchors.fill: parent
            onClicked: { mainView.state = "photoView"; }

        }*/

    }

    Rectangle {
        id: flickrBigView
        x: 800
        y: 480

        color: "darkgrey"


        /*QuiaFlickrBigView {
            id: mainFlickrView
            width: parent.width
            height: parent.height
        }*/
    }

    ListView {
        id: entryList
        width: 284
        height: 424
        z: 2
        anchors.left: rectangleEntryList.right
        anchors.leftMargin: -284
        anchors.top: rectangleEntryList.bottom
        anchors.topMargin: -424

        model: xmlModelHeia
        delegate: QuiaEntryDelegate {
            entryTitle: heiaTitle
            entryDate: heiaDate


            iconSource: mapSportIcon(heiaTitle)


            MouseArea {
                anchors.fill: parent
                onClicked: {
                    entryList.currentIndex = index
                    entryList.currentItem
                    parseFlickr(xmlModelHeia.get(entryList.currentIndex).heiaDescription)
                }
            }
        }

        highlight: Rectangle {
            color: "#210bad"
            radius: 7
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#ffd500";
                }
                GradientStop {
                    position: 1.00;
                    color: "#ffffff";
                }
            }

            opacity: 0.4
            z:2
        }
        highlightMoveSpeed: 300


    }

    //Here we parse the title and map it to the
    //correct sport icon
    //..or set a default one if no match
    function mapSportIcon(title) {
        var sportName=title.slice(0, title.indexOf(" "));
        if(sportName=="Ashtanga") {
            return "sports_icons/ashtanga.png";
        }
        else if(sportName=="Walking") {
            return "sports_icons/walking.png";
        }
        else if(sportName=="Skydiving") {
            return "sports_icons/skydiving.png";
        }
        else if(sportName=="Meditation") {
            return "sports_icons/ashtanga.png"
        }

        else {
            return "sports_icons/sport1.png";
        }
    }

    ScrollBar {
        scrollArea: entryList; height: entryList.height; width: 8
        anchors.right: entryList.right
        z:6
    }


    XmlListModel {
        id: xmlModelHeia
        //source: "http://www.heiaheia.com/users/33370921/feed.xml"
        source:  "http://www.heiaheia.com/users/"+heiaRssFeed+"/feed.xml"
        query: "/rss/channel/item"

        XmlRole { name: "heiaTitle"; query:  "title/string()" }
        XmlRole { name: "heiaDescription"; query:  "description/string()" }
        XmlRole { name: "heiaAuthor"; query:  "author/string()" }
        XmlRole { name: "heiaDate"; query:  "pubDate/string()" }
        XmlRole { name: "heiaLink"; query:  "link/string()" }

        onStatusChanged: {
            if(xmlModelHeia.status == XmlListModel.Ready) {
                parseFlickr(xmlModelHeia.get(entryList.currentIndex).heiaDescription);
            }
        }
    }

    function parseFlickr(description) {
        if(description.indexOf("flickr")!=-1)
            {
            //we got potential flickr url

            // now let's parse it
            var flickrUsername = description.slice(description.indexOf("/photos/")+8, description.indexOf("/sets/"));
            //assuming that Flickr set ID is always 17 characters long (so far it is so)
            var flickrSetId = description.slice(description.indexOf("/sets/")+6, description.indexOf("/sets/")+23);
            miniFlickrList.setId = flickrSetId;
            //mainFlickrView.setId = flickrSetId;

            //text1.text = flickrSetId;
            //mainView.flickrSetId = flickrSetId;
            flickrApiModel.source = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=c8ade722748871f7792dd7c8b765fda9&photoset_id=" + flickrSetId;
            flickrApiModel.query= "/rsp/photoset";
            flickrApiModel.reload();
            mainView.state = "";



        }
        else {
             mainView.state = "noImages"
        }
    }

    XmlListModel {
        id: flickrApiModel
        XmlRole { name: "owner"; query:  "@owner/string()" }

        onStatusChanged: {
            if (flickrApiModel.status == XmlListModel.Ready) {
                //outputTextOwner.text = flickrApiModel.get(0).owner;
                //var ownerId=flickrApiModel.get(0).owner;
                //var setId=outputText.text;
                //flickrRssModel.reload();
                miniFlickrList.ownerId = flickrApiModel.get(0).owner;
                miniFlickrList.reloadFlickrModel();

                /*mainFlickrView.ownerId = flickrApiModel.get(0).owner;
                mainFlickrView.reloadFlickrModel();*/
                //QuiaMiniFlickr.setId =
            }
            else if( flickrApiModel.status == XmlListModel.Error){
                //outputTextOwner.text = flickrApiModel.errorString();
            }
            else if( flickrApiModel.status == XmlListModel.Loading){
                //outputTextOwner.text = "Loading";
            }
        }

    }
    states: [
        State {
            name: "noImages"

            PropertyChanges {
                target: rectangleFlickrMini
                y: 470
            }

            PropertyChanges {
                target: rectangleEntryDetailed
                height: 470
            }

            PropertyChanges {
                target: detailedView
                height: 470
            }
        },
        State {
            name: "photoView"

            PropertyChanges {
                target: rectangleLogoutButton
                x: -284
                y: 422
            }

            PropertyChanges {
                target: rectangleEntryDetailed
                x: -92
                y: -388
            }

            PropertyChanges {
                target: rectangleFlickrMini
                x: 0
                y: 0
            }

            PropertyChanges {
                target: entryList
                x: -306
                y: -282
                anchors.topMargin: -706
                anchors.leftMargin: -590
            }

            PropertyChanges {
                target: rectangleEntryList
                x: -298
                y: -282
            }

            PropertyChanges {
                target: flickrBigView
                x: 0
                y: 0
            }
        }
    ]

    transitions:  [
        Transition {
            from: ""; to: "noImages"
            NumberAnimation {
                properties:  "y, height"
                easing.type: Easing.OutBounce
                duration: 1000

            }
            reversible: true
        },
        Transition {
            from: ""; to: "photoView"
            NumberAnimation {
                properties: "x, y"
                easing.type: Easing.InOutQuad
                duration:  800
            }
            reversible: true
        }

    ]

function changeStateToPhotoView() {
        mainView.state = "photoView"
    }

function changeStateToBasicView() {
        mainView.state=""
    }

}
