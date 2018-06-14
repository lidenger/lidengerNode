var express = require('express');
var router = express.Router();
var LoginPo = require('../po/LoginPo');

var AuthService=require('../services/AuthService');

/**
 * 登录
 */
router.get('/login', function(req, res, next) {
    var loginPo=new LoginPo(req.query||req.body);
    AuthService.login(loginPo,function(result){
        res.send(result);
    });


});


module.exports = router;












