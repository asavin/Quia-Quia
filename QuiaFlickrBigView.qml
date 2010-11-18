import Qt 4.7

Rectangle {
    id: flickrBigView
    width: 800
    height: 480
    color:  "darkgrey"
    property string ownerId
    property string setId

    RssModel {
        id: flickrRssModel
        ownerId:  ownerId
        setId: setId
    }

    GridView {
        id: gridPhotoView
        width:  800
        height: 480
        model:  flickrRssModel
        cellWidth: 300
        cellHeight: 200


        delegate: GridDelegate {
            id: gridDelegate
        }


            /*Rectangle {
            width:  parent.cellWidth
            height: parent.cellHeight
            color: "darkgrey"
            radius: 7

            Image {
                width:  parent.width-10
                height: parent.height-10
                source: {
                    return content.slice(content.indexOf(".static.flickr.com")-12, content.indexOf("_m.jpg")+6);
                }
            }
        }

            /*QuiaPhotoItem {
            thumbUrl: {
                return content.slice(content.indexOf(".static.flickr.com")-12, content.indexOf("_m.jpg")+6);
            }
            bigUrl: hq
            imageWidth:  200
            imageHeight:  180
        }*/

    }


  function reloadFlickrModel() {
        flickrRssModel.setId = setId;
        flickrRssModel.ownerId = ownerId;
        flickrRssModel.source = "http://api.flickr.com/services/feeds/photoset.gne?set="+setId+"&nsid="+ownerId;
        flickrRssModel.reload();
    }

}
