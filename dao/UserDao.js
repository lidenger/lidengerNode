var BaseDao=require('./BaseDao');

var UserDao=function(){};

UserDao.test=function(){
    return BaseDao.test()+"UserDao test>>";
};

/**
 * 查询所有用户信息
 * @param resultCallback 结果回调函数
 */
UserDao.findAllUserInfo=function(resultCallback){
    var sql="select caId,account,name,createTime,instituteNumber from userInfo limit 0,4";
    BaseDao.select(sql,null,resultCallback);
};

/**
 * 存储用户信息
 */
UserDao.insertUserInfo=function(userInfoPo,resultCallback){
    var sql="insert into userInfo(account,name,instituteNumber,createTime,caId)" +
        "values(?,?,?,now(),replace(uuid(),'-',''))";
    BaseDao.insert(sql,[userInfoPo.account,userInfoPo.name,userInfoPo.instituteNumber],function(result){
        resultCallback(result);
    });

};

module.exports = UserDao;





