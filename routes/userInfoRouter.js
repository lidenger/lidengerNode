var express = require('express');
var UserService=require('../services/UserService');
var UserInfoPo=require('../po/UserInfoPo');
var router = express.Router();

/**
 * 查询用户
 */
router.post('/select', function(req, res, next) {
    UserService.findAllUserInfo(function(data){
        res.send(data);
    });
});


/**
 * 新增用户
 */
router.post('/add', function(req, res, next) {
    var userInfoPo=new UserInfoPo(req.body);
    UserService.addUserInfo(userInfoPo,function(result){
        res.send(result);
    });
});

/**
 * 更新用户
 */
router.post('/update', function(req, res, next) {
    var userInfoPo=new UserInfoPo(req.body);
    UserService.updateUserInfo(userInfoPo,function(data){
        res.send(data);
    });
});

/**
 * 删除用户
 */
router.post('/delete', function(req, res, next) {
    var caId=req.body.caId;
    UserService.removeUserInfo(caId,function(data){
        res.send(data);
    });
});



module.exports = router;
