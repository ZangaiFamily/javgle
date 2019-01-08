var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next) {
  res.locals.req = req;
  res.render('index', { title: 'home' });
});

router.get('/video', (req, res, next) => {
  res.locals.req = req;
  res.render('video', { title: 'video' });
})

router.get('/video/:vid', (req, res, next) => {
  res.locals.req = req;
  res.render('play', { title: 'video-play', vid: req.params.vid });
})

module.exports = router;
