var express = require('express');
var router = express.Router();

router.use( (req, res, next) => {
  res.locals.req = req;
  next();
})

router.get('/', (req, res, next) => {
  res.render('index', { title: 'home' });
});

router.get('/video', (req, res, next) => {
  res.render('video', { title: 'video' });
})

router.get('/video/:vid', (req, res, next) => {
  res.render('play', { title: 'video-play', vid: req.params.vid });
})

module.exports = router;
