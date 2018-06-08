var BaseDao=require('./BaseDao');

//权限相关dao
var AuthDao=function(){

};
//获取用户拥有的资源
AuthDao.getUserAuthRes=function(resultCallback){
    var sql="select t4.account_id,t1.resource_id,t1.resource_key,t1.resource_name,t1.resource_url from resource t1 " +
        "join resourcelinkrole t2 on t1.resource_id=t2.resource_id " +
        "join role t3 on t2.role_id=t3.role_id and t3.`enable`=1 " +
        "join accountlinkrole t4 on t3.role_id=t4.role_id " +
        "where t1.`enable`=1  ";
    console.log("AuthDao.userAuthRes sql>>>"+sql);
    BaseDao.select(sql,null,resultCallback);
};

module.exports = AuthDao;












