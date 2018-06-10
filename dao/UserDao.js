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
    var sql="select caId,account,name,createTime,instituteNumber from user_info";
    console.log("UserDao.findAllUserInfo sql>>>"+sql);
    BaseDao.select(sql,null,resultCallback);
};

/**
 * 存储用户信息
 */
UserDao.insertUserInfo=function(userInfoPo,resultCallback){
    var sql="insert into user_info(account,name,instituteNumber,createTime,caId)" +
        "values(?,?,?,now(),replace(uuid(),'-',''))";
    console.log("UserDao.insertUserInfo sql>>>"+sql);
    var params=[userInfoPo.account,userInfoPo.name,userInfoPo.instituteNumber];
    console.log("UserDao.insertUserInfo params>>>"+params);
    BaseDao.insert(sql,params,resultCallback);
};

/**
 * 更新用户信息
 */
UserDao.updateUserInfo=function(userInfoPo,resultCallback){
    var sql="update user_info set ";
    var params=[];
    if(userInfoPo.account){
        sql+="account=?, ";
        params.push(userInfoPo.account);
    }
    if(userInfoPo.name){
        sql+="name=?, ";
        params.push(userInfoPo.name);
    }
    if(userInfoPo.instituteNumber){
        sql+="instituteNumber=?, ";
        params.push(userInfoPo.instituteNumber);
    }
    sql=sql.substring(0,sql.lastIndexOf(","));
    sql+=" where caId=? ";
    console.log("UserDao.updateUserInfo sql>>>"+sql);
    params.push(userInfoPo.caId);
    console.log("UserDao.updateUserInfo params>>>"+params);
    BaseDao.update(sql,params,resultCallback)
};

/**
 * 删除用户信息
 */
UserDao.deleteUserInfo=function(caId,resultCallback){
    var sql="delete from user_info where caId=? ";
    console.log("UserDao.deleteUserInfo sql>>>"+sql);
    BaseDao.delete(sql,[caId],resultCallback);
    console.log("UserDao.deleteUserInfo params>>>"+caId);
};

module.exports = UserDao;





