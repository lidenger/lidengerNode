var UserDao=require('../dao/UserDao');
var Result=require('../common/ResultPo');
var UserService=function(){};

UserService.test=function(){
    return UserDao.test()+"UserService test>>";
};

/**
 * 查询所有用户信息
 */
UserService.findAllUserInfo=function(resultCallback){
    UserDao.findAllUserInfo(function(result){
        resultCallback(result);
    });
};

/**
 * 新增用户信息
 */
UserService.addUserInfo=function(userInfoPo,resultCallback){
    UserDao.insertUserInfo(userInfoPo,resultCallback)
};

/**
 * 更新用户信息
 */
UserService.updateUserInfo=function(userInfoPo,resultCallback){
    if(!userInfoPo.caId)
        resultCallback(Result.failure("caId is null",Result.TYPE_UPDATE));
    else
        UserDao.updateUserInfo(userInfoPo,resultCallback);
};

/**
 * 删除用户信息
 */
UserService.removeUserInfo=function(caId,resultCallback){
    if(!caId)
        resultCallback(Result.failure("caId is null",Result.TYPE_DELETE));
    else
        UserDao.deleteUserInfo(caId,resultCallback);
};

module.exports = UserService;














