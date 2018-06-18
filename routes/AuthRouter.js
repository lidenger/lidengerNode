var express = require('express');
var router = express.Router();
var LoginPo = require('../po/LoginPo');

var AuthService=require('../services/AuthService');

/**
 * 登录
 * 请求方式：post
 */
router.post('/login', function(req, res, next) {
    var loginPo=new LoginPo(req.body);
    AuthService.login(loginPo,function(result){
        res.send(result);
    });
});



module.exports = router;












