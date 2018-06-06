var UserDao=require('../dao/UserDao');
var UserService=function(){};

UserService.test=function(){
    return UserDao.test()+"UserService test>>";
};

/**
 * 查询所有用户信息
 * @param resultCallback 结果回调函数
 */
UserService.findAllUserInfo=function(resultCallback){
    UserDao.findAllUserInfo(function(result){
        resultCallback(result);
    });
};

/**
 * 新增用户信息
 * @param UserInfoPo
 */
UserService.addUserInfo=function(userInfoPo,resultCallback){
    UserDao.insertUserInfo(userInfoPo,function(result){
        resultCallback(result);
    })
};

module.exports = UserService;














