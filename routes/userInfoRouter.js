var express = require('express');
var UserService=require('../services/UserService');
var UserInfoPo=require('../po/UserInfoPo');
var router = express.Router();

/**
 * 查询用户
 */
router.get('/select', function(req, res, next) {
    UserService.findAllUserInfo(function(data){
        res.send(data);
    });
});

/**
 * 新增用户
 */
router.get('/add', function(req, res, next) {
    var userInfoPo=new UserInfoPo(req.query||req.body);
    UserService.addUserInfo(userInfoPo,function(result){
        res.send(result);
    });
});

/**
 * 更新用户
 */
router.get('/update', function(req, res, next) {
    var userInfoPo=new UserInfoPo(req.query||req.body);
    UserService.updateUserInfo(userInfoPo,function(data){
        res.send(data);
    });
});

/**
 * 删除用户
 */
router.get('/delete', function(req, res, next) {
    var caId=req.query.caId;
    UserService.removeUserInfo(caId,function(data){
        res.send(data);
    });
});



module.exports = router;
