var express = require('express');
var router = express.Router();
var db = require('../connection').db;


router.get('/', function(req, res, next) {
    res.render('tml');
});


router.get('/tmdata', function(req, res) {
    console.log("in tm data");
    db.open(function(err, db1) {
        db1.collection('liang', function(err, du2) {
            du2.find({}, {
                _id: 0
            }).toArray(function(err, data) {
                res.json(data);
                db1.close();
            })
        });
    });
});



router.post('/ls', function(req, res, next) {

    var path = req.body.ls + ":";
    var collection = req.body.mc + "_lRp";

    db.open(function(err, db1) {
        db1.collection(collection, function(err, du2) {
            du2.find({
                "path": path
            }, {
                "sort": [
                    ['size', 'desc']
                ]
            }).limit(32).toArray(function(err, data) {
                console.log(data);
                res.json(data);
                db1.close();
            })
        });
    });


});


router.post('/tmdata_update', function(req, res, next) {

    console.log(req.body.item);

    var o = req.body.item;

    db.open(function(err, db1) {
        db1.collection(o, function(err, du2) {
            du2.find({}, {
                _id: 0
            }).toArray(function(err, data) {
                console.log(data);
                res.json(data);
                db1.close();
            })
        });
    });



});

module.exports = router;