var express = require('express');
var UserService=require('../services/UserService');
var UserInfoPo=require('../po/UserInfoPo');
var router = express.Router();

/* GET users listing. */
router.get('/select', function(req, res, next) {
    UserService.findAllUserInfo(function(data){
        res.send(data);
    });
});
/**
 * 新增用户
 */
router.get('/add', function(req, res, next) {
    var userInfoPo=new UserInfoPo();
    userInfoPo.account=req.query.account;
    userInfoPo.name=req.query.name;
    userInfoPo.instituteNumber=req.query.instituteNumber;
    UserService.addUserInfo(userInfoPo,function(result){
        res.send(req.query);
    });
});
/**
 * 更新用户
 */
router.get('/update', function(req, res, next) {
    UserService.findAllUserInfo(function(data){
        res.send(data);
    });
});
/**
 * 删除用户
 */
router.get('/delete', function(req, res, next) {
    UserService.findAllUserInfo(function(data){
        res.send(data);
    });
});



module.exports = router;
